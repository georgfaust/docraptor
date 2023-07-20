defmodule Docraptor do
  @api_key Application.compile_env(:docraptor, :api_key, "YOUR_API_KEY_HERE")
  @api_endpoint "https://#{@api_key}@api.docraptor.com/docs"
  @headers [
    {"Content-Type", "application/json"}
  ]
  @pipeline Application.compile_env(:docraptor, :pipeline, "10.1")
  @xls_type Application.compile_env(:docraptor, :xls_type, "xlsx")

  def render_pdf_sync(html, name \\ "", test \\ true) do
    get_payload(html, "pdf", test, name) |> render
  end

  def render_xls_sync(html, name \\ "", test \\ true) do
    get_payload(html, @xls_type, test, name) |> render
  end

  def render(payload) do
    case HTTPoison.post(@api_endpoint, payload, @headers, recv_timeout: 60_000) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, error_response} -> {:error, error_response}
    end
  end

  defp get_payload(content, type, test, name, pipeline \\ @pipeline, js \\ true) do
    Jason.encode!(%{
      test: test,
      document_content: content,
      type: type,
      name: name,
      pipeline: pipeline,
      prince_options: %{
        javascript: js
      }
    })
  end
end
