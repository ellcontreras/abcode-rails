class CourseUserController < ApplicationController
    def add_course_to_user
        @course_user = CourseUser.new

        @course_user.user = current_user
        @course_user.course = Course.find(params[:id])

        respond_to do |format|
            if @course_user.save
                @course_progress = CourseProgress.new

                @course_progress.course_user_id = @course_user.id
                @course_progress.topic_id = Topic.where(course_id: params[:id]).first.id
                @course_progress.lesson_id = Lesson.where(topic_id: @course_progress.topic_id.to_i).first.id
                @course_progress.course_ended = false

                @course_progress.save

                puts "Errores", @course_progress.topic_id
                @course_progress.errors.full_messages.each do |msg|
                    puts msg
                end 

                format.html { redirect_to play_course_path(params[:id]), notice: 'Se ha agregado el curso a la lista de cursos' }
            else
                format.html { render :new }
                format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
    end
end
