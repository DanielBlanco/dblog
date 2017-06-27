defmodule Dblog.UserTest do
  use Dblog.ModelCase

  alias Dblog.User

  @valid_attrs %{email: "test@test", name: "Daniel Blanco", password: "sekret"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password must be at least 6 chars long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.changeset(%User{}, attrs)
    expected_error = {:password, "should be at least 6 character(s)"}
    assert expected_error in errors_on(changeset)
  end

end
