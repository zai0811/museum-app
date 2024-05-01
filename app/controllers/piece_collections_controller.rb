class PieceCollectionsController < ApplicationController
  before_action :set_piece_collection, only: %i[ show edit update destroy ]

  # GET /piece_collections or /piece_collections.json
  def index
    @piece_collections = PieceCollection.all
  end

  # GET /piece_collections/1 or /piece_collections/1.json
  def show
  end

  # GET /piece_collections/new
  def new
    @piece_collection = PieceCollection.new
  end

  # GET /piece_collections/1/edit
  def edit
  end

  # POST /piece_collections or /piece_collections.json
  def create
    @piece_collection = PieceCollection.new(piece_collection_params)

    respond_to do |format|
      if @piece_collection.save
        format.html { redirect_to piece_collection_url(@piece_collection), notice: "Piece collection was successfully created." }
        format.json { render :show, status: :created, location: @piece_collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @piece_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /piece_collections/1 or /piece_collections/1.json
  def update
    respond_to do |format|
      if @piece_collection.update(piece_collection_params)
        format.html { redirect_to piece_collection_url(@piece_collection), notice: "Piece collection was successfully updated." }
        format.json { render :show, status: :ok, location: @piece_collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @piece_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /piece_collections/1 or /piece_collections/1.json
  def destroy
    @piece_collection.destroy!

    respond_to do |format|
      format.html { redirect_to piece_collections_url, notice: "Piece collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_piece_collection
      @piece_collection = PieceCollection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def piece_collection_params
      params.require(:piece_collection).permit(:name, :status, :museum_id)
    end
end
