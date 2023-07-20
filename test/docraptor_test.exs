defmodule DocraptorTest do
  use ExUnit.Case

  test "pdf" do
    html = File.read!("test.html")
    assert {:ok, pdf} = Docraptor.render_pdf_sync(html)

    File.write!("test.pdf", pdf)
  end

  # test "xls" do
  #   content = """
  #   <table name="Example Worksheet">
  #   <tr style="font-size: 16px">
  #     <td colspan="2">Big Row</td>
  #   </tr>
  #   <tr>
  #     <td style="color: blue">Blue Cell</td>
  #     <td style="-xls-format:currency_dollar">1000</td>
  #   </tr>
  #   </table>
  #   """

  #   assert {:ok, _xls} = Docraptor.render_xls_sync(content)
  # end
end
