class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:mine]

  def mine
    @courses_user = CourseUser.joins(:course, :course_progress).where(user_id: current_user.id)
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.reverse
  end

  def courses_index
    @courses = Course.limit(3).reverse_order

    if user_signed_in?
      render "home_user_loged"
    else
      render "home"
    end

  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course_already_taken = CourseUser.where(user_id: current_user, course_id: @course).exists?
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'El curso se creó de forma correcta' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'El curso se actualizó de forma correcta' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'El curso se eliminó de forma correcta' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :category)
    end
end