FactoryBot.define do
  factory :user do
    name     'John'
    email    'test@email.com'
    password '123456'
  end

  # This will use the User class (Admin would have been guessed)
  factory :dashboard do
    title   'main dashboard'
    owner { create(:user) }
    public  true
  end

  factory :list do
    title       'TODO'
    dashboard { create(:dashboard) }
  end

  factory :card do
    title      'Homework'
    text       'Lets do it'
    list
  end

  factory :label do
    name      'fatal task'
    color     0
  end

  factory :comment do
    text    'It`s amazing'
    card
    owner { create(:user, email: 'something_else@email.com') }
  end
end
