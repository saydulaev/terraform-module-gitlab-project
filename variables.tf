// Projects vars
variable "tier" {
  type        = string
  description = "Gitlab tier"
  default     = "free"
  validation {
    condition     = contains(["free", "premium", "ultimate"], lower(var.tier))
    error_message = "The tier value must be one of `free`, `premium`, `ultimate`"
  }
}

variable "project" {
  description = "Gitlab project configuration"
  type = object({
    name                                   = string              // The name of the project.
    allow_merge_on_skipped_pipeline        = optional(bool)      // Set to true if you want to treat skipped pipelines as if they finished with success.
    analytics_access_level                 = optional(string)    // Set the analytics access level. Valid values are disabled, private, enabled
    approvals_before_merge                 = optional(number, 0) // Number of merge request approvals required for merging
    archive_on_destroy                     = optional(bool)      // Set to true to archive the project instead of deleting on destroy. If set to true it will entire omit the DELETE operation.
    archived                               = optional(bool)      // Whether the project is in read-only mode (archived).
    auto_cancel_pending_pipelines          = optional(string)    // Auto-cancel pending pipelines. This isn’t a boolean, but enabled/disabled.
    auto_devops_deploy_strategy            = optional(string)    // Auto Deploy strategy. Valid values are continuous, manual, timed_incremental.
    auto_devops_enabled                    = optional(bool)      // Enable Auto DevOps for this project.
    autoclose_referenced_issues            = optional(bool)      // Set whether auto-closing referenced issues on default branch.
    avatar                                 = optional(string)    // A local path to the avatar image to upload. Note: not available for imported resources.
    avatar_hash                            = optional(string)    // The hash of the avatar image. Use filesha256("path/to/avatar.png") whenever possible. Note: this is used to trigger an update of the avatar. If it's not given, but an avatar is given, the avatar will be updated each time.
    build_git_strategy                     = optional(string)    // The Git strategy. Defaults to fetch. Valid values are clone, fetch.
    build_timeout                          = optional(number)    // The maximum amount of time, in seconds, that a job can run.
    builds_access_level                    = optional(string)    // Set the builds access level. Valid values are disabled, private, enabled.
    ci_config_path                         = optional(string)    //Custom Path to CI config file.
    ci_default_git_depth                   = optional(number)    // Default number of revisions for shallow cloning.
    ci_forward_deployment_enabled          = optional(bool)      // When a new deployment job starts, skip older deployment jobs that are still pending.
    ci_restrict_pipeline_cancellation_role = optional(string)    // The role required to cancel a pipeline or job. Introduced in GitLab 16.8. Premium and Ultimate only. Valid values are developer, maintainer, no one
    ci_separated_caches                    = optional(bool)      // Use separate caches for protected branches.
    container_expiration_policy = optional(list(object({
      cadence           = optional(string)                              // The cadence of the policy. Valid values are: 1d, 7d, 14d, 1month, 3month.
      enabled           = optional(bool)                                // If true, the policy is enabled.
      keep_n            = optional(number)                              // The number of images to keep.
      name_regex_delete = optional(string)                              // The regular expression to match image names to delete.
      name_regex_keep   = optional(string)                              // The regular expression to match image names to keep.
      older_than        = optional(string)                              // The number of days to keep images.
    })), [])                                                            // Set the image cleanup policy for this project. Note: this field is sometimes named container_expiration_policy_attributes in the GitLab Upstream API. (see below for nested schema)
    container_registry_access_level                  = optional(string) // Set visibility of container registry, for this project. Valid values are disabled, private, enabled.
    default_branch                                   = optional(string) // The default branch for the project.
    description                                      = optional(string) // A description of the project.
    emails_enabled                                   = optional(bool)   // Enable email notifications.
    environments_access_level                        = optional(string) // Set the environments access level. Valid values are disabled, private, enabled.
    external_authorization_classification_label      = optional(string) // The classification label for the project.
    feature_flags_access_level                       = optional(string) // Set the feature flags access level. Valid values are disabled, private, enabled.
    forked_from_project_id                           = optional(number) // The id of the project to fork. During create the project is forked and during an update the fork relation is changed.
    forking_access_level                             = optional(string) // Set the forking access level. Valid values are disabled, private, enabled.
    group_runners_enabled                            = optional(bool)   // Enable group runners for this project.
    group_with_project_templates_id                  = optional(number) // For group-level custom templates, specifies ID of group from which all the custom project templates are sourced. Leave empty for instance-level templates. Requires use_custom_template to be true (enterprise edition).
    import_url                                       = optional(string) // Git URL to a repository to be imported. Together with mirror = true it will setup a Pull Mirror. This can also be used together with forked_from_project_id to setup a Pull Mirror for a fork. The fork takes precedence over the import. Make sure to provide the credentials in import_url_username and import_url_password. GitLab never returns the credentials, thus the provider cannot detect configuration drift in the credentials. They can also not be imported using terraform import. See the examples section for how to properly use it.
    import_url_password                              = optional(string) // The password for the import_url. The value of this field is used to construct a valid import_url and is only related to the provider. This field cannot be imported using terraform import. See the examples section for how to properly use it.
    import_url_username                              = optional(string) // The username for the import_url. The value of this field is used to construct a valid import_url and is only related to the provider. This field cannot be imported using terraform import. See the examples section for how to properly use it.
    infrastructure_access_level                      = optional(string) // Set the infrastructure access level. Valid values are disabled, private, enabled.
    initialize_with_readme                           = optional(bool)   // Create main branch with first commit containing a README.md file.
    issues_access_level                              = optional(string) // Set the issues access level. Valid values are disabled, private, enabled.
    issues_enabled                                   = optional(string) // Enable issue tracking for the project.
    issues_template                                  = optional(string) // Sets the template for new issues in the project.
    keep_latest_artifact                             = optional(bool)   // Disable or enable the ability to keep the latest artifact for this project.
    lfs_enabled                                      = optional(bool)   // Enable LFS for the project.
    merge_commit_template                            = optional(string) // Template used to create merge commit message in merge requests. (Introduced in GitLab 14.5.)
    merge_method                                     = optional(string) // Set the merge method. Valid values are merge, rebase_merge, ff.
    merge_pipelines_enabled                          = optional(bool)   // Enable or disable merge pipelines.
    merge_requests_access_level                      = optional(string) // Set the merge requests access level. Valid values are disabled, private, enabled.
    merge_requests_enabled                           = optional(bool)   // Enable merge requests for the project.
    merge_requests_template                          = optional(string) // Sets the template for new merge requests in the project.
    merge_trains_enabled                             = optional(bool)   // Enable or disable merge trains. Requires merge_pipelines_enabled to be set to true to take effect.
    mirror                                           = optional(bool)   // Enable project pull mirror.
    mirror_overwrites_diverged_branches              = optional(bool)   // Enable overwrite diverged branches for a mirrored project.
    mirror_trigger_builds                            = optional(bool)   // Enable trigger builds on pushes for a mirrored project.
    monitor_access_level                             = optional(string) // Set the monitor access level. Valid values are disabled, private, enabled.
    mr_default_target_self                           = optional(bool)   // For forked projects, target merge requests to this project. If false, the target will be the upstream project.
    namespace_id                                     = optional(number) // The namespace (group or user) of the project. Defaults to your user.
    only_allow_merge_if_all_discussions_are_resolved = optional(bool)   // Set to true if you want allow merges only if all discussions are resolved.
    only_allow_merge_if_pipeline_succeeds            = optional(bool)   // Set to true if you want allow merges only if a pipeline succeeds.
    only_mirror_protected_branches                   = optional(bool)   // Enable only mirror protected branches for a mirrored project.
    packages_enabled                                 = optional(bool)   // Enable packages repository for the project.
    pages_access_level                               = optional(string) // Enable pages access control. Valid values are public, private, enabled, disabled.
    path                                             = optional(string) // The path of the repository.
    printing_merge_request_link_enabled              = optional(bool)   // Show link to create/view merge request when pushing from the command line
    public_jobs                                      = optional(bool)   // If true, jobs can be viewed by non-project members.
    push_rules = optional(list(object({
      author_email_regex            = optional(string)              // All commit author emails must match this regex, e.g. @my-company.com$.
      branch_name_regex             = optional(string)              // All branch names must match this regex, e.g. (feature|hotfix)\/*.
      commit_committer_check        = optional(bool)                // Users can only push commits to this repository that were committed with one of their own verified emails.
      commit_message_negative_regex = optional(string)              // No commit message is allowed to match this regex, for example ssh\:\/\/.
      commit_message_regex          = optional(string)              // All commit messages must match this regex, e.g. Fixed \d+\..*.
    })))                                                            // Push rules for the project. (see below for nested schema)
    releases_access_level                   = optional(string)      // Set the releases access level. Valid values are disabled, private, enabled.
    remove_source_branch_after_merge        = optional(bool)        // Enable Delete source branch option by default for all new merge requests.
    repository_access_level                 = optional(string)      // Set the repository access level. Valid values are disabled, private, enabled.
    repository_storage                      = optional(string)      // Which storage shard the repository is on. (administrator only)
    request_access_enabled                  = optional(bool)        // Allow users to request member access.
    requirements_access_level               = optional(string)      // Set the requirements access level. Valid values are disabled, private, enabled.
    resolve_outdated_diff_discussions       = optional(bool)        // Automatically resolve merge request diffs discussions on lines changed with a push.
    restrict_user_defined_variables         = optional(bool)        // Allow only users with the Maintainer role to pass user-defined variables when triggering a pipeline.
    security_and_compliance_access_level    = optional(string)      // Set the security and compliance access level. Valid values are disabled, private, enabled.
    shared_runners_enabled                  = optional(bool)        // Enable shared runners for this project.
    skip_wait_for_default_branch_protection = optional(bool)        // If true, the default behavior to wait for the default branch protection to be created is skipped. This is necessary if the current user is not an admin and the default branch protection is disabled on an instance-level. There is currently no known way to determine if the default branch protection is disabled on an instance-level for non-admin users. This attribute is only used during resource creation, thus changes are suppressed and the attribute cannot be imported.
    snippets_access_level                   = optional(string)      // Set the snippets access level. Valid values are disabled, private, enabled.
    snippets_enabled                        = optional(bool)        // Enable snippets for the project.
    squash_commit_template                  = optional(string)      // Template used to create squash commit message in merge requests. (Introduced in GitLab 14.6.)
    squash_option                           = optional(string)      // Squash commits when merge request. Valid values are never, always, default_on, or default_off. The default value is default_off. [GitLab >= 14.1]
    suggestion_commit_message               = optional(string)      // The commit message used to apply merge request suggestions.
    tags                                    = optional(set(string)) // The list of tags for a project; put array of tags, that should be finally assigned to a project. Use topics instead.
    template_name                           = optional(string)      // When used without use_custom_template, name of a built-in project template. When used with use_custom_template, name of a custom project template. This option is mutually exclusive with template_project_id.
    template_project_id                     = optional(number)      // When used with use_custom_template, project ID of a custom project template. This is preferable to using template_name since template_name may be ambiguous (enterprise edition). This option is mutually exclusive with template_name. See gitlab_group_project_file_template to set a project as a template project. If a project has not been set as a template, using it here will result in an error.
    timeouts = optional(list(object({
      create = optional(string)
      delete = optional(string)
    })), [])
    topics              = optional(set(string)) // The list of topics for the project.
    use_custom_template = optional(bool)        // Use either custom instance or group (with group_with_project_templates_id) project template (enterprise edition). ~> When using a custom template, Group Tokens won't work. You must use a real user's Personal Access Token.
    visibility_level    = optional(string)      // Set to public to create a public project. Valid values are private, internal, public.
    wiki_access_level   = optional(string)      // Set the wiki access level. Valid values are disabled, private, enabled.
    wiki_enabled        = optional(bool)        // Enable wiki for the project.
  })
  default = null
}

