require 'json'
history_file = File.open(ENV['HOME'] + '/.bash_history')
commands = []
File.read(ENV['HOME'] + '/.bash_history').split("\n").each do |command|
  commands << command.split(" ").first
end
commands_data = []
unique_commands = commands.uniq.sort
unique_commands.each do |command|
  commands_data << {
                      name: command,
                      count: commands.count(command)
                   }
end
File.open("commands_history.json", "w") do |f|
  f.write(commands_data.to_json)
end
data = File.read('commands_history.json')
file_contents = File.read('commands_history_chart.js')
file_contents.gsub!(/var commandsHistory;/, 'var commandsHistory = ' + data + ';')
File.write('commands_history_chart.js', file_contents)
system("/usr/bin/open -a '/Applications/Google Chrome.app' commands_history_chart.html")
