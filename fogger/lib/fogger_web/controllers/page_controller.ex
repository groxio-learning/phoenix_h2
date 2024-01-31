defmodule FoggerWeb.PageController do
  use FoggerWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    # :assigns field in conn has custom data from the pipeline processing prior
    # to entering this function
    render(conn, :home, layout: false)
  end
end
