data "gitlab_groups" "this" {}

data "gitlab_users" "this" {
  active = true
}

data "gitlab_current_user" "this" {}

locals {
  exists_users  = { for user in data.gitlab_users.this.users : user.username => user }
  exists_groups = { for group in data.gitlab_groups.this.groups : group.name => group }
}

resource "gitlab_project" "this" {
  count = var.project != null ? 1 : 0

  name                                   = var.project.name
  allow_merge_on_skipped_pipeline        = var.project.allow_merge_on_skipped_pipeline
  analytics_access_level                 = var.project.analytics_access_level
  archive_on_destroy                     = var.project.archive_on_destroy
  archived                               = var.project.archived
  auto_cancel_pending_pipelines          = var.project.auto_cancel_pending_pipelines
  auto_devops_deploy_strategy            = var.project.auto_devops_deploy_strategy
  auto_devops_enabled                    = var.project.auto_devops_enabled
  autoclose_referenced_issues            = var.project.autoclose_referenced_issues
  avatar                                 = var.project.avatar
  avatar_hash                            = var.project.avatar_hash
  build_git_strategy                     = var.project.build_git_strategy
  build_timeout                          = var.project.build_timeout
  builds_access_level                    = var.project.builds_access_level
  ci_config_path                         = var.project.ci_config_path
  ci_default_git_depth                   = var.project.ci_default_git_depth
  ci_forward_deployment_enabled          = var.project.ci_forward_deployment_enabled
  ci_restrict_pipeline_cancellation_role = var.project.ci_restrict_pipeline_cancellation_role
  ci_separated_caches                    = var.project.ci_separated_caches
  dynamic "container_expiration_policy" {
    for_each = length(try(var.project.container_expiration_policy, [])) > 0 ? var.project.container_expiration_policy : []
    iterator = policy
    content {
      cadence           = policy.value.cadence
      enabled           = policy.value.enabled
      keep_n            = policy.value.keep_n
      name_regex_delete = policy.value.name_regex_delete
      name_regex_keep   = policy.value.name_regex_keep
      older_than        = policy.value.older_than
    }
  }
  container_registry_access_level                  = var.project.container_registry_access_level
  default_branch                                   = var.project.default_branch
  description                                      = var.project.description
  emails_enabled                                   = var.project.emails_enabled
  environments_access_level                        = var.project.environments_access_level
  external_authorization_classification_label      = var.project.external_authorization_classification_label
  feature_flags_access_level                       = var.project.feature_flags_access_level
  forked_from_project_id                           = var.project.forked_from_project_id
  forking_access_level                             = var.project.forking_access_level
  group_runners_enabled                            = var.project.group_runners_enabled
  group_with_project_templates_id                  = var.project.group_with_project_templates_id
  import_url                                       = var.project.import_url
  import_url_password                              = var.project.import_url_password
  import_url_username                              = var.project.import_url_username
  infrastructure_access_level                      = var.project.infrastructure_access_level
  initialize_with_readme                           = var.project.initialize_with_readme
  issues_access_level                              = var.project.issues_access_level
  issues_enabled                                   = var.project.issues_enabled
  issues_template                                  = var.project.issues_template
  keep_latest_artifact                             = var.project.keep_latest_artifact
  lfs_enabled                                      = var.project.lfs_enabled
  merge_commit_template                            = var.project.merge_commit_template
  merge_method                                     = var.project.merge_method
  merge_pipelines_enabled                          = var.project.merge_pipelines_enabled
  merge_requests_access_level                      = var.project.merge_requests_access_level
  merge_requests_enabled                           = var.project.merge_requests_enabled
  merge_requests_template                          = var.project.merge_requests_template
  merge_trains_enabled                             = var.project.merge_trains_enabled
  mirror                                           = var.project.mirror
  mirror_overwrites_diverged_branches              = var.project.mirror_overwrites_diverged_branches
  mirror_trigger_builds                            = var.project.mirror_trigger_builds
  monitor_access_level                             = var.project.monitor_access_level
  mr_default_target_self                           = var.project.mr_default_target_self
  namespace_id                                     = var.project.namespace_id // != null ? local.exists_groups[each.value.namespace_id].group_id : null
  only_allow_merge_if_all_discussions_are_resolved = var.project.only_allow_merge_if_all_discussions_are_resolved
  only_allow_merge_if_pipeline_succeeds            = var.project.only_allow_merge_if_pipeline_succeeds
  only_mirror_protected_branches                   = var.project.only_mirror_protected_branches
  packages_enabled                                 = var.project.packages_enabled
  pages_access_level                               = var.project.pages_access_level
  path                                             = var.project.path
  printing_merge_request_link_enabled              = var.project.printing_merge_request_link_enabled
  public_jobs                                      = var.project.public_jobs
  dynamic "push_rules" {
    for_each = length(var.project.push_rules) > 0 ? toset(var.project.push_rules) : []
    iterator = rule
    content {
      author_email_regex            = try(rule.value.author_email_regex, null)
      branch_name_regex             = try(rule.value.branch_name_regex, null)
      commit_committer_check        = try(rule.value.commit_committer_check, null)
      commit_message_negative_regex = try(rule.value.commit_message_negative_regex, null)
      commit_message_regex          = try(rule.value.commit_message_regex, null)
      deny_delete_tag               = try(rule.value.deny_delete_tag, null)
      file_name_regex               = try(rule.value.file_name_regex, null)
      max_file_size                 = try(rule.value.max_file_size, null)
      member_check                  = try(rule.value.member_check, null)
      prevent_secrets               = try(rule.value.prevent_secrets, null)
      reject_unsigned_commits       = try(rule.value.reject_unsigned_commits, null)
    }
  }
  releases_access_level                   = var.project.releases_access_level
  remove_source_branch_after_merge        = var.project.remove_source_branch_after_merge
  repository_access_level                 = var.project.repository_access_level
  repository_storage                      = var.project.repository_storage
  request_access_enabled                  = var.project.request_access_enabled
  requirements_access_level               = var.project.requirements_access_level
  resolve_outdated_diff_discussions       = var.project.resolve_outdated_diff_discussions
  restrict_user_defined_variables         = var.project.restrict_user_defined_variables
  security_and_compliance_access_level    = var.project.security_and_compliance_access_level
  shared_runners_enabled                  = var.project.shared_runners_enabled
  skip_wait_for_default_branch_protection = var.project.skip_wait_for_default_branch_protection
  snippets_access_level                   = var.project.snippets_access_level
  snippets_enabled                        = var.project.snippets_enabled
  squash_commit_template                  = var.project.squash_commit_template
  squash_option                           = var.project.squash_option
  suggestion_commit_message               = var.project.suggestion_commit_message
  tags                                    = var.project.tags
  template_name                           = var.project.template_name
  template_project_id                     = var.project.template_project_id
  dynamic "timeouts" {
    for_each = length(var.project.timeouts) > 0 ? toset(var.project.timeouts) : []
    iterator = rule
    content {
      create = try(rule.value.create, null)
      delete = try(rule.value.delete, null)
    }
  }
  topics              = var.project.topics
  use_custom_template = var.project.use_custom_template
  visibility_level    = var.project.visibility_level
  wiki_access_level   = var.project.wiki_access_level
  wiki_enabled        = var.project.wiki_enabled
}

