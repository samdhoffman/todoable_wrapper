require 'httparty'

module TodoableWrapper
  class Client
    module List
    
      def lists(options = {})
        validate_token
        options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.get('/lists', options)
        if response.success?
          JSON.parse(response.body)
        else
          response
        end
      end
    
      def get_list_by_id(id)
        validate_token
        options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.get("/lists/#{id}", options)
        if response.success?
          JSON.parse(response.body)
        else
          response
        end
      end
    
      def create_list(list_name)
        validate_token
        list = { list: {name: list_name} }
        options = { body: list.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.post("/lists", options)
        response.code
      end
    
      def update_list(id, list_name)
        validate_token
        list = { list: {name: list_name} }
        options = { body: list.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.patch("/lists/#{id}", options)
        response.code
      end
    
      def delete_list(id)
        validate_token
        options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
        response = self.class.delete("/lists/#{id}", options)
        response.code
      end

    end
  end
end

