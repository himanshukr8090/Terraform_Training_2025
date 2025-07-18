# x="himanshu"

variable "x" {
	type = string
  default = "himanshu"
}

# print("x")

output "o1" {
  value = "Hi, From Himanshu Singh"

}

output "o2" {
  value = "hi ${var.x}"  
}


variable "multilinevar1" {
  type = string
  default = <<EOH
    this is line 1.
    2nd line
    3rd line
    byy
    EOH
}

output "o3" {
  value = var.multilinevar1
}

variable "mylist" {
  type = list
  default = ["Himanshu" , "Rahul" , "Dubay" , "Ashu"]
}

output "o4" {
  value = var.mylist[2]
}

