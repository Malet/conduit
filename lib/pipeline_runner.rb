require 'fileutils'
require 'pty'
require 'shellwords'

class PipelineRunner
  def initialize(pipeline)
    @pipeline = pipeline
  end

  def run
    pipeline_counter = Redis.current.incr("pipeline:#{@pipeline.id}:build")

    # Create workspace directory <pipeline>/<build>/<run>
    FileUtils.mkdir_p(
      File.join(WORKSPACE_DIR, @pipeline.id, pipeline_counter.to_s)
    )

    # Get or update the material
    command(%(./bin/git-getter.sh #{@pipeline.repository_url}))

    # Run the command in our agent image with --rm
    container_name = [@pipeline.id, pipeline_counter.to_s].join('_')

    command(
      %(./bin/runner.sh #{container_name} #{@pipeline.repository_url}),
      env: {
        CONTAINER_NAME: container_name,
        COMMAND: 'echo "hello world"',
        PIPELINE_ID: @pipeline.id,
        PIPELINE_COUNTER: pipeline_counter,
        MATERIAL_DIR: File.join('git_cache', @pipeline.repository_url),
      }
    )
  end

  private

  def env_string(env)
    env.keys.sort.map do |key|
      %(#{key}='#{env[key]}' \\\n)
    end.join
  end

  def command(command, env: {}, silent: false)
    command_with_env = "#{env_string(env)}#{command}"
    puts "Running `#{command_with_env}` in #{Dir.pwd}"
    buffer = ''
    PTY.spawn(command_with_env) do |stdout, stdin, pid|
      stdout.each_char do |char|
        print char unless silent
        buffer << char
      end rescue Errno::EIO
      Process.wait(pid)
    end
    status_code = $?.exitstatus

    throw RuntimeError.new("exit code was #{status_code}") if !silent && status_code != 0

    return { stdout: buffer, status_code: status_code }
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end
