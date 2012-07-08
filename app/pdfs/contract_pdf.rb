# -*- encoding : utf-8 -*-
class ContractPdf < Prawn::Document
  def initialize(contract, view)
    super(top_margin: 30)
    @contract = contract
    @view = view
    contract_number
    contract_address
   # total_price
   #other
   # (1..10).each do |index|
   #     text "Page #{index}"
   #     start_new_page
   #   end
  end

  def contract_number
   font "Times-Roman"
   fill_color "336699"
    text "Contract \##{@contract.contract_number}", size: 10, style: :bold, align: :left

    fill_color "336699"
    text "#{@contract.act_booked}", size: 12, style: :bold, color:"#336699"
    fill_color "000000"
    text "#{@contract.type_of_event}", size:12, style: :bold
    font "Helvetica"  # back to normal
    # column_box([0, cursor], columns: 2, width: bounds.width) do
    #      text((<<-END.gsub(/\s+/, ' ') + "\n\n") * 1)
    #       #{@contract.contract_provisions}
    #      END
    #    end
  end

  def contract_address
      indent 300 do
        move_up 30
     text "#{@contract.location_name}", size: 10, style: :bold
     text "#{@contract.location_address_line_1}", size: 10, style: :normal
     text "#{@contract.location_city}, #{@contract.location_state} #{@contract.location_zip}", size: 10, style: :normal
     text "#{@contract.location_phone}", size: 10, style: :normal
   end
  end

  # def other
  #    text "Please scan the next 3 pages to see the page templates in action."
  #    move_down 10
  #    text "You also might want to look at the pdf used as a template: "
  #    url = "https://github.com/sandal/prawn/raw/master/data/pdfs/form.pdf"
  #    move_down 10
  #
  #    formatted_text [{text: url, link: url}]
  #
  #    #filename = "#{Prawn::DATADIR}/pdfs/form.pdf"
  #    #start_new_page(template: filename)
  #
  #    #start_new_page(template: filename, template_page: 2)
  #
  #    #start_new_page(template: filename, template_page: 2)
  #
  #    fill_color "FF8888"
  #
  #    text_box "John Doe", at: [75, cursor-75]
  #    text_box "john@doe.com", at: [75, cursor-105]
  #    text_box "John Doe inc", at: [75, cursor-135]
  #    text_box "You didn't think I'd tell, did you?", at: [75, cursor-165]
  #
  #    fill_color "000000"
  #  end
  # def line_items
  #     move_down 20
  #     table line_item_rows do
  #       row(0).font_style = :bold
  #       columns(1..3).align = :right
  #       self.row_colors = ["DDDDDD", "FFFFFF"]
  #       self.header = true
  #     end
  #   end
  #
  #   def line_item_rows
  #     [["Product", "Qty", "Unit Price", "Full Price"]] +
  #     contract.each do |item|
  #       [item.name, item.quantity, price(item.unit_price), price(item.full_price)]
  #     end
  #   end
end
