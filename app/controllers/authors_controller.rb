class AuthorsController < ApplicationController
  prepend_before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  def index
    @q = Author.ransack(params[:q])
    @q.sorts = 'first_name asc' if @q.sorts.empty?
    @pagy, @authors = pagy(@q.result)
  end

  # GET /authors/1 or /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        @pagy, @authors = pagy(Author.all)
        format.html { redirect_to authors_path, notice: t(".success") }
        format.turbo_stream { flash.now[:notice] = t(".success") }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: t(".success") }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    respond_to do |format|
      begin
        @author.destroy!
        format.html { redirect_to authors_url, notice: t(".success") }
      rescue StandardError
        format.html { redirect_to author_url(@author), notice: t(".error") }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def authorize_user!
    not_authorized unless current_user.admin?
  end
end
