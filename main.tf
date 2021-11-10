# Auto generation - don't modify, modify .yaml files instead
data "github_repository" "this" {
  for_each  = toset(flatten(local.repos))
  full_name = "zippedydoodah/${each.value}"
}

resource "github_actions_runner_group" "this" {
  for_each   = { for group in local.groups : group.name => group }
  name       = each.key
  visibility = "selected"
  selected_repository_ids = [for v in each.value.repos : data.github_repository.this[v].repo_id]
}

locals {
  repos = [for f in fileset("./groups", "*.yaml") : yamldecode(file("./groups/${f}"))]
  groups = [for f in fileset("./groups", "*.yaml") :
    merge(
      { "name" = trimsuffix(f, ".yaml") },
      { "repos" = toset(yamldecode(file("./groups/${f}"))) }
    )
  ]
}
