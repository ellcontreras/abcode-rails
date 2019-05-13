module CoursesHelper
    def percentage(course_id)
        courses_user = CourseUser.joins(:course, :course_progress).where(user_id: current_user.id).first

        topics = Topic.joins(:lessons, :course).where(course_id: course_id)

        already_actual_lesson = true
        already_actual_topic = true
        number_actual_lesson = 0
        number_actual_topic = 0
        percent = 0

        topics.each do |topic|
            if already_actual_lesson
                number_actual_lesson += 1
                topic.lessons.each do |lesson|
                    if lesson.id == courses_user.course_progress.first.lesson_id
                        @already_actual_lesson = false
                    end
                end
            end

            if already_actual_topic
                number_actual_topic += 1 
                if topic.id == courses_user.course_progress.first.topic_id
                    @already_actual_topic = false
                end
            end
        end

        topics.each do |topic|
            if topic.course_id == course_id
                percent = ((number_actual_lesson + number_actual_topic) / (topic.lessons.length + topics.length)) * 100
            end
        end

        return percent
    end
end
