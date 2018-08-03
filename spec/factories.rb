require 'faker'

FactoryBot.define do
  sequence :email do
    Faker::Internet.unique.email
  end

  sequence :name do
    Faker::Name.unique.name
  end

  sequence :password do
    Faker::Internet.password
  end

  factory :user, aliases: [:owner, :author] do
    name
    email
    password
  end

  factory :dashboard do
    title  'main dashboard'
    public true
    owner
  end

  factory :list do
    title     'TODO'
    dashboard
  end

  factory :card do
    title 'Homework'
    text  'Lets do it'
    list
  end

  factory :label do
    name  'fatal task'
    color 0
    dashboard
  end

  factory :comment do
    card
    owner
    text  'It`s amazing'
  end
end
