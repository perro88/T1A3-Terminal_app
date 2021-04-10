module Users
  def find(path, index, search)
    CSV.open("./csv/#{path}.csv", "r") do |csv|
      record = csv.select { |line| line[index] == search }.first
      return { username: record[0], password: record[1] } if record
    end
  end
end
