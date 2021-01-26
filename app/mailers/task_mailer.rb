class TaskMailer < ApplicationMailer
  def creation_email(task)
    @task = task
    @user = task.user
    mail(
      subject: 'タスク作成完了メール',
      to: @user.email
    )
  end
end