data "gitlab_projects" "this" {
  depends_on = [
    gitlab_project.this
  ]
}

locals {
  _projects = { for project in data.gitlab_projects.this.projects : project.name => project }
}

resource "gitlab_project_access_token" "access_token" {
  count = var.access_token != null ? 1 : 0

  project      = coalesce(local._projects[var.access_token.project].id, var.access_token.project)
  name         = var.access_token.name
  scopes       = var.access_token.scopes
  access_level = var.access_token.access_level
  expires_at   = var.access_token.expires_at
  rotation_configuration = var.access_token.rotation_configuration != null ? {
    expiration_days    = try(var.access_token.rotation_configuration.expiration_days, null)
    rotate_before_days = try(var.access_token.rotation_configuration.rotate_before_days, null)
  } : null
}

resource "gitlab_project_access_token" "access_tokens" {
  for_each = {
    for token in var.access_tokens : token.name => token
    if length(var.access_tokens) > 0
  }

  project      = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  name         = each.value.name
  scopes       = each.value.scopes
  access_level = each.value.access_level
  expires_at   = each.value.expires_at
  rotation_configuration = each.value.rotation_configuration != null ? {
    expiration_days    = try(each.value.rotation_configuration.expiration_days, null)
    rotate_before_days = try(each.value.rotation_configuration.rotate_before_days, null)
  } : null
}


resource "gitlab_project_approval_rule" "approval_rule" {
  count = var.approval_rule != null && contains(["premium", "ultimate"], lower(var.tier)) ? 1 : 0

  project                                               = coalesce(local._projects[var.approval_rule.project].id, var.approval_rule.project_id)
  name                                                  = var.approval_rule.name
  approvals_required                                    = var.approval_rule.approvals_required
  applies_to_all_protected_branches                     = var.approval_rule.applies_to_all_protected_branches
  disable_importing_default_any_approver_rule_on_create = var.approval_rule.disable_importing_default_any_approver_rule_on_create
  user_ids                                              = length(var.approval_rule.user_ids) > 0 ? [for user in var.approval_rule.user_ids : local.exists_users[user].id] : null
  group_ids                                             = length(var.approval_rule.group_ids) > 0 ? [for group in var.approval_rule.group_ids : local.exists_groups[group].group_id] : null
  // protected_branch_ids                               = length(var.approval_rule.protected_branch_ids) > 0 ? [for branch in var.approval_rule.protected_branch_ids : local.project_branches[branch].id ] : null
  rule_type = var.approval_rule.rule_type
}

