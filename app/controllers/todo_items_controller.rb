class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: [:edit, :update, :destroy]
  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_items = @todo_list.todo_items
  end

  # GET /todo_lists/1/todo_items/new
  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new
  end

  # GET /todo_lists/1/todo_items/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)

      if @todo_item.save
        flash[:success] = "Added Todo list item"
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "There was an error adding that Todo item"
        render action: :new
      end
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to action: 'index', notice: 'Todo item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:content)
    end
end
