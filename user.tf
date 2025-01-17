resource "aws_iam_user" "lb" {
  for_each = ["jihuo", "sana", "momo", "dahyun"]
  name = each.value


}



