output "project" {
  description = "Gitlab project"
  value       = one(gitlab_project.this[*])
}

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

#~~~~~~~~~~~~~ access token ~~~~~~~~~~~~~#
output "access_token" {
  description = "Gitlab project access tokens"
  value       = one(gitlab_project_access_token.access_token[*])
}

#~~~~~~~~~~~~~ access tokens ~~~~~~~~~~~~~#
output "access_tokens" {
  description = "Gitlab project access tokens"
  value       = values(gitlab_project_access_token.access_tokens)[*]
}

#~~~~~~~~~~~~~ approval rule ~~~~~~~~~~~~~#
output "approval_rule" {
  description = "Gitlab project approval_rule outcome"
  value       = one(gitlab_project_approval_rule.approval_rule[*])
}

output "approval_rule_id" {
  description = "Gitlab project approval rule id"
  value       = one(gitlab_project_approval_rule.approval_rule[*].id)
}

#~~~~~~~~~~~~~ approval rules ~~~~~~~~~~~~~#
output "approval_rules" {
  description = "Gitlab project approval_rule full outcome"
  value       = values(gitlab_project_approval_rule.approval_rules)[*]
}

output "approval_rules_id" {
  description = "Gitlab project approval rules id"
  value       = values(gitlab_project_approval_rule.approval_rules)[*].id
}

#~~~~~~~~~~~~~ custom attribute ~~~~~~~~~~~~~#
output "custom_attribute" {
  description = "Gitlab project custom attribute full outcome"
  value       = one(gitlab_project_custom_attribute.custom_attribute[*])
}

output "custom_attribute_id" {
  description = "Gitlab project custom attribute id"
  value       = one(gitlab_project_custom_attribute.custom_attribute[*].id)
}

#~~~~~~~~~~~~~ custom attributes ~~~~~~~~~~~~~#
output "custom_attributes" {
  description = "Gitlab project custom attributes full outcome"
  value       = values(gitlab_project_custom_attribute.custom_attributes)[*]
}

output "custom_attributes_id" {
  description = "Gitlab project custom attributes id"
  value       = values(gitlab_project_custom_attribute.custom_attributes)[*].id
}

#~~~~~~~~~~~~~ badge ~~~~~~~~~~~~~#
output "badge" {
  description = "Gitlab project full badge outcome"
  value       = one(gitlab_project_badge.badge[*].id)
}

output "badge_id" {
  description = "Gitlab project badge id"
  value       = one(gitlab_project_badge.badge[*].id)
}

#~~~~~~~~~~~~~ badges ~~~~~~~~~~~~~#
output "badges" {
  description = "Gitlab project full badge outcome"
  value       = values(gitlab_project_badge.badges)[*]
}

output "badges_id" {
  description = "Gitlab project badge id"
  value       = values(gitlab_project_badge.badges)[*].id
}

#~~~~~~~~~~~~~ environment ~~~~~~~~~~~~~#
output "environment" {
  description = "Gitlab project environment full outcome"
  value       = one(gitlab_project_environment.environment[*])
}

output "environment_id" {
  description = "Gitlab project environment id"
  value       = one(gitlab_project_environment.environment[*].id)
}

#~~~~~~~~~~~~~ environments ~~~~~~~~~~~~~#
output "environments" {
  description = "Gitlab project environments full outcome"
  value       = values(gitlab_project_environment.environments)[*]
}

output "environments_id" {
  description = "Gitlab project environments id"
  value       = values(gitlab_project_environment.environments)[*].id
}

#~~~~~~~~~~~~~ freeze period ~~~~~~~~~~~~~#
output "freeze_period" {
  description = "Gitlab project freeze_period id"
  value       = one(gitlab_project_freeze_period.this[*].id)
}

#~~~~~~~~~~~~~ hook ~~~~~~~~~~~~~#
output "hook" {
  description = "Gitlab project hook full result"
  value       = one(gitlab_project_hook.hook[*])
}

output "hook_id" {
  description = "Gitlab project hooks id"
  value       = one(gitlab_project_hook.hook[*].id)
}

#~~~~~~~~~~~~~ hooks ~~~~~~~~~~~~~#
output "hooks" {
  description = "Gitlab project hooks full result"
  value       = values(gitlab_project_hook.hooks)[*]
}

output "hooks_id" {
  description = "Gitlab project hooks id"
  value       = values(gitlab_project_hook.hooks)[*].id
}

#~~~~~~~~~~~~~ issue ~~~~~~~~~~~~~#
output "issue" {
  description = "Gitlab project issues full outcome"
  value       = one(gitlab_project_issue.issue[*])
}

#~~~~~~~~~~~~~ issues ~~~~~~~~~~~~~#
output "issues" {
  description = "Gitlab project issues full outcome"
  value       = values(gitlab_project_issue.issues)[*]
}