resource "gitlab_project_approval_rule" "approval_rules" {
  for_each = {
    for rule in var.approval_rules : rule.name => rule
    if length(var.approval_rules) > 0 && contains(["premium", "ultimate"], lower(var.tier))
  }

  project                                               = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  name                                                  = each.value.name
  approvals_required                                    = each.value.approvals_required
  applies_to_all_protected_branches                     = each.value.applies_to_all_protected_branches
  disable_importing_default_any_approver_rule_on_create = each.value.disable_importing_default_any_approver_rule_on_create
  user_ids                                              = length(each.value.user_ids) > 0 ? [for user in each.value.user_ids : local.exists_users[user].id] : null
  group_ids                                             = length(each.value.group_ids) > 0 ? [for group in each.value.group_ids : local.exists_groups[group].group_id] : null
  // protected_branch_ids                               = length(each.value.protected_branch_ids) > 0 ? [for branch in each.value.protected_branch_ids : local.project_branches[branch].id ] : null
  rule_type = each.value.rule_type
}

resource "gitlab_project_badge" "badge" {
  count = var.badge != null ? 1 : 0

  project   = coalesce(local._projects[var.badge.project].id, var.badge.project_id)
  link_url  = var.badge.link_url
  image_url = var.badge.image_url
  name      = var.badge.name
}

resource "gitlab_project_badge" "badges" {
  for_each = {
    for badge in var.badges : badge.link_url => badge
    if length(var.badges) > 0
  }

  project   = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  link_url  = each.value.link_url
  image_url = each.value.image_url
  name      = each.value.name
}

resource "gitlab_project_custom_attribute" "custom_attribute" {
  count = var.custom_attribute != null ? 1 : 0

  project = coalesce(local._projects[var.custom_attribute.project].id, var.custom_attribute.project_id)
  key     = var.custom_attribute.key
  value   = var.custom_attribute.value
}

resource "gitlab_project_custom_attribute" "custom_attributes" {
  for_each = {
    for attr in var.custom_attributes : attr.key => attr
    if length(var.custom_attributes) > 0
  }

  project = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  key     = each.value.key
  value   = each.value.value
}

resource "gitlab_project_environment" "environment" {
  count = var.environment != null ? 1 : 0

  project             = coalesce(local._projects[var.environment.project].id, var.environment.project_id)
  name                = var.environment.name
  external_url        = var.environment.external_url
  stop_before_destroy = var.environment.stop_before_destroy
}

resource "gitlab_project_environment" "environments" {
  for_each = {
    for env in var.environments : env.name => env
    if length(var.environments) > 0
  }

  project             = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  name                = each.value.name
  external_url        = each.value.external_url
  stop_before_destroy = each.value.stop_before_destroy
}

resource "gitlab_project_freeze_period" "this" {
  count = var.freeze_period != null ? 1 : 0

  project       = coalesce(local._projects[var.freeze_period.project].id, one(gitlab_project.this[*].id))
  freeze_start  = var.freeze_period.freeze_start
  freeze_end    = var.freeze_period.freeze_end
  cron_timezone = var.freeze_period.cron_timezone
}

resource "gitlab_project_hook" "hook" {
  count = var.hook != null ? 1 : 0

  project                    = coalesce(local._projects[var.hook.project].id, var.hook.project, one(gitlab_project.this[*].id))
  url                        = var.hook.url
  confidential_issues_events = var.hook.confidential_issues_events // can(tobool(each.value.confidential_issues_events)) ? each.value.confidential_issues_events : false
  confidential_note_events   = var.hook.confidential_note_events   // can(tobool(each.value.confidential_note_events)) ? each.value.confidential_note_events : false
  custom_webhook_template    = var.hook.custom_webhook_template    // can(tobool(each.value.custom_webhook_template)) ? each.value.custom_webhook_template : false
  deployment_events          = var.hook.deployment_events          // can(tobool(each.value.deployment_events)) ? each.value.deployment_events : false
  enable_ssl_verification    = var.hook.enable_ssl_verification    // can(tobool(each.value.enable_ssl_verification)) ? each.value.enable_ssl_verification : false
  issues_events              = var.hook.issues_events              // can(tobool(each.value.issues_events)) ? each.value.issues_events : false
  job_events                 = var.hook.job_events                 // can(tobool(each.value.job_events)) ? each.value.job_events : false
  merge_requests_events      = var.hook.merge_requests_events      // can(tobool(each.value.merge_requests_events)) ? each.value.merge_requests_events : false
  note_events                = var.hook.note_events                // can(tobool(each.value.note_events)) ? each.value.note_events : false
  pipeline_events            = var.hook.pipeline_events            // can(tobool(each.value.pipeline_events)) ? each.value.pipeline_events : false
  push_events                = var.hook.push_events                // can(tobool(each.value.push_events)) ? each.value.push_events : false
  push_events_branch_filter  = var.hook.push_events_branch_filter  // can(tobool(each.value.push_events_branch_filter)) ? each.value.push_events_branch_filter : false
  releases_events            = var.hook.releases_events            // can(tobool(each.value.releases_events)) ? each.value.releases_events : false
  tag_push_events            = var.hook.tag_push_events            // can(tobool(each.value.tag_push_events)) ? each.value.tag_push_events : false
  token                      = var.hook.token                      // each.value.token
  wiki_page_events           = var.hook.wiki_page_events           // can(tobool(each.value.wiki_page_events)) ? each.value.wiki_page_events : false
}

