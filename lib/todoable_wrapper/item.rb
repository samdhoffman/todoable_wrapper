require 'httparty'

module TodoableWrapper
  class Client
    module Item
    
      def add_item(id, item_name)
        validate_token
        item = { item: {name: item_name} }
        options = { body: item.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.post("/lists/#{id}/items", options)
        response.code
      end
    
      def delete_item(list_id, item_id)
        validate_token
        options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.delete("/lists/#{list_id}/items/#{item_id}", options)
        response.code
      end
    
      def finish_item(list_id, item_id)
        validate_token
        options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.put("/lists/#{list_id}/items/#{item_id}/finish", options)
        response.code
      end

    end
  end
end