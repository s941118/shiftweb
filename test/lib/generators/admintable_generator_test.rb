require 'test_helper'
require 'generators/admintable/admintable_generator'

class AdmintableGeneratorTest < Rails::Generators::TestCase
  tests AdmintableGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
