module CoursesHelper
    def percentage(course_id)
        percentage = 0

        @course_progress = CourseProgress.where(course_user_id: current_user.id).first

        @course = Course.find(course_id)
        @topics = Topic.includes(:lessons).where(course_id: course_id)

        actual_lesson = 1
        actual_topic = 1
        total_lessons = 0
        total_topics = @topics.length

        already_lesson = false

        @topics.each do |topic|
            total_lessons = total_lessons + topic.lessons.length

            unless topic.id == @course_progress.topic_id
                actual_topic = actual_topic + 1
            end

            topic.lessons.each do |lesson|
                unless already_lesson
                    unless lesson.id == @course_progress.lesson_id
                        actual_lesson = actual_lesson + 1
                    else 
                        already_lesson = true
                    end
                end
            end
        end

        puts actual_lesson
        puts actual_topic
        puts total_lessons
        puts total_topics

        percentage = (actual_lesson + actual_topic) * 100 / (total_lessons + total_topics)

        return percentage
    end
end
