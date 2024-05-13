data "gitlab_compliance_framework" "this" {
  for_each = {
    for framework in var.compliance_frameworks : framework.compliance_framework_id => framework
    if length(var.compliance_frameworks) > 0 && contains(["premium", "ultimate"], lower(var.tier))
  }

  namespace_path = try(each.value.namespace_path, each.value.compliance_framework_id)
  name           = try(each.value.name, each.value.compliance_framework_id)
}

resource "gitlab_project_compliance_framework" "this" {
  for_each = {
    for framework in var.compliance_frameworks : framework.compliance_framework_id => framework
    if length(var.compliance_frameworks) > 0 && contains(["premium", "ultimate"], lower(var.tier))
  }

  compliance_framework_id = coalesce(each.value.compliance_framework_id, data.gitlab_compliance_framework.this[each.value.compliance_framework_id].framework_id)
  project                 = coalesce(local._projects[each.value.project].id, one(gitlab_project.this[*].id))
}