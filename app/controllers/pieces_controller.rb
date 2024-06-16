class PiecesController < ApplicationController
  before_action :set_piece_collection, only: %i[ index new create ]
  before_action :set_piece, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[ index show ]
  skip_before_action :authorize_user!, only: %i[ index show edit update]

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
    authorize_user!
  end

  # POST /pieces or /pieces.json
  def create
    @piece = @piece_collection.pieces.build(piece_params)

    respond_to do |format|
      if @piece.save
        format.html { redirect_to piece_collection_pieces_path(@piece_collection), notice: t(".success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/1 or /pieces/1.json
  def update
    authorize_user!

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

  def update_status
    @piece = Piece.find(params[:id])
    status = params[:status].to_i

    begin
      message = @piece.update_status!(status) ?
                  t(".success") : t(".error")
      redirect_to @piece, notice: message

      # TODO handle exceptions with custom class
    rescue StandardError => e
      redirect_to @piece, alert: e.message
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
      params.require(:piece).permit(:name, :number, :description, :material, :measurement, :conservation_state, :status, :piece_collection_id)
    end

  def authorize_user!
    authorized = case action_name
                 when "destroy" then current_user.admin?
                 when "new", "create", "update", "edit", "update_status" then current_user.admin_or_museum_owner?(@piece.piece_collection.museum)
                 else
                   false
                 end

    not_authorized unless authorized
  end
end
