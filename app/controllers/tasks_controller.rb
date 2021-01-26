class TasksController < ApplicationController
  include Pagy::Backend
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all
    # @tasks = current_user.tasks.recent
    @q = current_user.tasks.ransack(params[:q])
    # @tasks = @q.result(distinct: true).recent
    @tasks = @q.result(distinct: true)
    @pagy, @tasks = pagy(@q.result(distinct: true))

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{l(Date.current)}.csv" }
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    # @task = Task.new(task_params)

    if @task.save
      # notice以外に、success, info, warning, errorも使用可能
      TaskMailer.creation_email(@task).deliver_now
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  # def update
  #   @task.update!(task_params)
  #   redirect_to tasks_url, notice:"タスク「#{@task.name}」を更新しました"
  # end

  def update
    # # task = Task.find(params[:id])
    # task = current_user.tasks.find(params[:id])

    # 画像の削除処理
    params[:task][:image_ids]&.each do |image_id|
      @task.images.find(image_id).purge_later
      ActiveStorage::Blob.unattached.find_each(&:purge)
    end

    if @task.update(task_params)
      # notice以外に、success, info, warning, errorも使用可能
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice:"タスク「#{@task.name}」を削除しました。"
  end

  def import
   current_user.tasks.import(params[:file])
   redirect_to tasks_url, notice: 'タスクを追加しました'
  end

  private

  def task_params
    # params.require(:task).permit(:name, :description, :image)
    params.require(:task).permit(:name, :description, images:[])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
