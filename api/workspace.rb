# A workspace is a minimal docker container with just the material in it.
# It persists for the lifetime of a pipeline run.
# It mounts a volume with a deploy key for the git repo
class Workspace
  def initialize(pipeline:)
    pipeline
  end

  def run
    update_git_cache
  end

  def update_git_cache
    # run git fetch for the corresponding pipeline
  end

  def execute_stage(stage:)
    #
  end
end
