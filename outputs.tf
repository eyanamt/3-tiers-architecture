########################################
# Réseau
########################################

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "app_subnet_ids" {
  value = [aws_subnet.app_1.id, aws_subnet.app_2.id]
}

output "data_subnet_ids" {
  value = [aws_subnet.data_1.id, aws_subnet.data_2.id]
}

output "nat_gateway_ids" {
  description = "IDs des 2 NAT Gateways (une par AZ, pour la haute disponibilité)"
  value       = [aws_nat_gateway.nat_1.id, aws_nat_gateway.nat_2.id]
}

########################################
# Sécurité / WAF
########################################

output "web_acl_arn" {
  value = aws_wafv2_web_acl.main.arn
}

########################################
# Applicatif
########################################

output "web_alb_dns_name" {
  description = "URL publique de l'application"
  value       = aws_lb.web.dns_name
}

output "app_alb_dns_name" {
  description = "DNS interne du load balancer applicatif"
  value       = aws_lb.app.dns_name
}

########################################
# Base de données
########################################

output "database_endpoint" {
  value = aws_db_instance.main.address
}

output "database_port" {
  value = aws_db_instance.main.port
}