variable "access_token" {
  description = "Gitlab project access token."
  type = object({
    name    = string // The name of the project access token.
    project = string // The name of the project
    // project = optional(string) // The id of project
    scopes       = set(string)      // The scopes of the project access token.
    access_level = optional(string) // The access level for the project access token.
    expires_at   = optional(string) // When the token will expire, YYYY-MM-DD format. Is automatically set when rotation_configuration is used.
    rotation_configuration = optional(object({
      expiration_days    = number // The duration (in days) the new token should be valid for.
      rotate_before_days = number // The duration (in days) before the expiration when the token should be rotated.
    }))                           //  The configuration for when to rotate a token automatically. 
  })
  default = null
}

variable "access_tokens" {
  description = "Resource allows to manage the lifecycle of a project access tokens."
  type = list(object({
    name         = string           // The name of the project access token.
    project      = string           // The ID or full path of the project
    scopes       = set(string)      // The scopes of the project access token.
    access_level = optional(string) // The access level for the project access token.
    expires_at   = optional(string) // When the token will expire, YYYY-MM-DD format. Is automatically set when rotation_configuration is used.
    rotation_configuration = optional(object({
      expiration_days    = number // The duration (in days) the new token should be valid for.
      rotate_before_days = number // The duration (in days) before the expiration when the token should be rotated.
    }))                           //  The configuration for when to rotate a token automatically. 
  }))
  default = []
}

variable "approval_rule" {
  description = "Manage the lifecycle of a project-level approval rule."
  type = object({
    name                                                  = string
    project                                               = string
    approvals_required                                    = number
    project_id                                            = optional(string)
    applies_to_all_protected_branches                     = optional(bool, false)       // Whether the rule is applied to all protected branches. If set to 'true', the value of protected_branch_ids is ignored
    disable_importing_default_any_approver_rule_on_create = optional(bool)              // When this flag is set, the default any_approver rule will not be imported if present.
    group_ids                                             = optional(set(string))       // A list of group IDs whose members can approve of the merge request.
    protected_branch_ids                                  = optional(set(number))       // A list of protected branch IDs (not branch names) for which the rule applies.
    rule_type                                             = optional(string, "regular") // The type of rule.
    user_ids                                              = optional(set(string))       // A list of specific User IDs to add to the list of approvers.
  })
  default = null
}

variable "approval_rules" {
  description = "Manage the lifecycle of a project-level approval rules."
  type = list(object({
    name                                                  = string
    project                                               = string
    approvals_required                                    = number
    applies_to_all_protected_branches                     = optional(bool, false)       // Whether the rule is applied to all protected branches. If set to 'true', the value of protected_branch_ids is ignored
    disable_importing_default_any_approver_rule_on_create = optional(bool)              // When this flag is set, the default any_approver rule will not be imported if present.
    group_ids                                             = optional(set(string))       // A list of group IDs whose members can approve of the merge request.
    protected_branch_ids                                  = optional(set(number))       // A list of protected branch IDs (not branch names) for which the rule applies.
    rule_type                                             = optional(string, "regular") // The type of rule.
    user_ids                                              = optional(set(string))       // A list of specific User IDs to add to the list of approvers.
  }))
  default = []
}

