defmodule MedussaStudio.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users)do
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:dateOfBirth, :date, null: false)
      add(:password, :string, null: false)
      add(:age, :integer, null: false)
      add(:phone, :integer, null: false)

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
