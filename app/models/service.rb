class Service
  include Mongoid::Document

  belongs_to :user

  field :provider
  field :uid
  field :uname
  field :token
  field :secret

end