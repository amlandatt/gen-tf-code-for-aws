
data "template_file" "user_data" {
  count    = var.instance-count
  template = file(var.instance-file-path)
  // If variavles need to pass in instance file , can be done in following way
  /*
  vars = {
    edgewise_file_name = "${var.edgewise_agent_file_name}"
    hname               = "${element(var.hostname, count.index)}"
  }
  */
}

resource "aws_instance" "gen-instance" {
  count                  = var.instance-count
  ami                    = var.instance-ami
  instance_type          = var.instance-type
  private_ip             = element(var.instance-private-ip, count.index)
  availability_zone      = element(var.all-az, count.index)
  subnet_id              = element(var.all-subnets-id, count.index)
  vpc_security_group_ids = [var.security-group-id]
  // iam_instance_profile   = var.instance_role_profile_name
  user_data              = data.template_file.user_data[count.index].rendered
  key_name               = var.my-key-name
  // disable_api_termination = true
  root_block_device {
        volume_type = var.root-volume-type
        volume_size = var.root-volume-size
        encrypted   = true
        // Need to check , why following variable is required 
       // kms_key_id = var.ebs_sse_kms_key_arn
  }

   dynamic "ebs_block_device" {

    for_each = var.ebs_block_device
    content {
      device_name = ebs_block_device.value.addl-disk-name
      volume_type = ebs_block_device.value.addl-disk-type
      volume_size  = ebs_block_device.value.addl-disk-size
      encrypted   = true
    }

   } 
   
    tags =  { Name = "${var.ec2-instance-name}-${count.index + 1}-az(${substr(element(var.all-az, count.index) , length(element(var.all-az, count.index)) -2,2 )})" }

}
