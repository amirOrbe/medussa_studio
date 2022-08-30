defmodule MedussaStudio.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :age, :integer, null: false
      add :date_of_birth, :date, null: false
      add :email, :string, null: false
      add :name, :string, null: false
      add :password, :string, null: false
      add :login_token, :string, null: false
      add :phone, :integer

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