resource "gitlab_project_hook" "hooks" {
  for_each = {
    for hook in var.hooks : hook.url => hook
    if length(var.hooks) > 0 && contains(["premium", "ultimate"], lower(var.tier))
  }

  project                    = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  url                        = each.value.url
  confidential_issues_events = each.value.confidential_issues_events // can(tobool(each.value.confidential_issues_events)) ? each.value.confidential_issues_events : false
  confidential_note_events   = each.value.confidential_note_events   // can(tobool(each.value.confidential_note_events)) ? each.value.confidential_note_events : false
  custom_webhook_template    = each.value.custom_webhook_template    // can(tobool(each.value.custom_webhook_template)) ? each.value.custom_webhook_template : false
  deployment_events          = each.value.deployment_events          // can(tobool(each.value.deployment_events)) ? each.value.deployment_events : false
  enable_ssl_verification    = each.value.enable_ssl_verification    // can(tobool(each.value.enable_ssl_verification)) ? each.value.enable_ssl_verification : false
  issues_events              = each.value.issues_events              // can(tobool(each.value.issues_events)) ? each.value.issues_events : false
  job_events                 = each.value.job_events                 // can(tobool(each.value.job_events)) ? each.value.job_events : false
  merge_requests_events      = each.value.merge_requests_events      // can(tobool(each.value.merge_requests_events)) ? each.value.merge_requests_events : false
  note_events                = each.value.note_events                // can(tobool(each.value.note_events)) ? each.value.note_events : false
  pipeline_events            = each.value.pipeline_events            // can(tobool(each.value.pipeline_events)) ? each.value.pipeline_events : false
  push_events                = each.value.push_events                // can(tobool(each.value.push_events)) ? each.value.push_events : false
  push_events_branch_filter  = each.value.push_events_branch_filter  // can(tobool(each.value.push_events_branch_filter)) ? each.value.push_events_branch_filter : false
  releases_events            = each.value.releases_events            // can(tobool(each.value.releases_events)) ? each.value.releases_events : false
  tag_push_events            = each.value.tag_push_events            // can(tobool(each.value.tag_push_events)) ? each.value.tag_push_events : false
  token                      = each.value.token                      // each.value.token
  wiki_page_events           = each.value.wiki_page_events           // can(tobool(each.value.wiki_page_events)) ? each.value.wiki_page_events : false
}

resource "gitlab_project_issue" "issue" {
  count = var.issue != null ? 1 : 0

  project                                 = coalesce(local._projects[var.issue.project].id, one(gitlab_project.this[*].id), var.issue.project)
  title                                   = var.issue.title
  assignee_ids                            = var.issue.assignee_ids
  confidential                            = var.issue.confidential
  created_at                              = var.issue.created_at
  delete_on_destroy                       = var.issue.delete_on_destroy
  description                             = "Welcome to the ${var.issue.project} project!"
  discussion_locked                       = var.issue.discussion_locked // true
  discussion_to_resolve                   = var.issue.discussion_to_resolve
  due_date                                = var.issue.due_date
  epic_issue_id                           = var.issue.epic_issue_id
  iid                                     = var.issue.iid
  issue_type                              = var.issue.issue_type
  labels                                  = var.issue.labels
  merge_request_to_resolve_discussions_of = var.issue.merge_request_to_resolve_discussions_of
  milestone_id                            = var.issue.milestone_id
  state                                   = var.issue.state
  updated_at                              = var.issue.updated_at
  weight                                  = var.issue.weight
}

resource "gitlab_project_issue" "issues" {
  for_each = {
    for issue in var.issues : issue.title => issue
    if length(var.issues) > 0
  }

  project                                 = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  title                                   = each.value.title
  assignee_ids                            = each.value.assignee_ids
  confidential                            = each.value.confidential
  created_at                              = each.value.created_at
  delete_on_destroy                       = each.value.delete_on_destroy
  description                             = <<EOT
  Welcome to the ${gitlab_project.this[each.value.project].name} project!
  EOT
  discussion_locked                       = each.value.discussion_locked // true
  discussion_to_resolve                   = each.value.discussion_to_resolve
  due_date                                = each.value.due_date
  epic_issue_id                           = each.value.epic_issue_id
  iid                                     = each.value.iid
  issue_type                              = each.value.issue_type
  labels                                  = each.value.labels
  merge_request_to_resolve_discussions_of = each.value.merge_request_to_resolve_discussions_of
  milestone_id                            = each.value.milestone_id
  state                                   = each.value.state
  updated_at                              = each.value.updated_at
  weight                                  = each.value.weight
}

