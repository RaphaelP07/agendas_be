class RemoveSenderReceiverIdFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :sender_id, :integer
    remove_column :messages, :receiver_id, :integer
  end
end
