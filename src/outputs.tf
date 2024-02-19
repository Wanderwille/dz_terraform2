output "VPS" {
  value = {
    instance1 = {
      instance_name = yandex_compute_instance.platform.name
      external_ip = yandex_compute_instance.platform.network_interface[0].nat_ip_address
      fqdn = "${yandex_compute_instance.platform.name}.fhmft88e3emv2hll44sk.auto.internal." 
    }
    instance2 = {
      instance_name = yandex_compute_instance.platform2.name
      external_ip = yandex_compute_instance.platform2.network_interface[0].nat_ip_address
      fqdn = "${yandex_compute_instance.platform2.name}.fhmtroc3t80mf5f11tgn.auto.internal." 
    }
  }
}