class CourseInProgressController < ApplicationController
    def index
        @course = Course.find(params[:course_id])
        # @topics = Topic.where(course_id: params[:course_id])

        # @lessons = Lesson.where(topic_id: )
        @topics = Topic.includes(:lessons, :course).references(:lessons).where(course_id: params[:course_id])

        @actual_topic = @topics.sample
    end
end
