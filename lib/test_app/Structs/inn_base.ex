defmodule TestApp.Structs.InnBase do
    use Ecto.Schema

    schema "inns" do
      field :date, :string
      field :check, :string
      field :inn, :string

      timestamps()
    end
end
