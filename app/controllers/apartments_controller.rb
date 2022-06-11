class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :ok
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy!
        head :no_content
    end

    private
    def apartment_params
        params.permit(:number)
    end

    def not_found_response
        render json: {error: "Aparment not found"}, status: :not_found
    end

    def invalid_response
        render json: {error: "Invalid entry"}, status: 422
    end
end
