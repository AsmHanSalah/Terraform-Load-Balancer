module "vpc" {
  source   = "./vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "load-balancer-vpc"
}


# subnets
module "public_subnet_1" {
  source      = "./subnet"
  vpc_id      = module.vpc.vpc_lb_id
  cidr = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  subnet_name = "public-subnet1"
  map_on_launch = true
}

module "public_subnet_2" {
  source      = "./subnet"
  vpc_id      = module.vpc.vpc_lb_id
  cidr = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  subnet_name = "public-subnet2"
  map_on_launch = true
}
module "private_subnet_1" {
  source      = "./subnet"
  vpc_id      = module.vpc.vpc_lb_id
  cidr = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  subnet_name = "private-subnet1"
  map_on_launch = false
}
module "private_subnet_2" {
  source      = "./subnet"
  vpc_id      = module.vpc.vpc_lb_id
  cidr = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  subnet_name = "private-subnet2"
  map_on_launch = false
}

module "internet_gateway" {
  source = "./internet_gateway"
  vpc_id = module.vpc.vpc_lb_id
  name   = "internet_gateway"
}

module "nat" {
  source    = "./nat_gateway"
  subnet_id = module.public_subnet_1.subnet_id
  nat_name  = "load-balancer"
}

# public routing table
module "public_routing_table" {
  source             = "./route_table"
  vpc_id             = module.vpc.vpc_lb_id
  gateway_id         = module.internet_gateway.internet_gateway_id
  routing_table_name = "public-routing-table"
}


# private routing table
module "private_routing_table" {
  source             = "./route_table"
  vpc_id             = module.vpc.vpc_lb_id
  gateway_id         = module.nat.nat_gateway_id
  routing_table_name = "private-routing-table"
}

# public subnet 1 assossiation
module "public_assosiation_1" {
  source               = "./association"
  subnet_id            = module.public_subnet_1.subnet_id
  route_table_id       = module.public_routing_table.routing_table_id
}
# public subnet 2 assossiation
module "public_assosiation_2" {
  source               = "./association"
  subnet_id            = module.public_subnet_2.subnet_id
  route_table_id       = module.public_routing_table.routing_table_id
}


# private subnet 1 assossiation
module "private_assosiation_1" {
  source               = "./association"
  subnet_id            = module.private_subnet_1.subnet_id
  route_table_id       = module.private_routing_table.routing_table_id
}


# private subnet 1 assossiation
module "private_assosiation_2" {
  source               = "./association"
  subnet_id            = module.private_subnet_2.subnet_id
  route_table_id       = module.private_routing_table.routing_table_id
}


# security group
module "security_groups" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_lb_id
}


#key pair
module "key_pair" {
  source   = "./key-pair"
  key_name = "loadbalancer_key"
}

# instances
module "instances" {
  source                    = "./instances"
  ami_id                    = "ami-0a0e5d9c7acc336f1" 
  instance_type             = "t2.micro"

  depends_on = [ module.nat , module.internet_gateway ]

  public_subnet_id          = module.public_subnet_1.subnet_id
  public_sg_id              = module.security_groups.bastion_host_security_group_id

  private_subnet_1_id       = module.private_subnet_1.subnet_id
  private_subnet_2_id       = module.private_subnet_2.subnet_id
  private_sg_id             = module.security_groups.private_security_id

  key_name                  = module.key_pair.key_name
 
}
# Load Balancer
module "load_balancer" {
  source                = "./load_balancer"
  vpc_id                = module.vpc.vpc_lb_id
  public_subnets_id        = [module.public_subnet_1.subnet_id , module.public_subnet_2.subnet_id]

  private_id_1= module.instances.private_1_id
  private_id_2 = module.instances.private_2_id

  alb_sg_id             = module.security_groups.alb_security_group_id
}


