alias Bloggy.Coherence.User
alias Bloggy.Content.Article
alias Bloggy.ArticleUserLike

Bloggy.Repo.delete_all User
Bloggy.Repo.delete_all Article
Bloggy.Repo.delete_all ArticleUserLike

user1 = User.changeset(%User{}, %{name: "User 1", email: "testuser@example.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!

user2 = User.changeset(%User{}, %{name: "User 2", email: "h@h.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!

user3 = User.changeset(%User{}, %{name: "User 3", email: "h1@h.com", password: "1234", password_confirmation: "1234"})
|> Bloggy.Repo.insert!

a1 = Article.changeset(%Article{}, %{title: "Hello 1", content: "Content 1", author_id: user1.id})
|> Bloggy.Repo.insert!

a2 = Article.changeset(%Article{}, %{title: "Hello 2", content: "Content 2", author_id: user1.id})
|> Bloggy.Repo.insert!

a3 = Article.changeset(%Article{}, %{title: "Hello 3", content: "Content 3", author_id: user2.id})
|> Bloggy.Repo.insert!

ArticleUserLike.changeset(%ArticleUserLike{}, %{user_id: user1.id, article_id: a1.id})
|> Bloggy.Repo.insert!

ArticleUserLike.changeset(%ArticleUserLike{}, %{user_id: user2.id, article_id: a1.id})
|> Bloggy.Repo.insert!

ArticleUserLike.changeset(%ArticleUserLike{}, %{user_id: user1.id, article_id: a2.id})
|> Bloggy.Repo.insert!

ArticleUserLike.changeset(%ArticleUserLike{}, %{user_id: user1.id, article_id: a3.id})
|> Bloggy.Repo.insert!
