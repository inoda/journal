class SeedPrompts < ActiveRecord::Migration[5.1]
  def change
    Prompt.create(content: "What was something that challenged you today?")
    Prompt.create(content: "What was an interesting thought or convo you had today?")
    Prompt.create(content: "What made you feel good today?")
    Prompt.create(content: "What do you want to improve on?")
    Prompt.create(content: "What made you feel bad today?")
    Prompt.create(content: "Do you want to do anything differently tomorrow?")
    Prompt.create(content: "What's a thought you had today that you don't want to forget?")
  end
end
