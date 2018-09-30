defmodule DetectiveWeb.Plugs.Filters do
  import Plug.Conn

  def allowed_filters(conn, filters) do
    filters = Enum.filter(conn.params["filters"] || [], fn {key, _} ->
      Enum.member?(filters, key)
    end)
    assign(conn, :filters, filters)
  end
end
