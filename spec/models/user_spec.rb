# encoding: utf-8
require 'spec_helper'

describe User do
  shared_examples_for :field_with_only_cyrillic_letters do |field, options|
    it { should allow_value("Иван").for(field) }
    it { should allow_value("Иван-Жак").for(field) }
    it { should allow_value("Иван-жак").for(field) }
    it { should allow_value("Иван Жак").for(field) }
    it { should allow_value("Иван жак").for(field) }
    it { should_not allow_value("Иван_жак").for(field).with_message("#{options[:error_message_start_with]} состоять только из русских букв") }
    it { should_not allow_value("иваН").for(field).with_message("#{options[:error_message_start_with]} начинаться с заглавной буквы") }
    it { should_not allow_value("ИваН").for(field).with_message("#{options[:error_message_start_with]} заканчиваться строчными буквами") }
    it { should_not allow_value("иван").for(field) }
    it { should_not allow_value("иван-Жак").for(field) }
  end

  shared_examples_for :field_with_squish_normalizator do |field|
    it { should normalize_attribute(field) }
    it { should normalize_attribute(field).from(' Оол   Оолович').to('Оол Оолович') }
  end

  describe '#first_name' do
    it { should validate_presence_of :first_name }
    it_should_behave_like :field_with_squish_normalizator, :first_name
    it_should_behave_like :field_with_only_cyrillic_letters, :first_name, :error_message_start_with => 'должно'
  end

  describe '#middle_name' do
    it { should_not validate_presence_of :middle_name }
    it { should allow_value(nil).for(:middle_name) }
    it_should_behave_like :field_with_squish_normalizator, :middle_name
    it_should_behave_like :field_with_only_cyrillic_letters, :middle_name, :error_message_start_with => 'должно'
  end

  describe '#last_name' do
    it { should validate_presence_of :last_name }
    it_should_behave_like :field_with_squish_normalizator, :last_name
    it_should_behave_like :field_with_only_cyrillic_letters, :last_name, :error_message_start_with => 'должна'
  end

  describe '#email' do
    it { should validate_presence_of :email }
    it { should normalize_attribute :email }
    it { should_not allow_value('completely wrong email').for(:email).with_message('не похож на адрес электронной почты') }
  end
end
