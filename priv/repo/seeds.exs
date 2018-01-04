Bloggy.Repo.delete_all Bloggy.Coherence.User

Bloggy.Coherence.User.changeset(%Bloggy.Coherence.User{}, %{name: "Test User", email: "testuser@example.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!