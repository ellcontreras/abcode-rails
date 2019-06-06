module ApplicationHelper
    def is_admin(current_user)
        if current_user
            current_user.role == "admin"
        end
    end

    def title(page_title)
        content_for(:title) { page_title }
    end
end
