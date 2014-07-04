class AddNeedsQuotationToParameterTypes < ActiveRecord::Migration
  def change
    add_column :parameter_types, :needs_quotation, :boolean
  end
end
