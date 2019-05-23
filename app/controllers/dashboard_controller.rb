class DashboardController < ApplicationController

    def index
        @users = User.search(params[:user_search])
    end

end
