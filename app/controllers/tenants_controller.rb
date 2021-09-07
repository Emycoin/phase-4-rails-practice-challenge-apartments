class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_message
  def index
    tenants = Tenant.all
    render json: tenants
  end
  def show
    tenant = Tenant.find(params[:id])
    render json: tenant
  end
  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end
  def destroy
    tenant = Tenant.find(params[:id])
    tenant.destroy
    head :no_content
  end
  def update
   tenant= Tenant.find(params[:id])
   if(!tenant)
      render :nothing, status: 404
   end
   body = JSON.parse(request.body.read)
   body.each { |key, value| tenant[key] = value }
   tenant.save
   render json: tenant, status:201
 
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end
  def record_not_found_message(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end
  def record_invalid_message(invalid)
    render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
