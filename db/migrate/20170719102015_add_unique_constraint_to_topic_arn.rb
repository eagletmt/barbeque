class AddUniqueConstraintToTopicArn < ActiveRecord::Migration[5.0]
  def change
    add_index :barbeque_sns_subscriptions, :topic_arn, unique: true
  end
end
