require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) {
    TodoList.create title: "Grocery's List", description: "A list of things to buy at the grocery store"
  }
  it "displays todo items index page" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
    expect(page).to have_content("TodoItems#index")
  end
end
