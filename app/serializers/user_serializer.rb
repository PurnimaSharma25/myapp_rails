require 'jsonapi-serializers'

class UserSerializer
  include JSONAPI::Serializer

  attribute :fname
  attribute :id
  attribute :lname
  attribute :email
  attribute :auth_token
  attribute :friends do
    friends = []
  	object.reload.friends.each do |friend |
  		friends.push({fname: friend.fname, lname: friend.lname, email: friend.email})
    end
    friends
  end
end