defmodule Slick.PostView do
  use Slick.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Slick.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{post: render_one(post, Slick.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      body: post.body,
      author: post.author}
  end
end
