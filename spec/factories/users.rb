FactoryGirl.define do
  factory :user do
        name { "Foo Bar" }
    	email { "foobar@gmail.com" }
    	password { "foobar1234" }
  end
end