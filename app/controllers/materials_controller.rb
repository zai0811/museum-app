class MaterialsController < ApplicationController
  prepend_before_action :set_material, only: %i[ show edit update destroy ]

  # GET /materials or /materials.json
  def index
    @q = Material.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @pagy, @materials = pagy(@q.result)
  end

  # GET /materials/1 or /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials or /materials.json
  def create
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        @pagy, @materials = pagy(Material.all)
        format.html { redirect_to materials_path, notice: t(".success") }
        format.turbo_stream { flash.now[:notice] = t(".success") }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1 or /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to material_url(@material), notice: t(".success")}
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1 or /materials/1.json
  def destroy
    respond_to do |format|
      begin
        @material.destroy!
        format.html { redirect_to materials_url, notice: t(".success") }
      rescue StandardError
        format.html { redirect_to material_url(@material), notice: t(".error") }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material = Material.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def material_params
    params.require(:material).permit(:name)
  end

  def authorize_user!
    not_authorized unless current_user.admin?
  end
end