variable "badge" {
  description = "Manage the lifecycle of project badge"
  type = object({
    project    = string           // The name of the project to add the badge to.
    project_id = optional(string) // The id of the project to add the badge to.
    image_url  = string           // The image url which will be presented on project overview.
    link_url   = string           // The url linked with the badge.
    name       = optional(string) // The name of the badge.
  })
  default = null
}

variable "badges" {
  description = "Manage the lifecycle of project badges"
  type = list(object({
    project   = string           // The id of the project to add the badge to.
    image_url = string           // The image url which will be presented on project overview.
    link_url  = string           // The url linked with the badge.
    name      = optional(string) // The name of the badge.
  }))
  default = []
}

variable "compliance_framework" {
  description = "Manage the lifecycle of a compliance framework on a project."
  type = object({
    compliance_framework_id = string           // Globally unique ID of the compliance framework to assign to the project.
    project                 = string           // The name of the project to change the compliance framework of.
    project_id              = optional(string) // The ID of the project to change the compliance framework of.
    namespace_path          = optional(string)
    name                    = optional(string)
  })
  default = null
}

variable "compliance_frameworks" {
  description = "Manage the lifecycle of a compliance framework on a project."
  type = list(object({
    compliance_framework_id = string // Globally unique ID of the compliance framework to assign to the project.
    project                 = string // The ID or full path of the project to change the compliance framework of.
    namespace_path          = optional(string)
    name                    = optional(string)
  }))
  default = []
}

variable "custom_attribute" {
  description = "Manage custom attribute for a project."
  type = object({
    project    = string           // The name of the project.
    project_id = optional(string) // The id of the project.
    key        = string           // Key for the Custom Attribute.
    value      = string           // Value for the Custom Attribute.
  })
  default = null
}

variable "custom_attributes" {
  description = "Manage custom attributes for a project."
  type = list(object({
    project = string // The id of the project.
    key     = string // Key for the Custom Attribute.
    value   = string // Value for the Custom Attribute.
  }))
  default = []
}

variable "environment" {
  description = "Manage the lifecycle of an environment in a project."
  type = object({
    name                = string           // The name of the environment.
    project             = string           // The name of full path of the project to environment is created for.
    project_id          = optional(string) // The ID of the project to environment is created for.
    external_url        = optional(string) // Place to link to for this environment.
    stop_before_destroy = optional(string) // Determines whether the environment is attempted to be stopped before the environment is deleted.
  })
  default = null
}

variable "environments" {
  description = "Manage the lifecycle of environments in a project."
  type = list(object({
    name                = string           // The name of the environment.
    project             = string           // The ID or full path of the project to environment is created for.
    external_url        = optional(string) // Place to link to for this environment.
    stop_before_destroy = optional(string) // Determines whether the environment is attempted to be stopped before the environment is deleted.
  }))
  default = []
}

variable "freeze_period" {
  description = "Manage the lifecycle of a freeze period for a project."
  type = object({
    freeze_end    = string           // End of the Freeze Period in cron format (e.g. 0 2 * * *)
    freeze_start  = string           // Start of the Freeze Period in cron format (e.g. 0 1 * * *)
    project       = string           // The ID or URL-encoded path of the project to add the schedule to.
    cron_timezone = optional(string) // The timezone.
  })
  default = null
}

variable "hook" {
  description = "Manage the lifecycle of a project hook."
  type = object({
    project                    = string           // The name of the project to add the hook to.
    project_id                 = optional(string) // The id of the project to add the hook to.
    url                        = string           // The url of the hook to invoke.
    confidential_issues_events = optional(bool)   // Invoke the hook for confidential issues events.
    confidential_note_events   = optional(bool)   // Invoke the hook for confidential notes events.
    custom_webhook_template    = optional(bool)   // Set a custom webhook template.
    deployment_events          = optional(bool)   // Invoke the hook for deployment events.
    enable_ssl_verification    = optional(bool)   // Enable ssl verification when invoking the hook.
    issues_events              = optional(bool)   //Invoke the hook for issues events.
    job_events                 = optional(bool)   //  Invoke the hook for job events.
    merge_requests_events      = optional(bool)   // Invoke the hook for merge requests.
    note_events                = optional(bool)   //  Invoke the hook for notes events.
    pipeline_events            = optional(bool)   // Invoke the hook for pipeline events.
    push_events                = optional(bool)   // Invoke the hook for push events.
    push_events_branch_filter  = optional(string) // Invoke the hook for push events on matching branches only.
    releases_events            = optional(bool)   // Invoke the hook for releases events.
    tag_push_events            = optional(bool)   // Invoke the hook for tag push events.
    token                      = optional(string) // A token to present when invoking the hook. The token is not available for imported resources.
    wiki_page_events           = optional(bool)   // Invoke the hook for wiki page events.
  })
  default = null
}

variable "hooks" {
  description = "Manage the lifecycle of a project hooks."
  type = list(object({
    project                    = string           // The name or id of the project to add the hook to.
    url                        = string           // The url of the hook to invoke.
    confidential_issues_events = optional(bool)   // Invoke the hook for confidential issues events.
    confidential_note_events   = optional(bool)   // Invoke the hook for confidential notes events.
    custom_webhook_template    = optional(bool)   // Set a custom webhook template.
    deployment_events          = optional(bool)   // Invoke the hook for deployment events.
    enable_ssl_verification    = optional(bool)   // Enable ssl verification when invoking the hook.
    issues_events              = optional(bool)   //Invoke the hook for issues events.
    job_events                 = optional(bool)   //  Invoke the hook for job events.
    merge_requests_events      = optional(bool)   // Invoke the hook for merge requests.
    note_events                = optional(bool)   //  Invoke the hook for notes events.
    pipeline_events            = optional(bool)   // Invoke the hook for pipeline events.
    push_events                = optional(bool)   // Invoke the hook for push events.
    push_events_branch_filter  = optional(string) // Invoke the hook for push events on matching branches only.
    releases_events            = optional(bool)   // Invoke the hook for releases events.
    tag_push_events            = optional(bool)   // Invoke the hook for tag push events.
    token                      = optional(string) // A token to present when invoking the hook. The token is not available for imported resources.
    wiki_page_events           = optional(bool)   // Invoke the hook for wiki page events.
  }))
  default = []
}

variable "milestone" {
  description = "Manage the lifecycle of a project milestone."
  type = object({
    project     = string           // The URL-encoded path of the project owned by the authenticated user.
    project_id  = optional(string) // The ID  of the project owned by the authenticated user.
    title       = string           // The title of a milestone.
    description = optional(string) // The description of the milestone.
    due_date    = optional(string) // The due date of the milestone. Date time string in the format YYYY-MM-DD
    start_date  = optional(string) // The start date of the milestone. Date time string in the format YYYY-MM-DD
    state       = optional(string) // The state of the milestone.
  })
  default = null
}

variable "milestones" {
  description = "Manage the lifecycle of a project milestones."
  type = list(object({
    project     = string           // The ID or URL-encoded path of the project owned by the authenticated user.
    title       = string           // The title of a milestone.
    description = optional(string) // The description of the milestone.
    due_date    = optional(string) // The due date of the milestone. Date time string in the format YYYY-MM-DD
    start_date  = optional(string) // The start date of the milestone. Date time string in the format YYYY-MM-DD
    state       = optional(string) // The state of the milestone.
  }))
  default = []
}

