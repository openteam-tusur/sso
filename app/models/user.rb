# encoding: utf-8

class User < ActiveRecord::Base
  has_many :authentications, :dependent => :delete_all
  has_many :access_grants, :dependent => :delete_all

  before_validation :initialize_fields, :on => :create

  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :timeoutable, :trackable, :validatable, :rememberable

  self.token_authentication_key = "oauth_token"

  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_name, :first_name, :middle_name

  NAME_FORMAT = /^[А-ЯЁ][а-яё -]*[а-яё]$/

  validates_presence_of :first_name

  validates_presence_of :last_name, :unless => :admin?

  validates_format_of :last_name, :first_name,  :with => NAME_FORMAT,
                                                :message => :contains_not_cyrillic_chars,
                                                :unless => :admin?

  validates_format_of :middle_name, :with => NAME_FORMAT,
                                    :message => :contains_not_cyrillic_chars,
                                    :if => :middle_name?,
                                    :unless => :admin?

  validates_length_of :last_name, :first_name, :middle_name, :email, :maximum => 255

  alias_attribute :uid, :id

  searchable do
    text :term do
      "#{email} #{name}"
    end
  end

  def name
    [first_name, middle_name, last_name].keep_if(&:present?).join(' ')
  end

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def self.find_for_token_authentication(conditions)
    where(["access_grants.access_token = ? AND (access_grants.access_token_expires_at IS NULL OR access_grants.access_token_expires_at > ?)", conditions[token_authentication_key], Time.now]).joins(:access_grants).select("users.*").first
  end

  def initialize_fields
    self.status = "Active"
    self.expiration_date = 1.year.from_now
  end

  def regular?
    !admin?
  end

  alias :to_s :name
end
# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  authentication_token :string(255)
#  admin                :boolean         default(FALSE)
#  first_name           :string(255)
#  last_name            :string(255)
#  status               :string(255)
#  expiration_date      :date
#  created_at           :datetime
#  updated_at           :datetime
#  middle_name          :string(255)
#