resource "gitlab_project_issue_board" "board" {
  count = var.issue_board != null ? 1 : 0

  name        = var.issue_board.name
  project     = coalesce(local._projects[var.issue_board.project].id, one(gitlab_project.this[*].id), var.issue_board.project)
  assignee_id = var.issue_board.assignee_id
  labels      = var.issue_board.labels
  dynamic "lists" {
    for_each = length(var.issue_board.lists) > 0 ? toset(var.issue_board.lists) : []
    iterator = item
    content {
      assignee_id  = try(item.value.assignee_id, null)
      iteration_id = try(item.value.iteration_id, null)
      label_id     = try(item.value.label_id, null) != null ? coalesce(gitlab_project_label.labels[try(item.value.label_id, null)].label_id, one(gitlab_project_label.label[*].label_id)) : null
      milestone_id = try(item.value.milestone_id, null) != null ? coalesce(gitlab_project_milestone.milestones[item.value.milestone_id].milestone_id, one(gitlab_project_milestone.milestone[*].milestone_id)) : null
    }
  }
  milestone_id = var.issue_board.milestone_id != null ? coalesce(gitlab_project_milestone.milestones[var.issue_board.milestone_id].milestone_id, one(gitlab_project_milestone.milestone[*].milestone_id)) : null
  weight       = var.issue_board.weight
}

resource "gitlab_project_issue_board" "boards" {
  for_each = {
    for board in var.issue_boards : board.name => board
    if length(var.issue_boards) > 0
  }

  name        = each.value.name
  project     = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  assignee_id = each.value.assignee_id
  labels      = each.value.labels
  dynamic "lists" {
    for_each = length(each.value.lists) > 0 ? toset(each.value.lists) : []
    iterator = item
    content {
      assignee_id  = try(item.value.assignee_id, null)
      iteration_id = try(item.value.iteration_id, null)
      label_id     = try(item.value.label_id, null) != null ? coalesce(gitlab_project_label.labels[try(item.value.label_id, null)].label_id, one(gitlab_project_label.label[*].label_id)) : null
      milestone_id = try(item.value.milestone_id, null) != null ? coalesce(gitlab_project_milestone.milestones[item.value.milestone_id].milestone_id, one(gitlab_project_milestone.milestone[*].milestone_id)) : null
    }
  }
  milestone_id = each.value.milestone_id != null ? coalesce(gitlab_project_milestone.milestones[each.value.milestone_id].milestone_id, one(gitlab_project_milestone.milestone[*].milestone_id)) : null
  weight       = each.value.weight
}

resource "gitlab_project_job_token_scope" "scope" {
  count = var.job_token_scope != null ? 1 : 0

  project           = coalesce(local._projects[var.job_token_scope.project].id, one(gitlab_project.this[*].id), var.job_token_scope.project)
  target_project_id = local.exists_projects[var.job_token_scope.target_project_id].id
}

resource "gitlab_project_job_token_scope" "scopes" {
  for_each = {
    for scope in var.job_token_scopes : scope.target_project_id => scope
    if length(var.job_token_scopes) > 0
  }

  project           = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  target_project_id = local.exists_projects[each.value.target_project_id].id
}


resource "gitlab_project_label" "label" {
  count = var.label != null ? 1 : 0

  project     = coalesce(local._projects[var.label.project].id, one(gitlab_project.this[*].id), var.label.project)
  name        = var.label.name
  description = var.label.description
  color       = var.label.color
}

resource "gitlab_project_label" "labels" {
  for_each = {
    for label in var.labels : label.name => label
    if length(var.labels) > 0
  }

  project     = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  name        = each.value.name
  description = each.value.description
  color       = each.value.color
}


resource "gitlab_project_level_mr_approvals" "this" {
  count = var.level_mr_approvals != null && contains(["premium", "ultimate"], lower(var.tier)) ? 1 : 0

  project                                        = coalesce(local._projects[var.level_mr_approvals.project].id, one(gitlab_project.this[*].id))
  disable_overriding_approvers_per_merge_request = var.level_mr_approvals.disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.level_mr_approvals.merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.level_mr_approvals.merge_requests_disable_committers_approval
  require_password_to_approve                    = var.level_mr_approvals.require_password_to_approve
  reset_approvals_on_push                        = var.level_mr_approvals.reset_approvals_on_push
  selective_code_owner_removals                  = var.level_mr_approvals.selective_code_owner_removals
}


// resource "gitlab_project_level_notifications" "this" {
//   for_each = {
//     for k,v in local.projects : k=>v.level_notifications 
//     if can(v.level_notifications) && length(keys(v.level_notifications)) > 0
//   }
// 
//   project                      = gitlab_project.this[each.value.project].id
//   close_issue                  = try(each.value.close_issue, null)
//   close_merge_request          = try(each.value.close_merge_request, null)
//   failed_pipeline              = try(each.value.failed_pipeline, null)
//   fixed_pipeline               = try(each.value.fixed_pipeline, null)
//   issue_due                    = try(each.value.issue_due, null)
//   level                        =  tostring(each.value.level) // try(each.value.level, null)
//   merge_merge_request          = try(each.value.merge_merge_request, null)
//   merge_when_pipeline_succeeds = try(each.value.merge_when_pipeline_succeeds, null)
//   moved_project                = try(each.value.moved_project, null)
//   new_issue                    = try(each.value.new_issue, null)
//   new_merge_request            = try(each.value.new_merge_request, null)
//   new_note                     = try(each.value.new_note, null)
//   push_to_merge_request        = try(each.value.push_to_merge_request, null)
//   reassign_issue               = try(each.value.reassign_issue, null)
//   reassign_merge_request       = try(each.value.reassign_merge_request, null)
//   reopen_issue                 = try(each.value.reopen_issue, null)
//   reopen_merge_request         = try(each.value.reopen_merge_request, null)
//   success_pipeline             = try(each.value.success_pipeline, null)
//   depends_on = [
//     gitlab_project.this
//   ]
// }


