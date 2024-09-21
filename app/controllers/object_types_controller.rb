class ObjectTypesController < ApplicationController
  before_action :set_object_type, only: %i[ show edit update destroy ]

  # GET /object_types or /object_types.json
  def index
    @q = ObjectType.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @pagy, @object_types = pagy(@q.result)
  end

  # GET /object_types/1 or /object_types/1.json
  def show
  end

  # GET /object_types/new
  def new
    @object_type = ObjectType.new
  end

  # GET /object_types/1/edit
  def edit
  end

  # POST /object_types or /object_types.json
  def create
    @object_type = ObjectType.new(object_type_params)

    respond_to do |format|
      if @object_type.save
        @pagy, @object_types = pagy(ObjectType.all)
        format.html { redirect_to object_type_url(@object_type), notice: t(".success") }
        format.turbo_stream { flash.now[:notice] = t(".success") }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /object_types/1 or /object_types/1.json
  def update
    respond_to do |format|
      if @object_type.update(object_type_params)
        format.html { redirect_to object_type_url(@object_type), notice: t(".success") }
        format.json { render :show, status: :ok, location: @object_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_types/1 or /object_types/1.json
  def destroy
    respond_to do |format|
      begin
        @object_type.destroy!
        format.html { redirect_to object_types_url, notice: t(".success") }
      rescue StandardError
        format.html { redirect_to object_type_url(@object_type), notice: t(".error") }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_object_type
    @object_type = ObjectType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def object_type_params
    params.require(:object_type).permit(:name)
  end
end
