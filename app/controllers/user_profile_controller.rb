class UserProfileController < ApplicationController
    before_action :set_params

    def index
        @courses_user = CourseUser.joins(:course).where(user_id: params[:id])
    end

    private
        def set_params
            @user = User.find(params[:id])
        end
end
