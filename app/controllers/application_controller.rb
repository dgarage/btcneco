class ApplicationController < ActionController::Base
  before_action :set_action_mailer_default_url_options

  def after_sign_in_path_for(resource)
    if resource.model_name.name == "Admin"
      "/admin"
    end
    if resource.model_name.name == "User"
      "/user/index"
    end
  end

  private

  def set_action_mailer_default_url_options
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
