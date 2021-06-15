resource "aws_iam_user" "delegator" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_access_key" "delegator" {
  user = aws_iam_user.delegator.name
}

resource "aws_iam_user_policy" "delegator" {
  user   = aws_iam_user.delegator.name
  policy = data.aws_iam_policy_document.delegator.json
}

data "aws_iam_policy_document" "delegator" {
  statement {
    sid    = "ReadDomainZone"
    effect = "Allow"

    actions = [
      "route53:GetHostedZone", // TF needs to build the record
    ]

    resources = ["arn:aws:route53:::hostedzone/${var.zone_id}"]
  }

  statement {
    sid    = "AlterRecordsInDomainZone"
    effect = "Allow"

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
    ]

    resources = ["arn:aws:route53:::hostedzone/${var.zone_id}"]
  }

  // This statement is used to monitor changes that are issued as batch changes through ChangeResourceRecordSets
  // It's impossible to know the resource ARN because the ID is created for every batch change
  statement {
    sid    = "MonitorRecordChanges"
    effect = "Allow"

    actions = [
      "route53:GetChange"
    ]

    resources = ["*"]
  }
}
