module Fog
  module Network
    class AzureRM
      # Real class for Network Request
      class Real
        def create_subnet(resource_group, name, virtual_network_name, addressPrefix)
          Fog::Logger.debug "Creating Subnet: #{name}..."
          subnet_properties = Azure::ARM::Network::Models::SubnetPropertiesFormat.new
          subnet_properties.address_prefix = addressPrefix unless addressPrefix.nil?

          subnet = Azure::ARM::Network::Models::Subnet.new
          subnet.name = name
          subnet.properties = subnet_properties
          begin
            promise = @network_client.subnets.create_or_update(resource_group, virtual_network_name, name, subnet)
            result = promise.value!
            Fog::Logger.debug "Subnet #{name} created successfully."
            Azure::ARM::Network::Models::Subnet.serialize_object(result.body)
          rescue  MsRestAzure::AzureOperationError => e
            msg = "Exception creating Subnet #{name} in Resource Group: #{resource_group}. #{e.body['error']['message']}"
            raise msg
          end
        end
      end

      # Mock class for Network Request
      class Mock
        def create_subnet(resource_group, name, virtual_network_name, addressPrefix)
          {
              'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{resource_group}/providers/Microsoft.Network/virtualNetworks/#{virtual_network_name}/subnets/#{name}",
              'properties' =>
                  {
                      'addressPrefix' => addressPrefix,
                      'provisioningState' => 'Succeeded'
                  },
              'name' => name,
              'etag' => "W/\"88188301-2b72-4243-a734-996d4851c308\""
          }
        end
      end
    end
  end
end