resource "gitlab_project_membership" "membership" {
  count = var.membership != null ? 1 : 0

  project      = coalesce(local._projects[var.membership.project].id, one(gitlab_project.this[*].id), var.membership.project)
  user_id      = contains(keys(local.exists_users), var.membership.user_id) ? local.exists_users[var.membership.user_id].id : null
  access_level = var.membership.access_level
  expires_at   = var.membership.expires_at
}

resource "gitlab_project_membership" "memberships" {
  for_each = {
    for member in var.memberships : member.user_id => member
    if length(var.memberships) > 0
  }

  project      = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  user_id      = contains(keys(local.exists_users), each.value.user_id) ? local.exists_users[each.value.user_id].id : null
  access_level = each.value.access_level
  expires_at   = each.value.expires_at
}

resource "gitlab_project_milestone" "milestone" {
  count = var.milestone != null ? 1 : 0

  project     = coalesce(local._projects[var.milestone.project].id, one(gitlab_project.this[*].id), var.milestone.project)
  title       = var.milestone.title
  description = var.milestone.description
  due_date    = var.milestone.due_date
  start_date  = var.milestone.start_date
  state       = var.milestone.state
}

resource "gitlab_project_milestone" "milestones" {
  for_each = {
    for milestone in var.milestones : milestone.title => milestone
    if length(var.milestones) > 0
  }

  project     = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  title       = each.value.title
  description = each.value.description
  due_date    = each.value.due_date
  start_date  = each.value.start_date
  state       = each.value.state
}


resource "gitlab_project_mirror" "this" {
  count = var.mirror != null ? 1 : 0

  project                 = coalesce(local._projects[var.mirror.project].id, one(gitlab_project.this[*].id))
  url                     = var.mirror.url
  enabled                 = var.mirror.enabled
  keep_divergent_refs     = var.mirror.keep_divergent_refs
  only_protected_branches = var.mirror.only_protected_branches
}


resource "gitlab_project_protected_environment" "environment" {
  count = var.protected_environment != null && contains(["premium", "ultimate"], lower(var.tier)) ? 1 : 0

  environment = var.protected_environment.environment
  project     = coalesce(local._projects[var.protected_environment.project].id, one(gitlab_project.this[*].id), var.protected_environment.project)
  dynamic "deploy_access_levels" {
    for_each = length(try(var.protected_environment.deploy_access_levels, [])) > 0 ? var.protected_environment.deploy_access_levels : []
    iterator = lvl
    content {
      access_level           = try(lvl.value.access_level, null)
      group_id               = try(lvl.group_id, null)
      group_inheritance_type = try(lvl.group_inheritance_type, null)
      user_id                = try(lvl.user_id, null)
    }
  }
  approval_rules          = var.protected_environment.approval_rules
  required_approval_count = var.protected_environment.required_approval_count
}

resource "gitlab_project_protected_environment" "environments" {
  for_each = {
    for env in var.protected_environments : env.environment => env
    if length(var.protected_environments) > 0 && contains(["premium", "ultimate"], lower(var.tier))
  }

  environment = each.value.environment
  project     = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  dynamic "deploy_access_levels" {
    for_each = length(try(each.value.deploy_access_levels, [])) > 0 ? each.value.deploy_access_levels : []
    iterator = lvl
    content {
      access_level           = try(lvl.value.access_level, null)
      group_id               = try(lvl.group_id, null)
      group_inheritance_type = try(lvl.group_inheritance_type, null)
      user_id                = try(lvl.user_id, null)
    }
  }
  approval_rules          = each.value.approval_rules
  required_approval_count = each.value.required_approval_count
}

resource "gitlab_project_runner_enablement" "runner" {
  count = var.runner != null ? 1 : 0

  project   = coalesce(local._projects[var.runner.project].id, one(gitlab_project.this[*].id), var.runner.project)
  runner_id = var.runner.runner_id
}

resource "gitlab_project_runner_enablement" "runners" {
  for_each = {
    for p in var.runners : p.runner_id => p
    if length(var.runners) > 0
  }

  project   = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  runner_id = each.value.runner_id
}

resource "gitlab_project_share_group" "group" {
  count = var.share_group != null ? 1 : 0

  project      = coalesce(local._projects[var.share_group.project].id, one(gitlab_project.this[*].id))
  group_id     = coalesce(local.exists_groups[var.share_group.group_id].group_id, var.share_group.group_id)
  group_access = var.share_group.group_access
}

