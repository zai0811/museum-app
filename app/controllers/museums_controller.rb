class MuseumsController < ApplicationController
  before_action :set_museum, only: %i[ show edit update destroy ]

  # GET /museums or /museums.json
  def index
    @museums = Museum.all
  end

  # GET /museums/1 or /museums/1.json
  def show
  end

  # GET /museums/new
  def new
    @museum = Museum.new
  end

  # GET /museums/1/edit
  def edit
  end

  # POST /museums or /museums.json
  def create
    @museum = Museum.new(museum_params)

    respond_to do |format|
      if @museum.save
        format.html { redirect_to museum_url(@museum), notice: "Museum was successfully created." }
        format.json { render :show, status: :created, location: @museum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /museums/1 or /museums/1.json
  def update
    respond_to do |format|
      if @museum.update(museum_params)
        format.html { redirect_to museum_url(@museum), notice: "Museum was successfully updated." }
        format.json { render :show, status: :ok, location: @museum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /museums/1 or /museums/1.json
  def destroy
    @museum.destroy!

    respond_to do |format|
      format.html { redirect_to museums_url, notice: "Museum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_museum
      @museum = Museum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def museum_params
      params.require(:museum).permit(:name, :about, :email, :phone, :page, :address, :user_id)
    end
end
