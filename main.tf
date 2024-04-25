resource "azurerm_public_ip" "azurerm_public_ip" {
  name                = "${var.name}-lb-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = "Standard"
}
resource "azurerm_lb" "azurerm_lb" {
  resource_group_name = var.resource_group_name
  name                = "${var.name}-loadbalancer"
  location            = var.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  frontend_ip_configuration {
    name                 = azurerm_public_ip.azurerm_public_ip.name
    public_ip_address_id = azurerm_public_ip.azurerm_public_ip.id
  }
}
resource "azurerm_lb_backend_address_pool" "azurerm_lb_backend_address_pool" {
  name            = "${var.name}-backend-pool"
  loadbalancer_id = azurerm_lb.azurerm_lb.id
}
resource "azurerm_lb_probe" "azurerm_lb_probe" {
  for_each = toset(var.ports)
  loadbalancer_id = azurerm_lb.azurerm_lb.id
  name            = "${split("-",each.value)[0]}-running-probe"
  port            = split("-",each.value)[1]
}
resource "azurerm_lb_rule" "lbnatrule" {
  for_each = toset(var.ports)
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  name                           = split("-",each.value)[0]
  protocol                       = split("-",each.value)[2]
  frontend_port                  = split("-",each.value)[1]
  backend_port                   = split("-",each.value)[1]
  backend_address_pool_ids       = [
    azurerm_lb_backend_address_pool.azurerm_lb_backend_address_pool.id
  ]
  frontend_ip_configuration_name = azurerm_public_ip.azurerm_public_ip.name
  probe_id                       = azurerm_lb_probe.azurerm_lb_probe[each.value].id
}
