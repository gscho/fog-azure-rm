require 'fog/core/collection'
require 'fog/azurerm/models/network/subnet'

module Fog
  module Network
    class AzureRM
      class Subnets < Fog::Collection
        model Fog::Network::AzureRM::Subnet

        def self.deserialize_subnets_list(subnets_list)
          subnets = []
          subnets_list.each do |subnet|
            subnet_obj = Fog::Network::AzureRM::Subnet.new
            subnet_obj.name = subnet['name']
            subnet_obj.id = subnet['id']
            subnet_obj.resource_group = subnet['id'].split('/')[4]
            subnet_obj.addressPrefix = subnet['properties']['addressPrefix']
            subnet_obj.ipConfigurations = subnet['properties']['ipConfigurations']
            subnets << subnet_obj
          end unless subnets_list.nil?
          subnets
        end
      end
    end
  end
end