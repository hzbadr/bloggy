alias Bloggy.Coherence.User
alias Bloggy.Content.Article

Bloggy.Repo.delete_all User
Bloggy.Repo.delete_all Article

user1 = User.changeset(%User{}, %{name: "Test User", email: "testuser@example.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!

user2 = User.changeset(%User{}, %{name: "Test User", email: "h@h.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!

Article.changeset(%Article{}, %{title: "Hello 1", content: "Content 1", user_id: user1.id})
|> Bloggy.Repo.insert!

Article.changeset(%Article{}, %{title: "Hello 2", content: "Content 2", user_id: user1.id})
|> Bloggy.Repo.insert!

Article.changeset(%Article{}, %{title: "Hello 3", content: "Content 3", user_id: user2.id})
|> Bloggy.Repo.insert!