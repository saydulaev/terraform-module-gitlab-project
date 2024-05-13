output "id" {
  description = "Gitlab project id"
  value       = one(gitlab_project.this[*].id)
}

output "http_url_to_repo" {
  description = "Gitlab project http url to git clone"
  value       = one(gitlab_project.this[*].http_url_to_repo)
}

output "ssh_url_to_repo" {
  description = "Gitlab project ssh url to git clone"
  value       = one(gitlab_project.this[*].ssh_url_to_repo)
}

output "web_url" {
  description = "Gitlab project web url"
  value       = one(gitlab_project.this[*].web_url)
}

output "path_with_namespace" {
  description = "The path of the repository with namespace."
  value       = one(gitlab_project.this[*].path_with_namespace)
}

output "runners_token" {
  description = "Registration token to use during runner setup."
  value       = one(gitlab_project.this[*].runners_token)
}

output "compliance_frameworks_id" {
  value = values(gitlab_project_compliance_framework.this)[*].id
}

output "access_tokens" {
  description = "Gitlab project access tokens"
  value = {
    for token in var.access_tokens :
    token.name => {
      id         = gitlab_project_access_token.this[token.name].id,
      active     = gitlab_project_access_token.this[token.name].active,
      token      = gitlab_project_access_token.this[token.name].token,
      user_id    = gitlab_project_access_token.this[token.name].user_id,
      revoked    = gitlab_project_access_token.this[token.name].revoked,
      created_at = gitlab_project_access_token.this[token.name].created_at
    } if length(var.access_tokens) > 0
  }
}

// approval_rules
output "approval_rules_id" {
  description = ""
  value       = values(gitlab_project_approval_rule.this)[*].id
}

// badges
output "custom_attributes" {
  description = "Gitlab project custom attributes"
  value       = values(gitlab_project_custom_attribute.this)[*].id
}

output "badges" {
  description = "Gitlab project badges id"
  value       = values(gitlab_project_badge.this)[*].id
}

output "environments_id" {
  description = "Gitlab project environments id"
  value       = values(gitlab_project_environment.this)[*].id
}

output "freeze_period" {
  description = "Gitlab project freeze_period id"
  value       = one(gitlab_project_freeze_period.this[*].id)
}

output "hooks_id" {
  description = "Gitlab project hooks id"
  value       = values(gitlab_project_hook.this)[*].id
}

output "issues" {
  description = "Gitlab project issues"
  value = [
    for issue in var.issues : gitlab_project_issue.this[issue.title]
    if length(var.issues) > 0
  ]
}

output "issue_boards_id" {
  description = "Gitlab project issuer boards id"
  value       = values(gitlab_project_issue_board.this)[*].id
}

output "job_token_scopes_id" {
  description = "Gitlab project job token scopes id"
  value       = values(gitlab_project_job_token_scope.this)[*].id
}

output "labels" {
  description = "Gitlab project labels"
  value = {
    for label in var.labels : label.name => gitlab_project_label.this[label.name]
    if length(var.labels) > 0
  }
}

output "level_mr_approvals_id" {
  description = "Gitlab project level mr aprrovals id"
  value       = one(gitlab_project_level_mr_approvals.this[*].id)
}

output "membership_id" {
  description = "Gitlab project membership ids"
  value       = values(gitlab_project_membership.this)[*].id
}

output "milestones" {
  description = "Gitlab project milestones"
  value = {
    for milestone in var.milestones : milestone.title => gitlab_project_milestone.this[milestone.title]
    if length(var.milestones) > 0
  }
}

output "mirror" {
  description = "Gitlab project mirror"
  value       = one(gitlab_project_mirror.this)[*]
}

output "protected_environment_id" {
  description = "Gitlab project protected environment"
  value       = values(gitlab_project_protected_environment.this)[*].id
}

output "runner_enablement_id" {
  description = "Enabled runners id"
  value       = values(gitlab_project_runner_enablement.this)[*].id
}

output "share_group" {
  description = "Gitlab project shared group id"
  value       = values(gitlab_project_share_group.this)[*].id
}

