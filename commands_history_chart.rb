require 'json'
shell_type = (`echo $SHELL`).split("/").last.chomp
history_file = File.open(ENV['HOME'] + "/.#{shell_type}_history")
history_file_contents = File.read(history_file).encode('UTF-8', :invalid=>:replace, :replace=>"?")
history_file_contents.gsub!("\\", "")
commands = []
if shell_type.eql?("zsh")
  history_file_contents.split(";").each do |command|
    commands << command.split(" ").first
  end
elsif shell_type.eql?("bash")
  history_file_contents.split("\n").each do |command|
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
lines = File.readlines('commands_history_chart.js')
lines[1] = 'var commandsHistory = ' + data + ";\n"
File.write('commands_history_chart.js', lines.join())
system("/usr/bin/open -a '/Applications/Google Chrome.app' commands_history_chart.html")