variable "issue" {
  description = "Manage the lifecycle of an issue within a project."
  type = object({
    project                                 = string                // The name of the project.
    project_id                              = optional(string)      // The  ID of the project.
    title                                   = string                // The title of the issue.
    assignee_ids                            = optional(set(number)) // The IDs of the users to assign the issue to.
    confidential                            = optional(bool)        // Set an issue to be confidential.
    created_at                              = optional(string)      // When the issue was created. Date time string, ISO 8601 formatted, for example 2016-03-11T03:45:40Z.
    delete_on_destroy                       = optional(bool)        // Whether the issue is deleted instead of closed during destroy.
    description                             = optional(string)      // The description of an issue. Limited to 1,048,576 characters.
    discussion_locked                       = optional(bool)        // Whether the issue is locked for discussions or not.
    discussion_to_resolve                   = optional(string)      // The ID of a discussion to resolve.
    due_date                                = optional(string)      // The due date. Date time string in the format YYYY-MM-DD
    epic_issue_id                           = optional(number)      // The ID of the epic issue.
    iid                                     = optional(number)      // The internal ID of the project's issue.
    issue_type                              = optional(string)      // The type of issue. Valid values are: issue, incident, test_case.
    labels                                  = optional(set(string)) // The labels of an issue.
    merge_request_to_resolve_discussions_of = optional(number)      //  The IID of a merge request in which to resolve all issues. 
    milestone_id                            = optional(number)      // The global ID of a milestone to assign issue. 
    state                                   = optional(string)      // The state of the issue. Valid values are: opened, closed.
    updated_at                              = optional(string)      // When the issue was updated. Date time string, ISO 8601 formatted, for example 2016-03-11T03:45:40Z.
    weight                                  = optional(number)      // The weight of the issue. Valid values are greater than or equal to 0.
  })
  default = null
}

variable "issues" {
  description = "Manage the lifecycle of an issue within a project."
  type = list(object({
    project                                 = string                // The name or ID of the project.
    title                                   = string                // The title of the issue.
    assignee_ids                            = optional(set(number)) // The IDs of the users to assign the issue to.
    confidential                            = optional(bool)        // Set an issue to be confidential.
    created_at                              = optional(string)      // When the issue was created. Date time string, ISO 8601 formatted, for example 2016-03-11T03:45:40Z.
    delete_on_destroy                       = optional(bool)        // Whether the issue is deleted instead of closed during destroy.
    description                             = optional(string)      // The description of an issue. Limited to 1,048,576 characters.
    discussion_locked                       = optional(bool)        // Whether the issue is locked for discussions or not.
    discussion_to_resolve                   = optional(string)      // The ID of a discussion to resolve.
    due_date                                = optional(string)      // The due date. Date time string in the format YYYY-MM-DD
    epic_issue_id                           = optional(number)      // The ID of the epic issue.
    iid                                     = optional(number)      // The internal ID of the project's issue.
    issue_type                              = optional(string)      // The type of issue. Valid values are: issue, incident, test_case.
    labels                                  = optional(set(string)) // The labels of an issue.
    merge_request_to_resolve_discussions_of = optional(number)      //  The IID of a merge request in which to resolve all issues. 
    milestone_id                            = optional(number)      // The global ID of a milestone to assign issue. 
    state                                   = optional(string)      // The state of the issue. Valid values are: opened, closed.
    updated_at                              = optional(string)      // When the issue was updated. Date time string, ISO 8601 formatted, for example 2016-03-11T03:45:40Z.
    weight                                  = optional(number)      // The weight of the issue. Valid values are greater than or equal to 0.
  }))
  default = []
}

variable "issue_board" {
  description = "Manage the lifecycle of a Project Issue Board."
  type = object({
    name        = string                // The name of the board.
    project     = string                // The ID or full path of the project maintained by the authenticated user.
    assignee_id = optional(number)      // The assignee the board should be scoped to. Requires a GitLab EE license.
    labels      = optional(set(string)) // The list of label names which the board should be scoped to. Requires a GitLab EE license.
    lists = optional(list(object({
      assignee_id  = optional(number) // The assignee the board should be scoped to. Requires a GitLab EE license.
      iteration_id = optional(number) // The ID of the iteration the list should be scoped to. Requires a GitLab EE license.
      label_id     = optional(string) // The ID of the label the list should be scoped to. Requires a GitLab EE license.
      milestone_id = optional(number) // The ID of the milestone the list should be scoped to. Requires a GitLab EE license.
    })))                              // The list of issue board lists
    milestone_id = optional(number)   // The milestone the board should be scoped to. Requires a GitLab EE license.
    weight       = optional(number)   // The weight range from 0 to 9, to which the board should be scoped to. Requires a GitLab EE license.
  })
  default = null
}

variable "issue_boards" {
  description = "Manage the lifecycle of a Project Issue Boards."
  type = list(object({
    name        = string                // The name of the board.
    project     = string                // The ID or full path of the project maintained by the authenticated user.
    assignee_id = optional(number)      // The assignee the board should be scoped to. Requires a GitLab EE license.
    labels      = optional(set(string)) // The list of label names which the board should be scoped to. Requires a GitLab EE license.
    lists = optional(list(object({
      assignee_id  = optional(number) // The assignee the board should be scoped to. Requires a GitLab EE license.
      iteration_id = optional(number) // The ID of the iteration the list should be scoped to. Requires a GitLab EE license.
      label_id     = optional(string) // The ID of the label the list should be scoped to. Requires a GitLab EE license.
      milestone_id = optional(number) // The ID of the milestone the list should be scoped to. Requires a GitLab EE license.
    })))                              // The list of issue board lists
    milestone_id = optional(number)   // The milestone the board should be scoped to. Requires a GitLab EE license.
    weight       = optional(number)   // The weight range from 0 to 9, to which the board should be scoped to. Requires a GitLab EE license.
  }))
  default = []
}

variable "job_token_scope" {
  description = "Manage the CI/CD Job Token scope in a project."
  type = object({
    project           = string           // The full path of the project.
    project_id        = optional(string) // The ID of the project.
    target_project_id = string           // The ID of the project that is in the CI/CD job token inbound allowlist.
  })
  default = null
}

variable "job_token_scopes" {
  description = "Manage the CI/CD Job Token scope in a project."
  type = list(object({
    project           = string // The ID or full path of the project.
    target_project_id = string // The ID of the project that is in the CI/CD job token inbound allowlist.
  }))
  default = []
}

variable "label" {
  description = "Manage the lifecycle of a project label."
  type = object({
    color       = string           // The color of the label given in 6-digit hex notation with leading '#' sign (e.g. #FFAABB) or one of the CSS color names.
    name        = string           // The name of the label.
    project     = string           // The name of the project to add the label to.
    project_id  = string           // The id of the project to add the label to.
    description = optional(string) // The description of the label.
  })
  default = null
}

variable "labels" {
  description = "Manage the lifecycle of a project labels."
  type = list(object({
    color       = string           // The color of the label given in 6-digit hex notation with leading '#' sign (e.g. #FFAABB) or one of the CSS color names.
    name        = string           // The name of the label.
    project     = string           // The name or id of the project to add the label to.
    description = optional(string) // The description of the label.
  }))
  default = []
}

###

