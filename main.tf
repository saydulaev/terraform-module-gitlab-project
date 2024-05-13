data "gitlab_groups" "this" {
}

data "gitlab_users" "this" {
  active = true
}

locals {
  exists_users  = { for user in data.gitlab_users.this.users : user.username => user }
  exists_groups = { for group in data.gitlab_groups.this.groups : group.name => group }
}

resource "gitlab_project" "this" {
  count = var.project != null && length(keys(var.project)) > 0 ? 1 : 0

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

resource "gitlab_project_access_token" "this" {
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


resource "gitlab_project_approval_rule" "this" {
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

resource "gitlab_project_badge" "this" {
  for_each = {
    for badge in var.badges : badge.link_url => badge
    if length(var.badges) > 0
  }

  project   = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  link_url  = each.value.link_url
  image_url = each.value.image_url
  name      = each.value.name
}


resource "gitlab_project_custom_attribute" "this" {
  for_each = {
    for attr in var.custom_attributes : attr.key => attr
    if length(var.custom_attributes) > 0
  }

  project = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  key     = each.value.key
  value   = each.value.value
}


resource "gitlab_project_environment" "this" {
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

resource "gitlab_project_hook" "this" {
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


resource "gitlab_project_issue" "this" {
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

resource "gitlab_project_issue_board" "this" {
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
      label_id     = try(item.value.label_id, null) != null ? gitlab_project_label.this[try(item.value.label_id, null)].label_id : null
      milestone_id = try(item.value.milestone_id, null) != null ? gitlab_project_milestone.this[item.value.milestone_id].milestone_id : null
    }
  }
  milestone_id = each.value.milestone_id != null ? gitlab_project_milestone.this[each.value.milestone_id].milestone_id : null
  weight       = each.value.weight
}

resource "gitlab_project_job_token_scope" "this" {
  for_each = {
    for scope in var.job_token_scopes : scope.target_project_id => scope
    if length(var.job_token_scopes) > 0
  }

  project           = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  target_project_id = local.exists_projects[each.value.target_project_id].id
}


resource "gitlab_project_label" "this" {
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


resource "gitlab_project_membership" "this" {
  for_each = {
    for member in var.membership : member.user_id => member
    if length(var.membership) > 0
  }

  project      = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  user_id      = contains(keys(local.exists_users), each.value.user_id) ? local.exists_users[each.value.user_id].id : null
  access_level = each.value.access_level
  expires_at   = each.value.expires_at
}


resource "gitlab_project_milestone" "this" {
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


resource "gitlab_project_protected_environment" "this" {
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


resource "gitlab_project_runner_enablement" "this" {
  for_each = {
    for p in var.runners : p.runner_id => p
    if length(var.runners) > 0
  }

  project   = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  runner_id = each.value.runner_id
}


resource "gitlab_project_share_group" "this" {
  for_each = {
    for group in var.share_groups : group.group_id => group
    if length(var.share_groups) > 0
  }

  project      = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  group_id     = coalesce(local.exists_groups[each.value.group_id].group_id, each.value.group_id)
  group_access = each.value.group_access
}


data "gitlab_project_branches" "this" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
}

locals {
  _project_branches = {
    for branch in distinct(flatten(values(data.gitlab_project_branches.this)[*].branches)) : branch.name => branch
  }
}

resource "gitlab_project_tag" "this" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  name    = each.value.name
  ref     = local._project_branches[each.value.ref].name // each.value.ref
  message = each.value.message
}

data "gitlab_project_tags" "this" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0 && tag.protected == true
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))

  depends_on = [
    gitlab_project_tag.this
  ]
}

locals {
  _gitlab_project_tags = {
    for tag in distinct(flatten(values(data.gitlab_project_tags.this)[*].tags)) : tag.name => tag
  }
}

resource "gitlab_tag_protection" "this" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0 && tag.protected == true
  }

  project             = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  tag                 = coalesce(try(local._gitlab_project_tags[each.value.name].name, null), gitlab_project_tag.this[each.value.name].id)
  create_access_level = each.value.create_access_level
  dynamic "allowed_to_create" {
    for_each = length(each.value.allowed_to_create) > 0 && contains(["premium", "ultimate"], lower(var.tier)) ? toset(each.value.allowed_to_create) : []
    iterator = item
    content {
      user_id  = item.value.user_id != null ? local.exists_users[item.value.user_id].id : null
      group_id = item.value.group_id != null ? local.exists_groups[item.value.group_id].group_id : null
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    gitlab_project_tag.this
  ]
}


resource "gitlab_project_variable" "this" {
  for_each = {
    for v in var.variables : v.key => v
    if length(var.variables) > 0
  }

  project           = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  key               = each.value.key
  value             = each.value.value
  protected         = each.value.protected
  masked            = each.value.masked
  environment_scope = each.value.environment_scope
  description       = each.value.description
  raw               = each.value.raw
  variable_type     = each.value.variable_type
}


resource "gitlab_deploy_key" "this" {
  for_each = {
    for key in var.deploy_keys : key.title => key
    if length(var.deploy_keys) > 0
  }

  project  = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  title    = each.value.title
  key      = each.value.key
  can_push = each.value.can_push
}


resource "gitlab_deploy_token" "this" {
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

resource "gitlab_pipeline_schedule" "this" {
  for_each = {
    for pipeline in var.pipeline_schedule : pipeline.ref => pipeline
    if length(var.pipeline_schedule) > 0
  }

  project        = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  description    = each.value.description
  ref            = each.value.ref
  cron           = each.value.cron
  active         = try(each.value.active, null)
  cron_timezone  = try(each.value.cron_timezone, null)
  take_ownership = try(each.value.take_ownership, null)
}

resource "gitlab_pipeline_schedule_variable" "this" {
  for_each = {
    for p in [for ps in var.pipeline_schedule : [
      for v in var.pipeline_schedule.variables : merge({
        key     = v.key,
        value   = v.value,
        ref     = ps.ref,
        project = coalesce(local._projects[v.project].id, one(gitlab_project.this[*].id))
      }) if length(try(var.pipeline_schedule.variables, [])) > 0
    ] if length(try(var.pipeline_schedule.variables, [])) > 0] : format("%s-%s", p.project, p.ref) => p
    if length(var.pipeline_schedule) > 0
  }

  project              = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  pipeline_schedule_id = gitlab_pipeline_schedule.this[each.value.ref].pipeline_schedule_id
  key                  = each.value.key
  value                = each.value.value
}

resource "gitlab_pipeline_trigger" "this" {
  for_each = {
    for trigger in var.pipeline_triggers : trigger.description => trigger
    if length(var.pipeline_triggers) > 0
  }

  project     = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  description = each.value.description
}

resource "gitlab_release_link" "this" {
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


resource "gitlab_branch" "this" {
  for_each = {
    for branch in var.branches : branch.name => branch
    if length(var.branches) > 0
  }

  name    = each.value.name
  project = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
  ref     = each.value.ref
}

resource "gitlab_repository_file" "this" {
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