class SubscriptionMailer < ApplicationMailer
  admin = Admin.last.setting
  default from: admin.origin_email

  # Overwrite SMTP settings with Admin settings
  ActionMailer::Base.smtp_settings = {
    :user_name => admin.mail_user_name,
    :password  => admin.mail_password,
    :domain    => admin.mail_domain,
    :address   => admin.mail_address,
    :port      => admin.mail_port,
    :authentication => admin.mail_authentication,
    :enable_starttls_auto => admin.mail_enable_starttls_auto
  }

  # When signing up for the first time
  def send_invoice
    subscriber = params[:subscriber]
    invoice = params[:invoice]
    admin_name = (Admin.last.setting.name.nil? || Admin.last.setting.name.empty?) ? "Satoshi Nakamoto" : Admin.last.setting.name
    url = unauthenticated_root_url
    @email_template = Admin.last.setting.invoice_email
      .gsub(/@@subscriber_name@@/, subscriber.name)
      .gsub(/@@invoice_amount@@/, invoice.amount.format)
      .gsub(/@@invoice_url@@/, invoice.invoice_url)
      .gsub(/@@my_name@@/, admin_name)
      .gsub(/@@my_url@@/, url)
    mail(to: subscriber.email, subject: "Thank you for your support!")
    subscriber.last_email_reminder = Time.now
    subscriber.save
  end

  # When payment is confirmed
  def thankyou_email
    subscriber = params[:subscriber]
    invoice = params[:invoice]
    admin_name = (Admin.last.setting.name.nil? || Admin.last.setting.name.empty?) ? "Satoshi Nakamoto" : Admin.last.setting.name
    url = unauthenticated_root_url
    @email_template = Admin.last.setting.thankyou_email
      .gsub(/@@subscriber_name@@/, subscriber.name)
      .gsub(/@@invoice_amount@@/, invoice.amount.format)
      .gsub(/@@my_name@@/, admin_name)
      .gsub(/@@my_url@@/, url)
    mail(to: subscriber.email, subject: "Thank you for your support!")
    subscriber.last_email_reminder = Time.now
    subscriber.save
  end

  def send_recurring_payment_link
    subscriber = params[:subscriber]
    admin_name = (Admin.last.setting.name.nil? || Admin.last.setting.name.empty?) ? "Satoshi Nakamoto" : Admin.last.setting.name
    url = unauthenticated_root_url
    @email_template = Admin.last.setting.reminder_email
      .gsub(/@@subscriber_name@@/, subscriber.name)
      .gsub(/@@payment_url@@/, url+'subscription_link/'+subscriber.uuid)
      .gsub(/@@my_name@@/, admin_name)
      .gsub(/@@my_url@@/, url)
    mail(to: subscriber.email, subject: "Reminder for recurring payment")
    subscriber.last_email_reminder = Time.now
    subscriber.save
  end

  # Send access to Supporter page
  def send_user_credentials
    subscriber = params[:subscriber]
    password   = params[:password]
    admin_name = (Admin.last.setting.name.nil? || Admin.last.setting.name.empty?) ? "Satoshi Nakamoto" : Admin.last.setting.name
    url = unauthenticated_root_url
    @email_template = Admin.last.setting.user_credentials_email
      .gsub(/@@subscriber_name@@/, subscriber.name)
      .gsub(/@@subscriber_email@@/, subscriber.email)
      .gsub(/@@subscriber_password@@/, password)
      .gsub(/@@my_name@@/, admin_name)
      .gsub(/@@my_url@@/, url)
    mail(to: subscriber.email, subject: "Supporter page info for " + unauthenticated_root_url)
  end

  # TODO Subsequent month reminder
  def reminder_email
    @subscriber = params[:subscriber]
  end

  # TODO Second try before saying good bye
  def goodbye_email
    @subscriber = params[:subscriber]
  end
end