variable "level_mr_approvals" {
  description = "Manage the lifecycle of a Merge Request-level approval rule."
  type = object({
    project                                        = string               // The ID or URL-encoded path of a project to change MR approval configuration.
    disable_overriding_approvers_per_merge_request = optional(bool)       // Set to true to disable overriding approvers per merge request.
    merge_requests_author_approval                 = optional(bool)       // Set to true to allow merge requests authors to approve their own merge requests.
    merge_requests_disable_committers_approval     = optional(bool)       // Set to true to disable merge request committers from approving their own merge requests.
    require_password_to_approve                    = optional(bool)       // Set to true to require authentication to approve merge requests.
    reset_approvals_on_push                        = optional(bool, true) // Set to true to remove all approvals in a merge request when new commits are pushed to its source branch.
    selective_code_owner_removals                  = optional(bool)       // Reset approvals from Code Owners if their files changed.
  })
  default = null
}

variable "level_notifications" {
  description = "Manage notifications for a project"
  type = object({
    project                      = string           // The ID or URL-encoded path of a project where notifications will be configured.
    close_issue                  = optional(bool)   // Enable notifications for closed issues. Can only be used when level is custom.
    close_merge_request          = optional(bool)   // Enable notifications for closed merge requests. Can only be used when level is custom.
    failed_pipeline              = optional(bool)   // Enable notifications for failed pipelines. Can only be used when level is custom
    fixed_pipeline               = optional(bool)   // Enable notifications for fixed pipelines. Can only be used when level is custom
    issue_due                    = optional(bool)   // Enable notifications for due issues. Can only be used when level is custom.
    level                        = optional(string) // The level of the notification. Valid values are: disabled, participating, watch, global, mention, custom
    merge_merge_request          = optional(bool)   // Enable notifications for merged merge requests. Can only be used when level is custom.
    merge_when_pipeline_succeeds = optional(bool)   // Enable notifications for merged merge requests when the pipeline succeeds. Can only be used when level is custom.
    moved_project                = optional(bool)   // Enable notifications for moved projects. Can only be used when level is custom.
    new_issue                    = optional(bool)   // Enable notifications for new issues. Can only be used when level is custom.
    new_merge_request            = optional(bool)   // Enable notifications for new merge requests. Can only be used when level is custom.
    new_note                     = optional(bool)   // Enable notifications for new notes on merge requests. Can only be used when level is custom
    push_to_merge_request        = optional(bool)   // Enable notifications for push to merge request branches. Can only be used when level is custom.
    reassign_issue               = optional(bool)   // Enable notifications for issue reassignments. Can only be used when level is custom
    reassign_merge_request       = optional(bool)   // Enable notifications for merge request reassignments. Can only be used when level is custom.
    reopen_issue                 = optional(bool)   // Enable notifications for reopened issues. Can only be used when level is custom.
    reopen_merge_request         = optional(bool)   // Enable notifications for reopened merge requests. Can only be used when level is custom.
    success_pipeline             = optional(bool)   // Enable notifications for successful pipelines. Can only be used when level is custom.
  })
  default = null
}

variable "membership" {
  description = "Manage the lifecycle of a users project membership."
  type = object({
    access_level = string           // The access level for the member. Valid values are: no one, minimal, guest, reporter, developer, maintainer, owner, master
    project      = string           // The ID or URL-encoded path of the project.
    user_id      = string           // The id of the user.
    expires_at   = optional(string) // Expiration date for the project membership. Format: YYYY-MM-DD
  })
  default = null
}

variable "memberships" {
  description = "Manage the lifecycle of a users projects membership."
  type = list(object({
    access_level = string           // The access level for the member. Valid values are: no one, minimal, guest, reporter, developer, maintainer, owner, master
    project      = string           // The ID or URL-encoded path of the project.
    user_id      = string           // The id of the user.
    expires_at   = optional(string) // Expiration date for the project membership. Format: YYYY-MM-DD
  }))
  default = []
}

variable "mirror" {
  description = "Manage the lifecycle of a project mirror."
  type = object({
    project                 = string         // The id of the project.
    url                     = string         // The URL of the remote repository to be mirrored.
    enabled                 = optional(bool) // Determines if the mirror is enabled.
    keep_divergent_refs     = optional(bool) // Determines if divergent refs are skipped.
    only_protected_branches = optional(bool) // Determines if only protected branches are mirrored.
  })
  default = null
}

variable "protected_environment" {
  description = "Manage the lifecycle of a protected environment in a project."
  type = object({
    environment = string // The name of the environment.
    project     = string // The ID or full path of the project which the protected environment is created against.
    approval_rules = optional(list(object({
      access_level           = optional(string)    // Levels of access allowed to approve a deployment to this protected environment. Valid values are developer, maintainer.
      group_id               = optional(string)    // The ID of the group allowed to approve a deployment to this protected environment.
      group_inheritance_type = optional(number, 0) // Group inheritance allows deploy access levels to take inherited group membership into account. Valid values are 0, 1. 0 => Direct group membership only, 1 => All inherited groups. Default: 0
      required_approvals     = optional(number)    // The number of approval required to allow deployment to this protected environment. This is mutually exclusive with user_id.
      user_id                = optional(number)    // The ID of the user allowed to approve a deployment to this protected environment. The user must be a member of the project. This is mutually exclusive with group_id and required_approvals.
    })))                                           // Array of approval rules to deploy, with each described by a hash.
    deploy_access_levels = optional(set(object({
      access_level           = optional(string)    // Levels of access required to deploy to this protected environment. Valid values are developer, maintainer.
      group_id               = optional(number)    // The ID of the group allowed to deploy to this protected environment. The project must be shared with the group.
      group_inheritance_type = optional(number, 0) // Group inheritance allows deploy access levels to take inherited group membership into account. Valid values are 0, 1. 0 => Direct group membership only, 1 => All inherited groups. Default: 0
      user_id                = optional(number)    // The ID of the user allowed to deploy to this protected environment. The user must be a member of the project.
    })))                                           // Array of access levels allowed to deploy, with each described by a hash.
    required_approval_count = optional(number)     // The number of approvals required to deploy to this environment.
  })
  default = null
}

variable "protected_environments" {
  description = "Manage the lifecycle of a protected environments in a project."
  type = list(object({
    environment = string // The name of the environment.
    project     = string // The ID or full path of the project which the protected environment is created against.
    approval_rules = optional(list(object({
      access_level           = optional(string)    // Levels of access allowed to approve a deployment to this protected environment. Valid values are developer, maintainer.
      group_id               = optional(string)    // The ID of the group allowed to approve a deployment to this protected environment.
      group_inheritance_type = optional(number, 0) // Group inheritance allows deploy access levels to take inherited group membership into account. Valid values are 0, 1. 0 => Direct group membership only, 1 => All inherited groups. Default: 0
      required_approvals     = optional(number)    // The number of approval required to allow deployment to this protected environment. This is mutually exclusive with user_id.
      user_id                = optional(number)    // The ID of the user allowed to approve a deployment to this protected environment. The user must be a member of the project. This is mutually exclusive with group_id and required_approvals.
    })))                                           // Array of approval rules to deploy, with each described by a hash.
    deploy_access_levels = optional(set(object({
      access_level           = optional(string)    // Levels of access required to deploy to this protected environment. Valid values are developer, maintainer.
      group_id               = optional(number)    // The ID of the group allowed to deploy to this protected environment. The project must be shared with the group.
      group_inheritance_type = optional(number, 0) // Group inheritance allows deploy access levels to take inherited group membership into account. Valid values are 0, 1. 0 => Direct group membership only, 1 => All inherited groups. Default: 0
      user_id                = optional(number)    // The ID of the user allowed to deploy to this protected environment. The user must be a member of the project.
    })))                                           // Array of access levels allowed to deploy, with each described by a hash.
    required_approval_count = optional(number)     // The number of approvals required to deploy to this environment.
  }))
  default = []
}

