defmodule MedussaStudio.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users)do
      add(:name, :string)
      add(:email, :string)
      add(:dateOfBirth, :date)
      add(:password, :string)
      add(:age, :integer)
      add(:phone, :integer)

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
