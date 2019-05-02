class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def add_course_to_user
    @course_user = CourseUser.new

    @course_user.user = current_user
    @course_user.course = Course.find(params[:id])

    respond_to do |format|
      if @course_user.save
        @course_progress = CourseProgress.new

        @course_progress.course_user_id = @course_user.id
        @course_progress.topic_id = Topic.where(course_id: params[:id]).last.id
        @course_progress.lesson_id = Lesson.where(topic_id: @course_progress.topic_id.to_i).last.id
        @course_progress.course_ended = false

        @course_progress.save

        puts "Errores", @course_progress.topic_id
        @course_progress.errors.full_messages.each do |msg|
          puts msg
        end 

        format.html { redirect_to course_path(params[:id]), notice: 'Se ha agregado el curso a la lista de cursos' }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  def courses_index
    @courses = Course.all
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
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
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
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
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
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
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
