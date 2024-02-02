defmodule FoggerWeb.Router do
  use FoggerWeb, :router

  import FoggerWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {FoggerWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  # liveview is like OTP server, except the cast/call is controlled by UI
  # CRC => Mount (data put in socket like :new), handle_event like cast, call, Render (like :show)
  scope "/", FoggerWeb do
    pipe_through(:browser)

    get("/", PageController, :home)

    live("/movie_quotes", MovieQuoteLive.Index, :index)
    live("/movie_quotes/new", MovieQuoteLive.Index, :new)
    live("/movie_quotes/:id/edit", MovieQuoteLive.Index, :edit)

    live("/movie_quotes/:id", MovieQuoteLive.Show, :show)
    live("/movie_quotes/:id/show/edit", MovieQuoteLive.Show, :edit)
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoggerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fogger, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: FoggerWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", FoggerWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    # all logged out users
    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FoggerWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", FoggerWeb do
    pipe_through([:browser, :require_authenticated_user])

    # 2 kinds of redirects (live, reg. http)
    live_session :require_authenticated_user,
      on_mount: [{FoggerWeb.UserAuth, :ensure_authenticated}] do
      # live("/count", CountLive, :yeti)
      live("/erase", EraseLive, :vino)
      # 3rd arg :atom extra parameter tell us where we came from
      # live("/users/settings", UserSettingsLive, :edit)
      # _Live is data
      live("/count", CountLive, :yeti)
      live("/fogger/:id", FogLive, :memory)
      live("/choose", PickerLive, :new)
      live("/choose/:id", PickerLive, :show)
      # :edit is added to socket
      live("/users/settings", UserSettingsLive, :edit)
      live("/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email)
      live("/leader_board", LeaderBoardLive, :board)

      # CRUD route
      get("scores/new/:id", ScoreController, :new)
      resources "/scores", ScoreController
    end
  end

  scope "/", FoggerWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{FoggerWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
