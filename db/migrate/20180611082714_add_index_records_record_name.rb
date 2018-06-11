class AddIndexRecordsRecordName < ActiveRecord::Migration[5.1]
  def change
  	add_index :records, :record_name
  end
end
