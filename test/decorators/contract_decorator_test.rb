require 'test_helper'

class ContractDecoratorTest < ActiveSupport::TestCase
  def setup
    ApplicationController.new.set_current_view_context
  end

  # test "the truth" do
  #   assert true
  # end
end

