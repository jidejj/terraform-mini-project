output "vpc_id" {
    value = aws_vpc.inst_vpc.id
}

output "elb_load_balancer_dns_name" {
    value = aws_lb.inst-load-balancer.dns_name
}
