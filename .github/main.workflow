workflow "Hugo Link Check" {
  resolves = "linkcheck"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "linkcheck" {
  uses = "docker://marc/hugo-linkcheck:master"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    HUGO_CONFIG = "./hugo-config/enterpriseready.toml"
    HUGO_ROOT = "./site"
  }
}
