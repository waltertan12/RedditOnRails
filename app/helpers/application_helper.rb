module ApplicationHelper
  def auth_token
    token = <<-HTML
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
    token.html_safe
  end

  def is_moderator?(user, sub)
    user.id == sub.moderator_id
  end

  def option_value(name, current_id, target_id)
    selected = (current_id == target_id ? "selected" : "")
    option = <<-HTML
    <option value="#{current_id}" #{selected}>
      #{h(name)}
    </option>
    HTML

    option.html_safe
  end
end
