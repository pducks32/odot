require 'spec_helper'

describe "Creating todo items" do
  let!(:todo_list) {
    TodoList.create title: "Grocery's List",
                    description: "A list of things to buy at the grocery store"
  }
  def visit_todo_list_items(list=todo_list)
    visit "/todo_lists"

    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end
  def create_todo_item(options={})
    options[:content] ||= "Buy Eggs"

    expect(TodoItem.count).to eq(0)

    click_link "New Todo item"
    expect(page).to have_content("New todo_item")


    fill_in "Content", with: options[:content]
    click_button "Create Todo item"
  end

  def expect_error
    expect(page).to have_content("error")
    expect(TodoItem.count).to eq(0)

    visit_todo_list_items
    expect(page).to_not have_content("Buy Eggs")
  end
  it "redirects to the todo items index page on success" do
    visit_todo_list_items
    create_todo_item
    expect(page).to have_content("Buy Eggs")
  end

  it "displays an error when the todo list has no content" do
    visit_todo_list_items
    create_todo_item content: ""
    expect_error
  end

  it "displays an error when the todo list has a description with more than 140 characters" do
    visit_todo_list_items
    create_todo_item content: "This is longer than a legal tweet and so is invalid because who has a list item longer than a tweet. It just doesn’t make any sense, 140 characters is already a lot."
    expect_error
  end
end
