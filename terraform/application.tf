data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "app_1" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.app_1.id
  vpc_security_group_ids      = [aws_security_group.application.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.application.name
  user_data                   = file("${path.module}/../docker/user-data.sh")

  tags = {
    Name = "${var.project_name}-${var.environment}-app-1"
    Tier = "application"
  }
}

resource "aws_instance" "app_2" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.app_2.id
  vpc_security_group_ids      = [aws_security_group.application.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.application.name
  user_data                   = file("${path.module}/../docker/user-data.sh")

  tags = {
    Name = "${var.project_name}-${var.environment}-app-2"
    Tier = "application"
  }
}

resource "aws_lb_target_group_attachment" "app_1" {
  target_group_arn = aws_lb_target_group.application.arn
  target_id        = aws_instance.app_1.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "app_2" {
  target_group_arn = aws_lb_target_group.application.arn
  target_id        = aws_instance.app_2.id
  port             = 8080
}
