output "load_balancer_dns" {
  description = "O nome DNS do Load Balancer criado. "
  value       = aws_lb.main.dns_name
}

output "lb_ssm_arn" {
  description = "O Amazon Resource Name ARN do Load Balancer."
  value       = aws_ssm_parameter.lb_arn.id
}

output "lb_ssm_listener" {
  description = "O ID do parâmetro."
  value       = aws_ssm_parameter.lb_listener.id
}

output "aws_account_id" {
  description = "ID da conta AWS onde os recursos estão sendo criados"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_ssm_parameter" {
  description = "Valor do parametro subnet id"
  value       =  data.aws_ssm_parameter.subnet_private_1a.value
  sensitive   = true
} 