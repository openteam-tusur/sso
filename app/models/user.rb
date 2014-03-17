# encoding: utf-8

class User < ActiveRecord::Base
  has_many :authentications, :dependent => :delete_all
  has_many :access_grants, :dependent => :delete_all

  before_validation :initialize_fields, :on => :create

  devise :database_authenticatable, :registerable,
         :recoverable, :timeoutable, :trackable, :validatable, :rememberable, :async

  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_name, :first_name, :middle_name

  VALIDATORS = {
    :should_contains_only_cyrillic_chars => /\A[а-яё -]+\z/i,
    :should_starts_with_capital_letter => /\A[А-ЯЁ]/,
    :should_looks_like_name => /\A([А-ЯЁ][а-яё]*)([ -][А-ЯЁ]?[а-яё]+)*\z/
  }


  validates_presence_of :first_name

  validates_presence_of :last_name, :unless => :admin?

  VALIDATORS.each do |message, format|
    validates_format_of :last_name, :first_name, :with => format,
                                                               :message => message,
                                                               :allow_nil => true,
                                                               :unless => :admin?
  end

  validates_length_of :last_name, :first_name, :middle_name, :email, :maximum => 255

  validates :email, :email_format => true

  alias_attribute :uid, :id

  normalize_attribute :email
  normalize_attribute :first_name, :last_name, :middle_name, :with => [:squish, :blank]

  def name
    [first_name, middle_name, last_name].keep_if(&:present?).join(' ')
  end

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def initialize_fields
    self.status = "Active"
    self.expiration_date = 1.year.from_now
  end

  def regular?
    !admin?
  end

  def self.find_by_access_token(access_token)
    where(["access_grants.access_token = ? AND (access_grants.access_token_expires_at IS NULL OR access_grants.access_token_expires_at > ?)", access_token, Time.now])
      .joins(:access_grants)
      .select("users.*")
      .first
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

