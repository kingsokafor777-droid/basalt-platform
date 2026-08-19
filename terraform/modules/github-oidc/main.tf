resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  tags            = var.tags
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = tolist(var.github_subjects)
    }
  }
}

resource "aws_iam_role" "deploy" {
  name               = "${var.name}-github-deploy"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "release" {
  statement {
    sid       = "ReadReleaseArtifacts"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [var.artifact_bucket_arn, "${var.artifact_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "release" {
  name   = "${var.name}-release"
  role   = aws_iam_role.deploy.id
  policy = data.aws_iam_policy_document.release.json
}
