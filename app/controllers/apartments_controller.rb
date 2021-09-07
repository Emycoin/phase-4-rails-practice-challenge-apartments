class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_message

  def index
    apartments = Apartment.all
    render json: apartments
  end
  def show
    apartment = Apartment.find(params[:id])
    render json: apartment
  end
  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def destroy
    apartment = Apartment.find(params[:id])
    apartment.destroy
    head :no_content
  end
   def update
   apartment = Apartment.find(params[:id])
   if(!apartment)
      render :nothing, status: 404
   end
   body = JSON.parse(request.body.read)
   body.each { |key, value| apartment[key] = value }
   apartment.save
   render json: apartment, status:201
 end

  private

  def apartment_params
    params.permit(:number)
  end
  def record_invalid_message(invalid)
    render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
  def record_not_found_message(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end
end
