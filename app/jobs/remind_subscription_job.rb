class RemindSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(subscriber)
    SubscriptionMailer.with( subscriber: subscriber )
      .send_recurring_payment_link.deliver_now
  end
end
