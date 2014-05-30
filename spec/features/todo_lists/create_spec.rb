require 'spec_helper'

describe "Creating todo lists" do

  def create_todo_list(options={})
    options[:title] ||= "My Todo list"
    options[:description] ||= "This is my todo list"

    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")


    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  def expect_error
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My Todo list")
  end

  it "displays an error when the todo list has no title" do
    create_todo_list title: ""
    expect_error
  end

  it "displays an error when the todo list has a title with less than 3 characters" do
    create_todo_list title: "No"
    expect_error
  end

  it "displays an error when the todo list has no description" do
    create_todo_list description: ""
    expect_error
  end

  it "displays an error when the todo list has a description with less than 5 characters" do
    create_todo_list description: "Fail"
    expect_error
  end

end
