module ApplicationHelper
    def is_admin(current_user)
        current_user.role == "admin"
    end
end