#~~~~~~~~~~~~~ issue board ~~~~~~~~~~~~~#
output "issue_board" {
  description = "Gitlab project issuer boards full result"
  value       = one(gitlab_project_issue_board.board[*])
}

output "issue_board_id" {
  description = "Gitlab project issuer board id"
  value       = one(gitlab_project_issue_board.board[*].id)
}

#~~~~~~~~~~~~~ issue boards ~~~~~~~~~~~~~#
output "issue_boards" {
  description = "Gitlab project issuer boards full output"
  value       = values(gitlab_project_issue_board.boards)[*]
}

output "issue_boards_id" {
  description = "Gitlab project issuer boards id"
  value       = values(gitlab_project_issue_board.boards)[*].id
}

#~~~~~~~~~~~~~ job token scope ~~~~~~~~~~~~~#
output "job_token_scope_id" {
  description = "Gitlab project job token scope id"
  value       = one(gitlab_project_job_token_scope.scope[*].id)
}

#~~~~~~~~~~~~~ job token scope ~~~~~~~~~~~~~#
output "job_token_scopes_id" {
  description = "Gitlab project job token scopes id"
  value       = values(gitlab_project_job_token_scope.scopes)[*].id
}

#~~~~~~~~~~~~~ label ~~~~~~~~~~~~~#
output "label" {
  description = "Gitlab project label full result"
  value       = one(gitlab_project_label.label[*])
}

output "label_id" {
  description = "Gitlab project label id"
  value       = one(gitlab_project_label.label[*].id)
}

#~~~~~~~~~~~~~ labels ~~~~~~~~~~~~~#
output "labels" {
  description = "Gitlab project labels full result"
  value       = values(gitlab_project_label.labels)[*]
}

output "labels_id" {
  description = "Gitlab project labels id"
  value       = values(gitlab_project_label.labels)[*].id
}

#~~~~~~~~~~~~~ level mr approvals id ~~~~~~~~~~~~~#
output "level_mr_approvals_id" {
  description = "Gitlab project level mr aprrovals id"
  value       = one(gitlab_project_level_mr_approvals.this[*].id)
}

#~~~~~~~~~~~~~ membership id ~~~~~~~~~~~~~#
output "membership_id" {
  description = "Gitlab project membership id"
  value       = one(gitlab_project_membership.membership[*].id)
}

#~~~~~~~~~~~~~ memberships id ~~~~~~~~~~~~~#
output "memberships_id" {
  description = "Gitlab project memberships id"
  value       = values(gitlab_project_membership.memberships)[*].id
}

#~~~~~~~~~~~~~ milestone ~~~~~~~~~~~~~#
output "milestone" {
  description = "Gitlab project milestone full outcome"
  value       = one(gitlab_project_milestone.milestone[*])
}

#~~~~~~~~~~~~~ milestones ~~~~~~~~~~~~~#
output "milestones" {
  description = "Gitlab project milestones full outcome"
  value       = values(gitlab_project_milestone.milestones)[*]
}

#~~~~~~~~~~~~~ mirror ~~~~~~~~~~~~~#
output "mirror" {
  description = "Gitlab project mirror"
  value       = one(gitlab_project_mirror.this)[*]
}

#~~~~~~~~~~~~~ protected environment ~~~~~~~~~~~~~#
output "protected_environment_id" {
  description = "Gitlab project protected environment id"
  value       = one(gitlab_project_protected_environment.environment[*].id)
}

#~~~~~~~~~~~~~ protected environments ~~~~~~~~~~~~~#
output "protected_environments_id" {
  description = "Gitlab project protected environments id"
  value       = values(gitlab_project_protected_environment.environments)[*].id
}

#~~~~~~~~~~~~~ enabled runner ~~~~~~~~~~~~~#
output "runner_enablement_id" {
  description = "Enabled runner id"
  value       = one(gitlab_project_runner_enablement.runner[*].id)
}

#~~~~~~~~~~~~~ enabled runners ~~~~~~~~~~~~~#
output "runners_enablement_id" {
  description = "Enabled runners id"
  value       = values(gitlab_project_runner_enablement.runners)[*].id
}

#~~~~~~~~~~~~~ share group ~~~~~~~~~~~~~#
output "share_group_id" {
  description = "Gitlab project shared group id"
  value       = one(gitlab_project_share_group.group[*].id)
}

#~~~~~~~~~~~~~ share groups ~~~~~~~~~~~~~#
output "share_groups_id" {
  description = "Gitlab project shared groups id"
  value       = values(gitlab_project_share_group.groups)[*].id
}

