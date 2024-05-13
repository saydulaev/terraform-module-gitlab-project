resource "gitlab_integration_custom_issue_tracker" "this" {
  count = var.integration_custom_issue_tracker != null ? 1 : 0

  project     = coalesce(local._projects[var.integration_custom_issue_tracker.project].id, one(gitlab_project.this[*].id))
  project_url = var.integration_custom_issue_tracker.project_url
  issues_url  = var.integration_custom_issue_tracker.issues_url
}

resource "gitlab_integration_emails_on_push" "this" {
  count = var.integration_emails_on_push != null ? 1 : 0

  project                   = coalesce(local._projects[var.integration_emails_on_push.project].id, one(gitlab_project.this[*].id))
  recipients                = var.integration_emails_on_push.recipients
  branches_to_be_notified   = var.integration_emails_on_push.branches_to_be_notified
  disable_diffs             = var.integration_emails_on_push.disable_diffs
  push_events               = var.integration_emails_on_push.push_events
  send_from_committer_email = var.integration_emails_on_push.send_from_committer_email
  tag_push_events           = var.integration_emails_on_push.tag_push_events
}


resource "gitlab_integration_external_wiki" "this" {
  count = var.integration_external_wiki != null ? 1 : 0

  project           = coalesce(local._projects[var.integration_external_wiki.project].id, one(gitlab_project.this[*].id))
  external_wiki_url = var.integration_external_wiki.external_wiki_url
}


resource "gitlab_integration_github" "this" {
  count = var.integration_github != null ? 1 : 0

  project        = coalesce(local._projects[var.integration_github.project].id, one(gitlab_project.this[*].id))
  token          = var.integration_github.token
  repository_url = var.integration_github.repository_url
  static_context = var.integration_github.static_context
}

resource "gitlab_integration_jira" "this" {
  count = var.integration_jira != null ? 1 : 0

  project                  = coalesce(local._projects[var.integration_jira.project].id, one(gitlab_project.this[*].id))
  url                      = var.integration_jira.url
  username                 = var.integration_jira.username
  password                 = var.integration_jira.password
  api_url                  = var.integration_jira.api_url
  comment_on_event_enabled = var.integration_jira.comment_on_event_enabled
  commit_events            = var.integration_jira.commit_events
  issues_events            = var.integration_jira.issues_events
  jira_issue_transition_id = var.integration_jira.jira_issue_transition_id
  job_events               = var.integration_jira.job_events
  merge_requests_events    = var.integration_jira.merge_requests_events
  note_events              = var.integration_jira.note_events
  pipeline_events          = var.integration_jira.pipeline_events
  project_key              = var.integration_jira.project_key
  push_events              = var.integration_jira.push_events
  tag_push_events          = var.integration_jira.tag_push_events
}


resource "gitlab_integration_mattermost" "this" {
  count = var.integration_mattermost != null ? 1 : 0

  project                      = coalesce(local._projects[var.integration_mattermost.project].id, one(gitlab_project.this[*].id))
  webhook                      = var.integration_mattermost.webhook
  branches_to_be_notified      = var.integration_mattermost.branches_to_be_notified
  confidential_issue_channel   = var.integration_mattermost.confidential_issue_channel
  confidential_issues_events   = var.integration_mattermost.confidential_issues_events
  confidential_note_channel    = var.integration_mattermost.confidential_note_channel
  confidential_note_events     = var.integration_mattermost.confidential_note_events
  issue_channel                = var.integration_mattermost.issue_channel
  issues_events                = var.integration_mattermost.issues_events
  merge_request_channel        = var.integration_mattermost.merge_request_channel
  merge_requests_events        = var.integration_mattermost.merge_requests_events
  note_channel                 = var.integration_mattermost.note_channel
  note_events                  = var.integration_mattermost.note_events
  notify_only_broken_pipelines = var.integration_mattermost.notify_only_broken_pipelines
  pipeline_channel             = var.integration_mattermost.pipeline_channel
  pipeline_events              = var.integration_mattermost.pipeline_events
  push_channel                 = var.integration_mattermost.push_channel
  push_events                  = var.integration_mattermost.push_events
  tag_push_channel             = var.integration_mattermost.tag_push_channel
  tag_push_events              = var.integration_mattermost.tag_push_events
  username                     = var.integration_mattermost.username
  wiki_page_channel            = var.integration_mattermost.wiki_page_channel
  wiki_page_events             = var.integration_mattermost.wiki_page_events
}


resource "gitlab_integration_microsoft_teams" "this" {
  count = var.integration_microsoft_teams != null ? 1 : 0

  project                      = coalesce(local._projects[var.integration_microsoft_teams.project].id, one(gitlab_project.this[*].id))
  webhook                      = var.integration_microsoft_teams.webhook
  branches_to_be_notified      = var.integration_microsoft_teams.branches_to_be_notified
  confidential_issues_events   = var.integration_microsoft_teams.confidential_issues_events
  confidential_note_events     = var.integration_microsoft_teams.confidential_note_events
  issues_events                = var.integration_microsoft_teams.issues_events
  merge_requests_events        = var.integration_microsoft_teams.merge_requests_events
  note_events                  = var.integration_microsoft_teams.note_events
  notify_only_broken_pipelines = var.integration_microsoft_teams.notify_only_broken_pipelines
  pipeline_events              = var.integration_microsoft_teams.pipeline_events
  push_events                  = var.integration_microsoft_teams.push_events
  tag_push_events              = var.integration_microsoft_teams.tag_push_events
  wiki_page_events             = var.integration_microsoft_teams.wiki_page_events
}


resource "gitlab_integration_pipelines_email" "this" {
  count = var.integration_pipelines_email != null ? 1 : 0

  project                      = coalesce(local._projects[var.integration_pipelines_email.project].id, one(gitlab_project.this[*].id))
  recipients                   = var.integration_pipelines_email.recipients
  notify_only_broken_pipelines = var.integration_pipelines_email.notify_only_broken_pipelines
  branches_to_be_notified      = var.integration_pipelines_email.branches_to_be_notified
}


resource "gitlab_integration_slack" "this" {
  count = var.integration_slack != null ? 1 : 0

  project                      = coalesce(local._projects[var.integration_slack.project].id, one(gitlab_project.this[*].id))
  webhook                      = var.integration_slack.webhook
  branches_to_be_notified      = var.integration_slack.branches_to_be_notified
  confidential_issue_channel   = var.integration_slack.confidential_issue_channel
  confidential_issues_events   = var.integration_slack.confidential_issues_events
  confidential_note_events     = var.integration_slack.confidential_note_events
  issue_channel                = var.integration_slack.issue_channel
  issues_events                = var.integration_slack.issues_events
  merge_request_channel        = var.integration_slack.merge_request_channel
  merge_requests_events        = var.integration_slack.merge_requests_events
  note_channel                 = var.integration_slack.note_channel
  note_events                  = var.integration_slack.note_events
  notify_only_broken_pipelines = var.integration_slack.notify_only_broken_pipelines
  pipeline_channel             = var.integration_slack.pipeline_channel
  pipeline_events              = var.integration_slack.pipeline_events
  push_channel                 = var.integration_slack.push_channel
  push_events                  = var.integration_slack.push_events
  tag_push_channel             = var.integration_slack.tag_push_channel
  tag_push_events              = var.integration_slack.tag_push_events
  username                     = var.integration_slack.username
  wiki_page_channel            = var.integration_slack.wiki_page_channel
  wiki_page_events             = var.integration_slack.wiki_page_events
}
