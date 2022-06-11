class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :ok
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy!
        head :no_content
    end

    private
    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end

    def invalid_response
        render json: {error: "Invalid entry"}, status: 422
    end
end
