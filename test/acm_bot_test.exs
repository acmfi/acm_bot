defmodule AcmBotTest do
  use ExUnit.Case
  doctest AcmBot

  test "greets the world" do
    assert AcmBot.hello() == :world
  end
end
