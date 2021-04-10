require "csv"
require "colorize"

# This module contains methods to open a checklist template with a pass/fail prompt
# and a method to save the altered checklist
module Checklist
  def save_details(line)
    CSV.open("./csv/checklist_results.csv", "a+") do |csv|
      csv << line
    end
  end

  def checklist
    prompt = TTY::Prompt.new
    checklist = CSV.parse(File.read("./csv/checklist.csv"))
    answers = []
    answer_key = { true => "Pass", false => "Fail".red }
    checklist.each do |line|
      passed = prompt.yes?(line[0]) do |q|
        q.suffix "Pass/Fail"
      end
      # answers[line[0]] = answer_key[passed]
      answers.push([line[0], answer_key[passed]])
    end
    answers
  end
end
