class CrudNotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crud_notification_mailer.create_notification.subject
  #
  def create_notification(object)
    @object = object
    @object_count = object.class.count

    mail to: "admin@blog.com", subject: "A new entry for #{object.class} has been created"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crud_notification_mailer.update_notification.subject
  #
  def update_notification(object)
    @object = object
    @object_count = object.class.count

    mail to: "admin@blog.com", subject: "An entry from #{object.class} has been updated"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crud_notification_mailer.delete_notification.subject
  #
  def delete_notification(object)
    @object = object
    @object_count = object.class.count

    mail to: "admin@blog.com", subject: "An entry from #{object.class} has been deleted"
  end
end