variable "runner" {
  description = "Enable a runner in a project."
  type = object({
    project   = string // The ID or URL-encoded path of the project owned by the authenticated user.
    runner_id = number // The ID of a runner to enable for the project.
  })
  default = null
}

variable "runners" {
  description = "Enable a runners in a project."
  type = list(object({
    project   = string // The ID or URL-encoded path of the project owned by the authenticated user.
    runner_id = number // The ID of a runner to enable for the project.
  }))
  default = []
}

variable "share_group" {
  description = "Manage the lifecycle of project shared with a group."
  type = object({
    group_id     = string           // The id of the group.
    project      = string           // The ID or URL-encoded path of the project.
    group_access = optional(string) // The access level to grant the group for the project. Valid values are: no one, minimal, guest, reporter, developer, maintainer, owner, master
  })
  default = null
}

variable "share_groups" {
  description = "Manage the lifecycle of project shared with a group."
  type = list(object({
    group_id     = string           // The id of the group.
    project      = string           // The ID or URL-encoded path of the project.
    group_access = optional(string) // The access level to grant the group for the project. Valid values are: no one, minimal, guest, reporter, developer, maintainer, owner, master
  }))
  default = []
}

variable "tag" {
  description = "Manage the lifecycle of a tag in a project."
  type = object({
    name                = string                // The name of a tag.
    project             = string                // The ID or URL-encoded path of the project owned by the authenticated user.
    ref                 = string                // Create tag using commit SHA, another tag name, or branch name. This attribute is not available for imported resources.
    message             = optional(string)      // The message of the annotated tag.
    protected           = optional(bool, false) // Define tag protection
    create_access_level = optional(string)      // Access levels which are allowed to create. Valid values are: no one, developer, maintainer
    allowed_to_create = optional(list(object({
      group_id = optional(string)
      user_id  = optional(string)
    })), [])
  })
  default = null
}

variable "tags" {
  description = "Manage the lifecycle of a tags in a project."
  type = list(object({
    name                = string                // The name of a tag.
    project             = string                // The ID or URL-encoded path of the project owned by the authenticated user.
    ref                 = string                // Create tag using commit SHA, another tag name, or branch name. This attribute is not available for imported resources.
    message             = optional(string)      // The message of the annotated tag.
    protected           = optional(bool, false) // Define tag protection
    create_access_level = optional(string)      // Access levels which are allowed to create. Valid values are: no one, developer, maintainer
    allowed_to_create = optional(list(object({
      group_id = optional(string)
      user_id  = optional(string)
    })), [])
  }))
  default = []
}

variable "variable" {
  description = "Manage the lifecycle of a CI/CD variable for a project."
  type = object({
    key               = string                      // The name of the variable.
    project           = optional(string)            // The name of the project.
    project_id        = optional(string)            // The id of the project.
    value             = string                      // The value of the variable.
    description       = optional(string)            // The description of the variable.
    environment_scope = optional(string)            // The environment scope of the variable. Defaults to all environment (*). Note that in Community Editions of Gitlab, values other than * will cause inconsistent plans.
    masked            = optional(bool, false)       //  If set to true, the value of the variable will be hidden in job logs. The value must meet the masking requirements.
    protected         = optional(bool, false)       // If set to true, the variable will be passed only to pipelines running on protected branches and tags.
    raw               = optional(bool, false)       // Whether the variable is treated as a raw string. When true, variables in the value are not expanded.
    variable_type     = optional(string, "env_var") // The type of a variable. Valid values are: env_var, file
  })
  default = null
}

variable "variables" {
  description = "Manage the lifecycle of a CI/CD variables for a project."
  type = list(object({
    key               = string                      // The name of the variable.
    project           = optional(string)            // The name of the project.
    project_id        = optional(string)            // The id of the project.
    value             = string                      // The value of the variable.
    description       = optional(string)            // The description of the variable.
    environment_scope = optional(string)            // The environment scope of the variable. Defaults to all environment (*). Note that in Community Editions of Gitlab, values other than * will cause inconsistent plans.
    masked            = optional(bool, false)       //  If set to true, the value of the variable will be hidden in job logs. The value must meet the masking requirements.
    protected         = optional(bool, false)       // If set to true, the variable will be passed only to pipelines running on protected branches and tags.
    raw               = optional(bool, false)       // Whether the variable is treated as a raw string. When true, variables in the value are not expanded.
    variable_type     = optional(string, "env_var") // The type of a variable. Valid values are: env_var, file
  }))
  default = []
}

variable "deploy_key" {
  description = "Configiure the lifecycle of a deploy key."
  type = object({
    key      = string                // The public ssh key body.
    project  = string                // The name or id of the project to add the deploy key to.
    title    = string                // A title to describe the deploy key with.
    can_push = optional(bool, false) // Allow this deploy key to be used to push changes to the project. 
  })
  default = null
}

variable "deploy_keys" {
  description = "Configiure the lifecycle of a deploy keys."
  type = list(object({
    key      = string                // The public ssh key body.
    project  = string                // The name or id of the project to add the deploy key to.
    title    = string                // A title to describe the deploy key with.
    can_push = optional(bool, false) // Allow this deploy key to be used to push changes to the project. 
  }))
  default = []
}

variable "deploy_token" {
  description = "Set configuration of the lifecycle of group and project deploy tokens."
  type = object({
    name       = string           // A name to describe the deploy token with.
    scopes     = set(string)      // Valid values: read_repository, read_registry, read_package_registry, write_registry, write_package_registry.
    expires_at = optional(string) // Time the token will expire it, RFC3339 format. Will not expire per default.
    group      = optional(string) // The name or id of the group to add the deploy token to.
    project    = optional(string) // The name or id of the project to add the deploy token to.
    username   = optional(string) // A username for the deploy token. Default is gitlab+deploy-token-{n}.
  })
  default = null
}

variable "deploy_tokens" {
  description = "Set configuration of the lifecycle of group and project deploy tokens."
  type = list(object({
    name       = string           // A name to describe the deploy token with.
    scopes     = set(string)      // Valid values: read_repository, read_registry, read_package_registry, write_registry, write_package_registry.
    expires_at = optional(string) // Time the token will expire it, RFC3339 format. Will not expire per default.
    group      = optional(string) // The name or id of the group to add the deploy token to.
    project    = optional(string) // The name or id of the project to add the deploy token to.
    username   = optional(string) // A username for the deploy token. Default is gitlab+deploy-token-{n}.
  }))
  default = []
}

variable "pipeline_schedule" {
  description = "Configure the lifecycle of a scheduled pipeline."
  type = object({
    cron           = string           // The cron (e.g. 0 1 * * *).
    description    = string           // The description of the pipeline schedule.
    project        = string           // The name or id of the project to add the schedule to.
    ref            = string           // The branch/tag name to be triggered.
    active         = optional(bool)   // The activation of pipeline schedule. If false is set, the pipeline schedule will deactivated initially.
    cron_timezone  = optional(string) // The timezone.
    take_ownership = optional(bool)   // When set to true, the user represented by the token running Terraform will take ownership of the scheduled pipeline prior to editing it.
    variable = optional(list(object({
      key   = string // Name of the variable.
      value = string // Value of the variable.
    })))
  })
  default = null
}

