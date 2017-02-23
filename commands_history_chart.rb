require 'json'
shell_type = (`echo $SHELL`).split("/").last.chomp
history_file = File.open(ENV['HOME'] + "/.#{shell_type}_history")
commands = []
if shell_type.eql?("zsh")
  File.read(history_file).split(";").each do |command|
    commands << command.split(" ").first
  end
elsif shell_type.eql?("bash")
  File.read(history_file).split("\n").each do |command|
    commands << command.split(" ").first
  end
else
  puts "Only zsh and bash are supported for now."
  exit
end
commands = commands.compact
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