output "tags" {
  description = "Gitlab project tags"
  value = {
    for tag in var.tags : tag.name => gitlab_project_tag.this[tag.name]
    if length(var.tags) > 0
  }
}

output "protected_tags" {
  description = "Gitlab project protected tags"
  value = {
    for tag in var.tags : tag.name => gitlab_tag_protection.this[tag.name]
    if length(var.tags) > 0 && tag.protected == true
  }
}

output "variables_id" {
  description = "Gitlab project variables id"
  value       = values(gitlab_project_variable.this)[*].id
}

output "deploy_keys" {
  description = "Gitlab project deploy keys"
  value = {
    for key in var.deploy_keys : key.title => gitlab_deploy_key.this[key.title]
    if length(var.deploy_keys) > 0
  }
}

output "deploy_token" {
  description = "Gitlab project deploy tokens"
  value = {
    for token in var.deploy_tokens : token.name => gitlab_deploy_token.this[token.name]
    if length(var.deploy_tokens) > 0
  }
}

output "pages_domain" {
  description = "Gitlab project pages domain"
  value       = one(gitlab_pages_domain.this[*])
}

output "pipeline_schedule" {
  description = "Gitlab project schedule pipelines"
  value = {
    for pipeline in var.pipeline_schedule : pipeline.ref => gitlab_pipeline_schedule.this[pipeline.ref]
    if length(var.pipeline_schedule) > 0
  }
}

output "pipeline_schedule_variables_id" {
  description = "Gitlab project schedule pipelines variables id"
  value       = values(gitlab_pipeline_schedule_variable.this)[*].id
}

output "branches" {
  description = "Gitlab project branches"
  value = {
    for branch in var.branches : branch.name => gitlab_branch.this[branch.name]
  }
}

output "branches_id" {
  description = "Gitlab project branches id"
  value       = values(gitlab_branch.this)[*].id
}

output "pipeline_triggers" {
  description = "Gitlab project pipeline triggers"
  value = length(var.pipeline_triggers) > 0 ? {
    for trigger in var.pipeline_triggers : trigger.description => gitlab_pipeline_trigger.this[trigger.description]
  } : {}
}

output "repository_files" {
  description = "Gitlab project files"
  value = length(var.repository_files) > 0 ? {
    for f in var.repository_files : f.file_path => gitlab_repository_file.this[f.file_path]
  } : {}
}

output "cluster_agent" {
  description = "Gitlab project cluster agent and cluster agent token"
  value = merge(
    one(gitlab_cluster_agent.this[*].id),
    one(gitlab_cluster_agent_token.this[*].id)
  )
}


output "integration_custom_issue_tracker" {
  description = "Gitlab project custom integration issue tracker"
  value       = one(gitlab_integration_custom_issue_tracker.this[*])
}

output "integration_emails_on_push" {
  description = "Gitlab project custom email on push service"
  value       = one(gitlab_integration_emails_on_push.this[*])
}

output "integration_external_wiki" {
  description = "Gitlab project external wiki"
  value       = one(gitlab_integration_external_wiki.this[*])
}

output "integration_github" {
  description = "Gitlab project Github intergation"
  value       = one(gitlab_integration_github.this[*])
}

output "integration_jira" {
  description = "Gitlab project Jira intergration"
  value       = one(gitlab_integration_jira.this[*])
}

output "integration_mattermost_id" {
  description = "Gitlab project Mattermost integration"
  value       = one(gitlab_integration_mattermost.this[*].id)
}

output "integration_microsoft_teams" {
  description = "Gitlab project Microsoft Teams integration"
  value       = one(gitlab_integration_microsoft_teams.this[*])
}

output "integration_pipelines_email_id" {
  description = "Gitlab project pipeline email integration"
  value       = one(gitlab_integration_pipelines_email.this[*].id)
}

output "integration_slack_id" {
  description = "Gitlab project Slack integration"
  value       = one(gitlab_integration_slack.this[*].id)
}