resource "gitlab_project_share_group" "groups" {
  for_each = {
    for group in var.share_groups : group.group_id => group
    if length(var.share_groups) > 0
  }

  project      = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  group_id     = coalesce(local.exists_groups[each.value.group_id].group_id, each.value.group_id)
  group_access = each.value.group_access
}

resource "gitlab_project_variable" "variable" {
  count = var.variable != null ? 1 : 0

  project           = coalesce(try(local._projects[var.variable.project].id, var.variable.project_id), one(gitlab_project.this[*].id))
  key               = var.variable.key
  value             = var.variable.value
  protected         = var.variable.protected
  masked            = var.variable.masked
  environment_scope = var.variable.environment_scope
  description       = var.variable.description
  raw               = var.variable.raw
  variable_type     = var.variable.variable_type
}

resource "gitlab_project_variable" "variables" {
  for_each = {
    for v in var.variables : v.key => v
    if length(var.variables) > 0
  }

  project           = coalesce(try(local._projects[each.value.project].id, each.value.project_id), one(gitlab_project.this[*].id))
  key               = each.value.key
  value             = each.value.value
  protected         = each.value.protected
  masked            = each.value.masked
  environment_scope = each.value.environment_scope
  description       = each.value.description
  raw               = each.value.raw
  variable_type     = each.value.variable_type
}

resource "gitlab_deploy_key" "key" {
  count = var.deploy_key != null ? 1 : 0

  project  = coalesce(local._projects[var.deploy_key.project].id, one(gitlab_project.this[*].id), var.deploy_key.project)
  title    = var.deploy_key.title
  key      = var.deploy_key.key
  can_push = var.deploy_key.can_push
}

resource "gitlab_deploy_key" "keys" {
  for_each = {
    for key in var.deploy_keys : key.title => key
    if length(var.deploy_keys) > 0
  }

  project  = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  title    = each.value.title
  key      = each.value.key
  can_push = each.value.can_push
}

resource "gitlab_deploy_token" "token" {
  count = var.deploy_token != null ? 1 : 0

  project    = coalesce(local._projects[var.deploy_token.project].id, one(gitlab_project.this[*].id), var.deploy_token.project)
  name       = var.deploy_token.name
  scopes     = var.deploy_token.scopes
  expires_at = var.deploy_token.expires_at
  username   = var.deploy_token.username
}

resource "gitlab_deploy_token" "tokens" {
  for_each = {
    for token in var.deploy_tokens : token.name => token
    if length(var.deploy_tokens) > 0
  }

  project    = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  name       = each.value.name
  scopes     = each.value.scopes
  expires_at = each.value.expires_at
  username   = each.value.username
}


resource "gitlab_pages_domain" "this" {
  count = var.pages_domain != null ? 1 : 0

  project          = coalesce(local._projects[var.pages_domain.project].id, one(gitlab_project.this[*].id))
  domain           = var.pages_domain.domain
  key              = var.pages_domain.key
  certificate      = var.pages_domain.certificate
  auto_ssl_enabled = var.pages_domain.auto_ssl_enabled
  expired          = var.pages_domain.expired
}

resource "gitlab_pipeline_schedule" "schedule" {
  count = var.pipeline_schedule != null ? 1 : 0

  project        = coalesce(local._projects[var.pipeline_schedule.project].id, one(gitlab_project.this[*].id), var.pipeline_schedule.project)
  description    = var.pipeline_schedule.description
  ref            = var.pipeline_schedule.ref
  cron           = var.pipeline_schedule.cron
  active         = try(var.pipeline_schedule.active, null)
  cron_timezone  = try(var.pipeline_schedule.cron_timezone, null)
  take_ownership = try(var.pipeline_schedule.take_ownership, null)
}

resource "gitlab_pipeline_schedule" "schedules" {
  for_each = {
    for pipeline in var.pipeline_schedules : pipeline.ref => pipeline
    if length(var.pipeline_schedules) > 0
  }

  project        = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  description    = each.value.description
  ref            = each.value.ref
  cron           = each.value.cron
  active         = try(each.value.active, null)
  cron_timezone  = try(each.value.cron_timezone, null)
  take_ownership = try(each.value.take_ownership, null)
}

// resource "gitlab_pipeline_schedule_variable" "this" {
//   for_each = {
//     for p in [for ps in var.pipeline_schedule : [
//       for v in var.pipeline_schedule.variables : merge({
//         key     = v.key,
//         value   = v.value,
//         ref     = ps.ref,
//         project = coalesce(local._projects[v.project].id, one(gitlab_project.this[*].id))
//       }) if length(try(var.pipeline_schedule.variables, [])) > 0
//     ] if length(try(var.pipeline_schedule.variables, [])) > 0] : format("%s-%s", p.project, p.ref) => p
//     if length(var.pipeline_schedule) > 0
//   }
// 
//   project              = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
//   pipeline_schedule_id = gitlab_pipeline_schedule.this[each.value.ref].pipeline_schedule_id
//   key                  = each.value.key
//   value                = each.value.value
// }

