class CasaCaseDecorator < Draper::Decorator
  delegate_all

  def status
    object.active ? "Active" : "Inactive"
  end

  def transition_aged_youth_icon
    object.transition_aged_youth ? "Yes 🐛🦋" : "No"
  end

  def transition_aged_youth_only_icon
    object.transition_aged_youth ? "🐛🦋" : ""
  end

  def court_report_submission
    object.court_report_status.humanize
  end

  def court_report_submitted_date
    object.court_report_submitted_at&.strftime("%B%e, %Y")
  end

  def case_contacts_ordered_by_occurred_at
    object.case_contacts.sort_by(&:occurred_at)
  end

  def case_contacts_latest
    object.case_contacts.max_by(&:occurred_at)
  end

  def successful_contacts_this_week
    this_week = Date.today - 7.days..Date.today
    object.case_contacts.where(occurred_at: this_week).where(contact_made: true).count
  end

  def unsuccessful_contacts_this_week
    this_week = Date.today - 7.days..Date.today
    object.case_contacts.where(occurred_at: this_week).where(contact_made: false).count
  end
end
