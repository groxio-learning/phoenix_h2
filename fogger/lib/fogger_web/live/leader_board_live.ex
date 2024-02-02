defmodule FoggerWeb.LeaderBoardLive do
  use FoggerWeb, :live_view

  alias Fogger.LeaderBoard
  alias Phoenix.PubSub

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Leader board</h1>
    <.scores scores={@scores} />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(Fogger.PubSub, LeaderBoard.topic())
    end
    {:ok, assign(socket, scores: LeaderBoard.list_scores())}
  end


  attr :scores, :any, required: true
  def scores(assigns) do
    ~H"""
    <ul>
      <%= for score <- @scores do %>
        <li><%= score.initials %>-<%= score.points %></li>
      <% end %>
    </ul>
    """
  end

  @impl true
  def handle_info("leader board changed", socket) do
    {:noreply, assign(socket, scores: LeaderBoard.list_scores())}
  end

end
