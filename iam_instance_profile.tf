resource "aws_iam_role" "main" {
  name               = format("%s-instance-profile-%s-%s", var.project_name, var.env, var.environment)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_role" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "main" {
  name = format("%s-instance-profile-%s-%s", var.project_name, var.env, var.environment)
  role = aws_iam_role.main.name
}


######################################################################################################################

data "aws_iam_policy_document" "ec2_ecs_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "app_ecs_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2_ecs_scalling_role" {
  statement {
    sid    = "ECSServiceQueima"
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "ECSUpdateService"
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "ecs:PutAccountSetting"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "ECSIncludeEC2Permission"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["iam:PassRole"]
    effect    = "Allow"
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"

      values = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy" "CloudWatchLogsFullAccess" {
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

data "aws_iam_policy" "AmazonEC2ContainerServiceforEC2Role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions = [
      "ecs:RegisterTaskDefinition",
      "ssm:PutParameter",
      "ssm:GetParameter",
    ]
    resources = ["*"]
  }
}