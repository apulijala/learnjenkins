variable "port" {
  description = "Port for the jenkins"
  default     = 8080
}

variable "name" {
  description = "Name of the Jenkins machine"
  default     = "jenkins-security"
}

variable "volume_size" {
  description = "Size of the volume"
  default     = 32
}

variable "volume_name" {
  description = "Name of the volume"
  default     = "jenkins-volume"
}

variable "machine_name" {
  description = "Name of the machine"
  default     = "jenkins-instance"
}




