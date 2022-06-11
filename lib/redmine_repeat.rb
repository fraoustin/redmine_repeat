def repeat_issue(context)
  repeat = 0
  context[:issue].custom_values.each do |custom_value|
    if custom_value.custom_field.name == "repeat" then
      repeat = custom_value.value.to_i
    end
  end
  if (repeat > 0) then
    copy = context[:issue].copy()
    if copy.due_date? then
      copy.due_date = copy.due_date + repeat
    end
    copy.save()
  end
end

module RedmineRepeat
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_new_after_save(context)
      if context[:issue] and context[:issue].status.is_closed? then
        repeat_issue(context)
      end
    end

    def controller_issues_edit_before_save(context) #before for check change status
      if context[:issue] then
        @issue = Issue.find context[:issue].id
        unless @issue.status.id == context[:issue].status.id then # CHANGED STATUS
          if context[:issue].status.is_closed? then
#            repeat = 0
#            context[:issue].custom_values.each do |custom_value|
#              if custom_value.custom_field.name == "repeat" then
#                repeat = custom_value.value.to_i
#              end
#            end
#            if (repeat > 0) then
#              copy = context[:issue].copy()
#              if copy.due_date? then
#                copy.due_date = copy.due_date + repeat
#              end
#              copy.save()
#            end
            repeat_issue(context)
          end
        end
      end
    end
    alias_method :controller_issues_bulk_edit_before_save, :controller_issues_edit_before_save
  end
end