variable "pipeline_schedules" {
  description = "Configure the lifecycle of a scheduled pipelines."
  type = list(object({
    cron           = string           // The cron (e.g. 0 1 * * *).
    description    = string           // The description of the pipeline schedule.
    project        = string           // The name or id of the project to add the schedule to.
    ref            = string           // The branch/tag name to be triggered.
    active         = optional(bool)   // The activation of pipeline schedule. If false is set, the pipeline schedule will deactivated initially.
    cron_timezone  = optional(string) // The timezone.
    take_ownership = optional(bool)   // When set to true, the user represented by the token running Terraform will take ownership of the scheduled pipeline prior to editing it.
    variable = optional(list(object({
      key   = string // Name of the variable.
      value = string // Value of the variable.
    })))
  }))
  default = []
}

variable "pages_domain" {
  description = "Allows connecting custom domains and TLS certificates in GitLab Pages"
  type = object({
    domain           = string           // The custom domain indicated by the user.
    project          = string           // The ID or URL-encoded path of the project owned by the authenticated user.
    auto_ssl_enabled = optional(bool)   //  Enables automatic generation of SSL certificates issued by Let’s Encrypt for custom domains. When this is set to "true", certificate can't be provided.
    certificate      = optional(string) // The certificate in PEM format with intermediates following in most specific to least specific order.
    expired          = optional(bool)   // Whether the certificate is expired.
    key              = optional(string) //The certificate key in PEM format.
  })
  default = null
}

variable "branch" {
  description = "Gitlab project branch"
  type = object({
    name    = string
    project = string
    ref     = string
  })
  default = null
}

variable "branches" {
  description = "Gitlab project branches"
  type = list(object({
    name    = string
    project = string
    ref     = string
  }))
  default = []
}

variable "pipeline_trigger" {
  description = "Gitlab project pipeline trigger"
  type = object({
    project     = string
    description = string
  })
  default = null
}

variable "pipeline_triggers" {
  description = "Gitlab project pipeline triggers"
  type = list(object({
    project     = string
    description = string
  }))
  default = []
}

variable "release_link" {
  description = "Gitlab project release link"
  type = object({
    name      = string           // The name of the link. Link names must be unique within the release.
    project   = string           // The ID or URL-encoded path of the project.
    tag_name  = string           // The tag associated with the Release.
    url       = string           // The URL of the link. Link URLs must be unique within the release.
    filepath  = optional(string) // Relative path for a Direct Asset link.
    link_type = optional(string) //  The type of the link. Valid values are other, runbook, image, package. Defaults to other.
  })
  default = null
}

variable "release_links" {
  description = "Gitlab project release links"
  type = list(object({
    name      = string           // The name of the link. Link names must be unique within the release.
    project   = string           // The ID or URL-encoded path of the project.
    tag_name  = string           // The tag associated with the Release.
    url       = string           // The URL of the link. Link URLs must be unique within the release.
    filepath  = optional(string) // Relative path for a Direct Asset link.
    link_type = optional(string) //  The type of the link. Valid values are other, runbook, image, package. Defaults to other.
  }))
  default = []
}

variable "repository_file" {
  description = "Gitlab project repo file"
  type = object({
    project               = string                     // The name or ID of the project.
    file_path             = string                     // The full path of the file. It must be relative to the root of the project without a leading slash / or ./
    branch                = string                     // Name of the branch to which to commit to.
    content               = string                     // File content.
    author_email          = optional(string)           // Email of the commit author.
    author_name           = optional(string)           // Name of the commit author.
    commit_message        = optional(string)           // Commit message.
    create_commit_message = optional(string)           // Create commit message.
    delete_commit_message = optional(string)           // Delete Commit message.
    encoding              = optional(string, "base64") // The file content encoding.
    execute_filemode      = optional(bool)             // Enables or disables the execute flag on the file.
    overwrite_on_create   = optional(bool, false)      // Enable overwriting existing files
    start_branch          = optional(string)           // Name of the branch to start the new commit from.
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    update_commit_message = optional(string) // Update commit message.
  })
  default = null
}

variable "repository_files" {
  description = "Gitlab project repo files"
  type = list(object({
    project               = string                     // The name or ID of the project.
    file_path             = string                     // The full path of the file. It must be relative to the root of the project without a leading slash / or ./
    branch                = string                     // Name of the branch to which to commit to.
    content               = string                     // File content.
    author_email          = optional(string)           // Email of the commit author.
    author_name           = optional(string)           // Name of the commit author.
    commit_message        = optional(string)           // Commit message.
    create_commit_message = optional(string)           // Create commit message.
    delete_commit_message = optional(string)           // Delete Commit message.
    encoding              = optional(string, "base64") // The file content encoding.
    execute_filemode      = optional(bool)             // Enables or disables the execute flag on the file.
    overwrite_on_create   = optional(bool, false)      // Enable overwriting existing files
    start_branch          = optional(string)           // Name of the branch to start the new commit from.
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    update_commit_message = optional(string) // Update commit message.
  }))
  default = []
}


variable "cluster_agent" {
  description = "Gitlab project cluster agent and cluster agent token management"
  type = object({
    name        = string                // The Name of the agent.
    project     = string                // ID or full path of the project maintained by the authenticated user.
    agent_id    = optional(number)      // The ID of the agent.
    description = optional(string)      // The Description for the agent.
    get_token   = optional(bool, false) // Get token after resource creation
  })
  default = null
}

variable "integration_custom_issue_tracker" {
  description = "Define custom issue tracker"
  type = object({
    issues_url  = string // The URL to view an issue in the external issue tracker. Must contain :id.
    project     = string // The ID or full path of the project for the custom issue tracker.
    project_url = string // The URL to the project in the external issue tracker.
  })
  default = null
}

variable "integration_emails_on_push" {
  description = "Define custom email on push service"
  type = object({
    project                   = string
    recipients                = string                      // Emails separated by whitespace.
    branches_to_be_notified   = optional(string, "default") // Branches to send notifications for.
    disable_diffs             = optional(bool)              // Disable code diffs.
    push_events               = optional(bool)              //Enable notifications for push events.
    send_from_committer_email = optional(bool)              // Send from committer.
    tag_push_events           = optional(bool)              // Enable notifications for tag push events.
  })
  validation {
    condition     = var.integration_emails_on_push == null ? true : contains(["all", "default", "protected", "default_and_protected"], lower(var.integration_emails_on_push.branches_to_be_notified))
    error_message = "Valid options are `all`, `default`, `protected`, `default_and_protected`"
  }
  default = null
}

variable "integration_external_wiki" {
  description = "Gitlab project external wiki"
  type = object({
    external_wiki_url = string // The URL of the external wiki.
    project           = string // ID of the project you want to activate integration on.
  })
  default = null
}

variable "integration_github" {
  description = "Gitlab project github intergation"
  type = object({
    project        = string         // ID of the project you want to activate integration on.
    repository_url = string         // The URL of the GitHub repo to integrate with
    token          = string         // A GitHub personal access token with at least repo:status scope
    static_context = optional(bool) // Append instance name instead of branch to the status.
  })
  default = null
}

