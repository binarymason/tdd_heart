class HeartInspector
  DEFAULTS = {
    tmux_location:  ENV['HOME'] + '/.tmux.conf',
    target_setting: 'set -g status-right',
    result_file:    '/.guard_result'
  }

  attr_reader :result, :existing_settings

  def initialize
    @existing_settings = load_existing_settings
  end

  def load_existing_settings(setting: nil, file_path: nil)
    setting   ||= DEFAULTS[:target_setting]
    file_path ||= DEFAULTS[:tmux_location]

    file = File.open file_path

    config = nil
    file.each { |line| config = line if /#{setting}/ =~ line }
    file.close

    config.chomp.split('"').last
  end

  def refresh_status
    read_test_status
    system(update_status_command)
  end

  def read_test_status(file_path = nil)
    file_path ||= Dir.pwd + DEFAULTS[:result_file]
    return unless File.exist? file_path

    @result = File.read(file_path).chomp
  end

  def update_status_command
    "tmux set -g status-right '#{new_status}'"
  end

  def new_status
    return existing_settings if result.nil?
    output(result_color) + ' ' + existing_settings
  end

  def result_color
    success? ? 'green' : 'red'
  end

  def success?
    !!(/success/ =~ result)
  end

  def output(color)
    "#[fg=#{color}]♥"
  end
end
