data "github_repository" "test" {
  full_name = "zippedydoodah/test"
}

data "github_repository" "commit-auto-releaser" {
  full_name = "zippedydoodah/commit-auto-releaser"
}

data "github_repository" "action-simple-consumer" {
  full_name = "zippedydoodah/action-simple-consumer"
}

resource "github_actions_runner_group" "a-group" {
  name       = "a-group"
  visibility = "selected"
  selected_repository_ids = [
    data.github_repository.test.repo_id,
    data.github_repository.commit-auto-releaser.repo_id,
    data.github_repository.action-simple-consumer.repo_id
  ]
}

data "github_repository" "action-first-level" {
  full_name = "zippedydoodah/action-first-level"
}

data "github_repository" "action-simple-docker" {
  full_name = "zippedydoodah/action-simple-docker"
}

data "github_repository" "action-simple-js" {
  full_name = "zippedydoodah/action-simple-js"
}

resource "github_actions_runner_group" "b-group" {
  name       = "b-group"
  visibility = "selected"
  selected_repository_ids = [
    data.github_repository.action-first-level.repo_id,
    data.github_repository.action-simple-docker.repo_id,
    data.github_repository.action-simple-js.repo_id
  ]
}
