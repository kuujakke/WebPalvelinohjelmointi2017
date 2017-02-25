module ApplicationHelper

  def edit_and_destroy_buttons(item)
    if current_user
      edit = link_to('Edit', url_for([:edit, item]), class: 'btn btn-warning')
      if current_user.is_admin?
        del = link_to('Destroy', item, method: :delete, data: {confirm: "Are you sure?"}, class: "btn btn-danger")
      end
      raw("#{edit} #{del}")
    end
  end

end
