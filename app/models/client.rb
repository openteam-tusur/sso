class Client < ActiveRecord::Base

  attr_accessible :name, :app_id, :app_secret

  default_value_for :app_id do random_string(24) end

  default_value_for :app_secret do random_string(48) end

  def self.authenticate(app_id, app_secret)
    where(["app_id = ? AND app_secret = ?", app_id, app_secret]).first
  end

  def self.random_string(length)
    raise ArgumentError, "length must be dividable by 4" unless (length % 4).zero?
    Base64.urlsafe_encode64(SecureRandom.random_bytes(length/4*3))
  end
end
# == Schema Information
#
# Table name: clients
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  app_id     :string(255)
#  app_secret :string(255)
#  created_at :datetime
#  updated_at :datetime
#

