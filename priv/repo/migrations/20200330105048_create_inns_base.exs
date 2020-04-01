defmodule TestApp.Repo.Migrations.CreateInnsBase do
  use Ecto.Migration

  def change do
    create table(:inns) do
      add :date, :string
      add :check, :string
      add :inn, :string

      timestamps()
    end

  end
end
