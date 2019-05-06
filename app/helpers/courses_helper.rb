module CoursesHelper
    def percentage(course_id)
        courses_user = CourseUser.joins(:course, :course_progress).where(user_id: current_user.id).first

        topics = Topic.joins(:lessons, :course).where(course_id: course_id)

        already_actual_lesson = false
        already_actual_topic = false
        number_actual_lesson = 0
        number_actual_topic = 0
        percent = 0

        topics.each do |topic|
            if !already_actual_lesson
                topic.lessons.each do |lesson|
                number_actual_lesson += 1
                    if lesson.id == courses_user.course_progress[0].lesson_id
                        @already_actual_lesson = true
                    end
                end
            end
        end

        topics.each do |topic|
            if !already_actual_topic
                number_actual_topic += 1 
                if topic.id == courses_user.course_progress[0].topic_id
                    @already_actual_topic = true
                end
            end
        end

        topics.each do |topic|
            if topic.course_id == course_id
                if (topic.lessons.length == 1 and topics.length == 1)
                    percent = ((number_actual_lesson - 1) + (number_actual_topic - 1)) * 100 / (topic.lessons.length + topics.length)
                else
                    percent = ((number_actual_lesson + number_actual_topic)) * 100 / (topic.lessons.length + topics.length)
                end
            end
        end

        return percent
    end
end