variable "integration_jira" {
  description = "Gitlab project Jira intergration"
  type = object({
    project                  = string           // ID of the project you want to activate integration on.
    password                 = string           // The password of the user created to be used with GitLab/JIRA.
    username                 = string           // The URL to the JIRA project which is being linked to this GitLab project.
    url                      = string           // The username of the user created to be used with GitLab/JIRA.
    api_url                  = optional(string) // The base URL to the Jira instance API. 
    comment_on_event_enabled = optional(bool)   // Enable comments inside Jira issues on each GitLab event (commit / merge request)
    commit_events            = optional(bool)   // Enable notifications for commit events
    issues_events            = optional(bool)   // Enable notifications for issues events.
    jira_issue_transition_id = optional(string) // The ID of a transition that moves issues to a closed state
    job_events               = optional(bool)   // Enable notifications for job events.
    merge_requests_events    = optional(bool)   // Enable notifications for merge request events
    note_events              = optional(bool)   // Enable notifications for note events.
    pipeline_events          = optional(bool)   // Enable notifications for pipeline events.
    project_key              = optional(string) // The short identifier for your JIRA project, all uppercase, e.g., PROJ.
    push_events              = optional(bool)   // Enable notifications for push events.
    tag_push_events          = optional(bool)   // Enable notifications for tag_push events.
  })
  default = null
}

variable "integration_mattermost" {
  description = "Gitlab project Mattermost intergation"
  type = object({
    project                      = string                      // ID of the project you want to activate integration on.
    webhook                      = string                      // Webhook URL
    branches_to_be_notified      = optional(string, "default") // Branches to send notifications for. 
    confidential_issue_channel   = optional(string)            // The name of the channel to receive confidential issue events notifications.
    confidential_issues_events   = optional(bool)              // Enable notifications for confidential issues events.
    confidential_note_channel    = optional(string)            // The name of the channel to receive confidential note events notifications.
    confidential_note_events     = optional(bool)              // Enable notifications for confidential note events.
    issue_channel                = optional(string)            // The name of the channel to receive issue events notifications.
    issues_events                = optional(bool)              // Enable notifications for issues events.
    merge_request_channel        = optional(string)            // The name of the channel to receive merge request events notifications.
    merge_requests_events        = optional(bool)              // Enable notifications for merge requests events.
    note_channel                 = optional(string)            // The name of the channel to receive note events notifications.
    note_events                  = optional(bool)              // Enable notifications for note events.
    notify_only_broken_pipelines = optional(bool)              // Send notifications for broken pipelines.
    pipeline_channel             = optional(string)            // The name of the channel to receive pipeline events notifications.
    pipeline_events              = optional(bool)              // Enable notifications for pipeline events.
    push_channel                 = optional(string)            // The name of the channel to receive push events notifications.
    push_events                  = optional(bool)              //  Enable notifications for push events.
    tag_push_channel             = optional(string)            // The name of the channel to receive tag push events notifications.
    tag_push_events              = optional(bool)              // Enable notifications for tag push events.
    username                     = optional(string)            // Username to use.
    wiki_page_channel            = optional(string)            // The name of the channel to receive wiki page events notifications.
    wiki_page_events             = optional(string)            // Enable notifications for wiki page events.
  })
  validation {
    condition     = var.integration_mattermost == null ? true : contains(["all", "default", "protected", "default_and_protected"], lower(var.integration_mattermost.branches_to_be_notified))
    error_message = "Valid options are `all`, `default`, `protected`, `default_and_protected`"
  }
  default = null
}

variable "integration_microsoft_teams" {
  description = "Gitlab project Microsoft Teams integration"
  type = object({
    project                      = string                      // ID of the project you want to activate integration on.
    webhook                      = string                      // The Microsoft Teams webhook
    branches_to_be_notified      = optional(string, "default") // Branches to send notifications for.
    confidential_issues_events   = optional(bool)              // Enable notifications for confidential issue events
    confidential_note_events     = optional(bool)              // Enable notifications for confidential note events
    issues_events                = optional(bool)              // Enable notifications for issue events
    merge_requests_events        = optional(bool)              // Enable notifications for merge request events
    note_events                  = optional(bool)              // Enable notifications for note events
    notify_only_broken_pipelines = optional(bool)              // Send notifications for broken pipelines
    pipeline_events              = optional(bool)              // nable notifications for pipeline events
    push_events                  = optional(bool)              // Enable notifications for push events
    tag_push_events              = optional(bool)              // Enable notifications for tag push events
    wiki_page_events             = optional(bool)              // Enable notifications for wiki page events
  })
  validation {
    condition     = var.integration_microsoft_teams == null ? true : contains(["all", "default", "protected", "default_and_protected"], lower(var.integration_microsoft_teams.branches_to_be_notified))
    error_message = "Valid options are `all`, `default`, `protected`, `default_and_protected`"
  }
  default = null
}

variable "integration_pipelines_email" {
  description = ""
  type = object({
    project                      = string      // ID of the project you want to activate integration on.
    recipients                   = set(string) // email addresses where notifications are sent.
    branches_to_be_notified      = optional(string, "default")
    notify_only_broken_pipelines = optional(bool, true)
  })
  validation {
    condition     = var.integration_pipelines_email == null ? true : contains(["all", "default", "protected", "default_and_protected"], try(var.integration_pipelines_email.branches_to_be_notified, ""))
    error_message = "Valid options are `all`, `default`, `protected`, `default_and_protected`"
  }
  default = null
}

variable "integration_slack" {
  description = "Gitlab project Slack integration"
  type = object({
    project                      = optional(string)            // Name of the project you want to activate integration on.
    project_id                   = optional(string)            // ID of the project you want to activate integration on.
    webhook                      = string                      // Webhook URL
    branches_to_be_notified      = optional(string, "default") // Branches to send notifications for.
    confidential_issue_channel   = optional(string)            // The name of the channel to receive confidential issue events notifications.
    confidential_issues_events   = optional(bool)              // Enable notifications for confidential issues events.
    confidential_note_events     = optional(bool)              // Enable notifications for confidential note events.
    issue_channel                = optional(string)            // The name of the channel to receive issue events notifications.
    issues_events                = optional(bool)              // Enable notifications for issues events.
    merge_request_channel        = optional(string)            // The name of the channel to receive merge request events notifications.
    merge_requests_events        = optional(bool)              // Enable notifications for merge requests events.
    note_channel                 = optional(string)            // The name of the channel to receive note events notifications.
    note_events                  = optional(bool)              // Enable notifications for note events.
    notify_only_broken_pipelines = optional(bool)              // Send notifications for broken pipelines.
    pipeline_channel             = optional(string)            // The name of the channel to receive pipeline events notifications.
    pipeline_events              = optional(bool)              // Enable notifications for pipeline events.
    push_channel                 = optional(string)            // The name of the channel to receive push events notifications.
    push_events                  = optional(bool)              // Enable notifications for push events.
    tag_push_channel             = optional(string)            // The name of the channel to receive tag push events notifications.
    tag_push_events              = optional(bool)              // Enable notifications for tag push events.
    username                     = optional(string)            // Username to use.
    wiki_page_channel            = optional(string)            // The name of the channel to receive wiki page events notifications.
    wiki_page_events             = optional(bool)              // Enable notifications for wiki page events.
  })
  validation {
    condition     = var.integration_slack == null ? true : contains(["all", "default", "protected", "default_and_protected"], try(var.integration_slack.branches_to_be_notified, ""))
    error_message = "Valid options are `all`, `default`, `protected`, `default_and_protected`"
  }
  default = null
}