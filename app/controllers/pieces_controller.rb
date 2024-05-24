class PiecesController < ApplicationController
  before_action :set_piece_collection, only: %i[ index new create ]
  before_action :set_piece, only: %i[ show edit update destroy ]

  # GET /pieces or /pieces.json
  def index
    # need a separate method to show every piece at once if I want to implement that
    @pieces = @piece_collection.pieces
  end

  # GET /pieces/1 or /pieces/1.json
  def show
  end

  # GET /pieces/new
  def new
    @piece = @piece_collection.pieces.build
  end

  # GET /pieces/1/edit
  def edit
  end

  # POST /pieces or /pieces.json
  def create
    @piece = @piece_collection.pieces.build(piece_params)

    respond_to do |format|
      if @piece.save
        format.html { redirect_to piece_collection_pieces_path(@piece_collection), notice: "Piece was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/1 or /pieces/1.json
  def update
    respond_to do |format|
      if @piece.update(piece_params)
        format.html { redirect_to piece_url(@piece), notice: "Piece was successfully updated." }
        format.json { render :show, status: :ok, location: @piece }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO improve the redirect ! will only allow deleting from the piece page and redirect to the museum page?
  # DELETE /pieces/1 or /pieces/1.json
  def destroy
    @piece.destroy!

    respond_to do |format|
      format.html { redirect_to pieces_url, notice: "Piece was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_piece_collection
    @piece_collection = PieceCollection.find(params[:piece_collection_id])
  end

    def set_piece
      @piece = Piece.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def piece_params
      params.require(:piece).permit(:number, :description, :material, :measurement, :conservation_state, :status, :piece_collection_id)
    end
end
