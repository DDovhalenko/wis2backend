class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def configure_permitted_parameters
    attributes = [:name, :surname]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:update, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    render json: resource
  end
  
end