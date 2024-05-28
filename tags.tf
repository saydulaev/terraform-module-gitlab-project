/*
#~~~~~~~~~~~~~ tag ~~~~~~~~~~~~~#
data "gitlab_project_branches" "branch" {
  count = var.tag != null ? 1 : 0

  project = tostring(coalesce(local._projects[var.tag.project].id, one(gitlab_project.this[*].id), var.tag.project))
}

// locals {
//   _project_branches = {
//     for branch in distinct(flatten(values(data.gitlab_project_branches.branch)[*].branches)) : branch.name => branch
//   }
// }

resource "gitlab_project_tag" "tag" {
  count = var.tag != null ? 1 : 0

  project = tostring(coalesce(local._projects[var.tag.project].id, one(gitlab_project.this[*].id), var.tag.project))
  name    = var.tag.name
  ref     = local._project_branches[var.tag.ref].name // each.value.ref
  message = var.tag.message
}

#~~~~~~~~~~~~~ tags ~~~~~~~~~~~~~#
data "gitlab_project_branches" "branches" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
}

locals {
  _project_branches = {
    for branch in distinct(coalescelist(flatten(values(data.gitlab_project_branches.branches)[*].branches), one(data.gitlab_project_branches.branch[*].branches))) : branch.name => branch
  }
}

resource "gitlab_project_tag" "tags" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  name    = each.value.name
  ref     = local._project_branches[each.value.ref].name // each.value.ref
  message = each.value.message
}

#~~~~~~~~~~~~~ protected tag ~~~~~~~~~~~~~#
data "gitlab_project_tags" "tag" {
  count = var.tag != null ? 1 : 0

  project = tostring(coalesce(local._projects[var.tag.project].id, one(gitlab_project.this[*].id), var.tag.project))

  depends_on = [
    gitlab_project_tag.tag
  ]
}

// locals {
//   _gitlab_project_tags = {
//     for tag in distinct(flatten(values(data.gitlab_project_tags.tag)[*].tags)) : tag.name => tag
//   }
// }

resource "gitlab_tag_protection" "tag" {
  count = var.tag != null ? 1 : 0

  project             = tostring(coalesce(local._projects[var.tag.project].id, one(gitlab_project.this[*].id), var.tag.project))
  tag                 = coalesce(try(local._gitlab_project_tags[var.tag.name].name, null), gitlab_project_tag.tag[var.tag.name].id)
  create_access_level = var.tag.create_access_level
  dynamic "allowed_to_create" {
    for_each = length(var.tag.allowed_to_create) > 0 && contains(["premium", "ultimate"], lower(var.tier)) ? toset(var.tag.allowed_to_create) : []
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
    gitlab_project_tag.tag
  ]
}

#~~~~~~~~~~~~~ protected tags ~~~~~~~~~~~~~#
data "gitlab_project_tags" "tags" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0 && tag.protected == true
  }

  project = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))

  depends_on = [
    gitlab_project_tag.tags
  ]
}

locals {
  _gitlab_project_tags = {
    for tag in distinct(coalescelist(flatten(values(data.gitlab_project_tags.tags)[*].tags), one(data.gitlab_project_tags.tag[*].tags))) : tag.name => tag
  }
}

resource "gitlab_tag_protection" "tags" {
  for_each = {
    for tag in var.tags : tag.name => tag
    if length(var.tags) > 0 && tag.protected == true
  }

  project             = tostring(coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id)))
  tag                 = coalesce(try(local._gitlab_project_tags[each.value.name].name, null), gitlab_project_tag.tags[each.value.name].id)
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
    gitlab_project_tag.tags
  ]
}
*/