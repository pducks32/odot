require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) {
    TodoList.create title: "Grocery's List",
                    description: "A list of things to buy at the grocery store"
  }
  def visit_todo_list(list=todo_list)
    visit "/todo_lists"

    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end
  it "displays the title of the todo list" do
    visit_todo_list
    within "h1" do
      expect(page).to have_content todo_list.title
    end
  end
  context "when a todo list is empty" do
    it "displays no items" do
      expect(page.all(".todo_items .todo_item").size).to eq(0)
    end
  end
  context "when a todo list has items" do
    it "displays item content" do
      todo_list.todo_items.create(content: "Milk")
      todo_list.todo_items.create(content: "Eggs")
      visit_todo_list
      expect(page.all(".todo_items .todo_item").size).to eq(2)
      within ".todo_items" do
        expect(page).to have_content("Milk")
        expect(page).to have_content("Eggs")
      end
    end
  end

end