resource "gitlab_pipeline_trigger" "trigger" {
  count = var.pipeline_trigger != null ? 1 : 0

  project     = tostring(coalesce(local._projects[var.pipeline_trigger.project].id, one(gitlab_project.this[*].id), var.pipeline_trigger.project))
  description = var.pipeline_trigger.description
}

resource "gitlab_pipeline_trigger" "triggers" {
  for_each = {
    for trigger in var.pipeline_triggers : trigger.description => trigger
    if length(var.pipeline_triggers) > 0
  }

  project     = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  description = each.value.description
}

resource "gitlab_release_link" "link" {
  count = var.release_link != null ? 1 : 0

  project   = tostring(coalesce(local._projects[var.release_link.project].id, one(gitlab_project.this[*].id), var.release_link.project))
  tag_name  = var.release_link.tag_name
  name      = var.release_link.name
  url       = var.release_link.url
  filepath  = var.release_link.filepath
  link_type = var.release_link.link_type
}

resource "gitlab_release_link" "links" {
  for_each = {
    for release in var.release_links : release.name => release
    if length(var.release_links) > 0
  }

  project   = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  tag_name  = each.value.tag_name
  name      = each.value.name
  url       = each.value.url
  filepath  = each.value.filepath
  link_type = each.value.link_type
}

resource "gitlab_branch" "branch" {
  count = var.branch != null ? 1 : 0

  name    = var.branch.name
  project = coalesce(local._projects[var.branch.project].id, one(gitlab_project.this[*].id), var.branch.project)
  ref     = var.branch.ref
}

resource "gitlab_branch" "branches" {
  for_each = {
    for branch in var.branches : branch.name => branch
    if length(var.branches) > 0
  }

  name    = each.value.name
  project = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  ref     = each.value.ref
}

resource "gitlab_repository_file" "file" {
  count = var.repository_file != null ? 1 : 0

  project               = tostring(coalesce(local._projects[var.repository_file.project].id, one(gitlab_project.this[*].id), var.repository_file.project))
  file_path             = var.repository_file.file_path
  branch                = var.repository_file.branch
  content               = var.repository_file.content
  author_email          = try(var.repository_file.author_email, data.gitlab_current_user.this.public_email)
  author_name           = try(var.repository_file.author_name, data.gitlab_current_user.this.name)
  commit_message        = var.repository_file.commit_message
  create_commit_message = var.repository_file.create_commit_message
  delete_commit_message = var.repository_file.delete_commit_message
  encoding              = var.repository_file.encoding
  execute_filemode      = var.repository_file.execute_filemode
  overwrite_on_create   = var.repository_file.overwrite_on_create
  start_branch          = var.repository_file.start_branch
  dynamic "timeouts" {
    for_each = var.repository_file.timeouts != null ? var.repository_file.timeouts : {}
    iterator = item
    content {
      create = try(item.value.create, null)
      delete = try(item.value.delete, null)
      update = try(item.value.update, null)
    }
  }
  update_commit_message = var.repository_file.update_commit_message
}

resource "gitlab_repository_file" "files" {
  for_each = {
    for file in var.repository_files : file.file_path => file
    if length(var.repository_files) > 0
  }

  project               = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  file_path             = each.value.file_path
  branch                = each.value.branch
  content               = each.value.content
  author_email          = each.value.author_email
  author_name           = each.value.author_name
  commit_message        = each.value.commit_message
  create_commit_message = each.value.create_commit_message
  delete_commit_message = each.value.delete_commit_message
  encoding              = each.value.encoding
  execute_filemode      = each.value.execute_filemode
  overwrite_on_create   = each.value.overwrite_on_create
  start_branch          = each.value.start_branch
  dynamic "timeouts" {
    // count = each.value.timeouts != null ? 1 : 0
    for_each = each.value.timeouts != null ? each.value.timeouts : {}
    iterator = item
    content {
      create = try(item.value.create, null)
      delete = try(item.value.delete, null)
      update = try(item.value.update, null)
    }
  }
  update_commit_message = each.value.update_commit_message
}

resource "gitlab_cluster_agent" "this" {
  count = var.cluster_agent != null ? 1 : 0

  project = tostring(coalesce(local._projects[var.cluster_agent.project].id, one(gitlab_project.this[*].id)))
  name    = var.cluster_agent.name
}

resource "gitlab_cluster_agent_token" "this" {
  count = var.cluster_agent != null && try(var.cluster_agent.get_token, false) == true ? 1 : 0

  project     = tostring(coalesce(local._projects[var.cluster_agent.project].id, one(gitlab_project.this[*].id)))
  agent_id    = coalesce(var.cluster_agent.agent_id, one(gitlab_cluster_agent.this[*].agent_id))
  name        = var.cluster_agent.name
  description = var.cluster_agent.description
}

data "gitlab_projects" "exists_projects" {
  depends_on = [
    gitlab_project.this
  ]
}

locals {
  exists_projects = { for project in data.gitlab_projects.exists_projects.projects : project.name => project }
}
