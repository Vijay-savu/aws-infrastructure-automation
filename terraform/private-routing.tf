resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  depends_on = [
    aws_internet_gateway.main
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}

resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-rt"
    Tier = "application"
  }
}

resource "aws_route" "private_app_internet" {
  route_table_id         = aws_route_table.private_app.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private_app_1" {
  route_table_id = aws_route_table.private_app.id
  subnet_id      = aws_subnet.app_1.id
}

resource "aws_route_table_association" "private_app_2" {
  route_table_id = aws_route_table.private_app.id
  subnet_id      = aws_subnet.app_2.id
}

resource "aws_route_table" "private_database" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-database-rt"
    Tier = "database"
  }
}

resource "aws_route_table_association" "private_database_1" {
  route_table_id = aws_route_table.private_database.id
  subnet_id      = aws_subnet.database_1.id
}

resource "aws_route_table_association" "private_database_2" {
  route_table_id = aws_route_table.private_database.id
  subnet_id      = aws_subnet.database_2.id
}