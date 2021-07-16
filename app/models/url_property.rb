class UrlProperty < ApplicationRecord 
    def generate_key
        self.unique_url_key = Array.new(5){[*"a".."z", *"0".."9"].sample}.join
    end      
end
