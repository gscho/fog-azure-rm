module Fog
  module Storage
    class AzureRM
      class Real
        def create_storage_account(resource_group_name, name, params)
          @storage_mgmt_client.storage_accounts.create(resource_group_name, name, params)
        end
      end

      class Mock
        def create_storage_account(resource_group_name, name, params)
        end
      end
    end
  end
end
