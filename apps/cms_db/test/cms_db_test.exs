defmodule CmsDbTest do
  use ExUnit.Case
  doctest CmsDb

  test "greets the world" do
    assert CmsDb.hello() == :world
  end
end
