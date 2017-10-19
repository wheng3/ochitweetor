FactoryGirl.define do
  factory :user do
        name { "Foo Bar" }
    	email { "foorbar@gmail.com" }
    	password { "foorbar1234" }
  end
end