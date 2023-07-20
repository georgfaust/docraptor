paths = Path.wildcard("../documents/priv/out/*.html")

for p <- paths do
  IO.puts(p)
  {:ok, body} = p |> File.read!() |> Docraptor.render_pdf_sync()
  :timer.sleep(1000)
  File.write!("../documents/priv/out/#{Path.basename(p, ".html")}.pdf", body)
end
