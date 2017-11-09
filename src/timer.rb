class Timer

  def start()
    @history = {}
    @start_time = Time.now
  end

  def ellapsed()
    Time.now - @start_time
  end

  def save(tag)
    @history[ellapsed()] = tag
  end

  def history()
    str = ""
    last_time = 0
    @history.each do |timestamp, tag|
      str += "- #{timestamp.round(3)} : [#{tag}] // took #{(timestamp - last_time).round(3)}s\n"
      last_time = timestamp
    end
    str
  end
end