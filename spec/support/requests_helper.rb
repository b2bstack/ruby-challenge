module RequestsHelper

    def get_with_token(path, params={}, headers={}, null_token=false)
        if null_token == false
            headers.merge!('Authorization' => retrieve_access_token)
            get path, params: params, headers: headers
        else
            get path, params: params, headers: headers
        end
    end
  
    def post_with_token(path, params={}, headers={}, null_token=false)
        if null_token == false
            headers.merge!('Authorization' => retrieve_access_token)
            post path, params: params, headers: headers
        else 
            post path, params: params, headers: headers
        end
    end
  
end