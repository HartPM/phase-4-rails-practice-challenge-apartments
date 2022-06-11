class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :ok
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy!
        head :no_content
    end

    private
    def tenant_params
        params.permit(:name, :age)
    end

    def not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def invalid_response
        render json: {error: "Invalid entry"}, status: 422
    end

end
