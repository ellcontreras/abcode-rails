class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    @lesson.topic_id = params[:topic_id]

    if @lesson.save
      if params[:lesson][:is_quiz] === "true"
        @quiz = Quiz.new

        @quiz.name = params[:lesson][:quiz][:name]
        @quiz.content = params[:lesson][:quiz][:content]
        @quiz.answer1 = params[:lesson][:quiz][:answer1]
        @quiz.answer2 = params[:lesson][:quiz][:answer2]
        @quiz.answer3 = params[:lesson][:quiz][:answer3]
        @quiz.which_correct = params[:lesson][:quiz][:which_correct]

        @quiz.lesson_id = @lesson.id

        @quiz.save
      end
    end

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_topic_lessons_path(Topic.find(@lesson.topic_id).course_id, @lesson.topic_id), notice: 'La lección se creó correctamente' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_topic_lesson_path(@lesson), notice: 'La lección se actualizó correctamente.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_topic_lessons_path, notice: 'La lección de destruyó correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:name, :content, :is_quiz, :quiz, quiz_params: [:name, :content, :answer1, :answer2, :answer3, :which_correct])
    end
end