/*
#~~~~~~~~~~~~~ tag ~~~~~~~~~~~~~#
output "tag_id" {
  description = "Gitlab project tag id"
  value       = one(gitlab_project_tag.tag[*].id)
}

#~~~~~~~~~~~~~ tags ~~~~~~~~~~~~~#
output "tags_id" {
  description = "Gitlab project tags id"
  value       = values(gitlab_project_tag.tags)[*].id
}

#~~~~~~~~~~~~~ protected tag ~~~~~~~~~~~~~#
output "protected_tag" {
  description = "Gitlab project protected tag id"
  value       = one(gitlab_tag_protection.tag[*].id)
}

#~~~~~~~~~~~~~ protected tags ~~~~~~~~~~~~~#
output "protected_tags" {
  description = "Gitlab project protected tags"
  value       = values(gitlab_tag_protection.tags)[*].id
}
*/

#~~~~~~~~~~~~~ variable ~~~~~~~~~~~~~#
output "variable_id" {
  description = "Gitlab project variable id"
  value       = one(gitlab_project_variable.variable[*].id)
}

#~~~~~~~~~~~~~ variables ~~~~~~~~~~~~~#
output "variables_id" {
  description = "Gitlab project variable id"
  value       = values(gitlab_project_variable.variables)[*].id
}

#~~~~~~~~~~~~~ deploy key ~~~~~~~~~~~~~#
output "deploy_key" {
  description = "Gitlab project deploy key full outcome"
  value       = one(gitlab_deploy_key.key[*])
}

#~~~~~~~~~~~~~ deploy keys ~~~~~~~~~~~~~#
output "deploy_keys" {
  description = "Gitlab project deploy keys full outcome"
  value       = values(gitlab_deploy_key.keys)[*].id
}

#~~~~~~~~~~~~~ deploy token ~~~~~~~~~~~~~#
output "deploy_token" {
  description = "Gitlab project deploy token full outcome"
  value       = one(gitlab_deploy_token.token[*])
}

#~~~~~~~~~~~~~ deploy tokens ~~~~~~~~~~~~~#
output "deploy_tokens" {
  description = "Gitlab project deploy tokens full outcome"
  value       = values(gitlab_deploy_token.tokens)[*]
}

#~~~~~~~~~~~~~ page domain ~~~~~~~~~~~~~#
output "pages_domain" {
  description = "Gitlab project pages domain"
  value       = one(gitlab_pages_domain.this[*])
}

#~~~~~~~~~~~~~ pipeline schedule ~~~~~~~~~~~~~#
output "pipeline_schedule" {
  description = "Gitlab project schedule pipeline full outcome"
  value       = one(gitlab_pipeline_schedule.schedule[*])
}

#~~~~~~~~~~~~~ pipeline schedules ~~~~~~~~~~~~~#
output "pipeline_schedules" {
  description = "Gitlab project schedule pipelines full outcome"
  value       = values(gitlab_pipeline_schedule.schedules)[*]
}


// output "pipeline_schedule_variables_id" {
//   description = "Gitlab project schedule pipelines variables id"
//   value       = values(gitlab_pipeline_schedule_variable.this)[*].id
// }

#~~~~~~~~~~~~~ branch ~~~~~~~~~~~~~#
output "branch" {
  description = "Gitlab project branch full outcome"
  value       = one(gitlab_branch.branch[*])
}

output "branch_id" {
  description = "Gitlab project branch id"
  value       = one(gitlab_branch.branch[*].id)
}

#~~~~~~~~~~~~~ branches ~~~~~~~~~~~~~#
output "branches" {
  description = "Gitlab project branches"
  value       = values(gitlab_branch.branches)[*]
}

output "branches_id" {
  description = "Gitlab project branches id"
  value       = values(gitlab_branch.branches)[*].id
}

#~~~~~~~~~~~~~ pipeline trigger ~~~~~~~~~~~~~#
output "pipeline_trigger" {
  description = "Gitlab project pipeline trigger full outcome"
  value       = one(gitlab_pipeline_trigger.trigger[*])
}

#~~~~~~~~~~~~~ pipeline triggers ~~~~~~~~~~~~~#
output "pipeline_triggers" {
  description = "Gitlab project pipeline triggers full outcome"
  value       = values(gitlab_pipeline_trigger.triggers)[*]
}

#~~~~~~~~~~~~~ repository file ~~~~~~~~~~~~~#
output "repository_file_id" {
  description = "Gitlab project file id"
  value       = one(gitlab_repository_file.file[*].file_path)
}

#~~~~~~~~~~~~~ repository files ~~~~~~~~~~~~~#
output "repository_files_id" {
  description = "Gitlab project files id"
  value       = values(gitlab_repository_file.files)[*].file_path
}

output "cluster_agent" {
  description = "Gitlab project cluster agent and cluster agent token"
  value = merge(
    one(gitlab_cluster_agent.this[*].id),
    one(gitlab_cluster_agent_token.this[*].id)
  )
}

output "release_link" {
  description = "Gitlab project release link full outcome"
  value       = one(gitlab_release_link.link[*])
}

output "release_links" {
  description = "Gitlab project release links full outcome"
  value       = values(gitlab_release_link.links)[*]
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