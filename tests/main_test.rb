require_relative 'helper'

class HelloWorldTest < Test::Unit::TestCase
  include Helper

  def test_graphql
    body = {
        query: "{coin(name: \"XVG\") { name }}"
    }
    result = post_json("/graphql", body.to_json)
    assert_equal result.status, 200
  end
end
