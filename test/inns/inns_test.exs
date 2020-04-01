defmodule TestApp.InnsTest do
  use TestApp.ModelCase


  describe "Check_inn_and_write_in_db/1" do
      @valid_attrs_pass_db %{
        "body" => "6449013711",
        "date" => "[1.3.2020 1:35]",
        "check_result" => "корректен"
      }
      @invalid_attrs_db %{}

      @valid_attrs_not_pass "31232"
      @valid_attrs_pass "6449013711"

    test "with valid data inn_validation" do
      assert "корректен" = TestApp.ExampleChannel.inn_validation(@valid_attrs_pass)
    end

    test "with wrong data inn_validation" do
      assert "некорректен" = TestApp.ExampleChannel.inn_validation(@valid_attrs_not_pass)
    end
    test "with valid data inserts inn in db" do
      assert {:ok, _map} = TestApp.InnBaseApi.write_inn(%{ "body" => "6449013711", "date" => "[1.3.2020 1:35]", "check_result" => "корректен" })
    end

    test "with wrong data inserts inn in db" do
      assert {:error, "data is wrong"} = TestApp.InnBaseApi.write_inn(@invalid_attrs_db)
    end
  end
end
