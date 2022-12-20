class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ show index ]

  def index
    @movies = Movie.search(params[:search]).page(params[:page])
  end

  def show
    if @movie.reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @movie.reviews.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        # format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        # format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      # format.json { head :no_content }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # def set_avg_rating
    #   if @movie.reviews.blank?
    #     @avg_rating = 0
    #   else
    #     @avg_rating = @movie.reviews.average(:rating).round(2)
    #   end
    # end

    def movie_params
      params.require(:movie).permit(:title, :text, :category, :image, :search)
    end
end
