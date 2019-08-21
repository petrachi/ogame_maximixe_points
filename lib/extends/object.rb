class Object
  def merge_proc proc
    proc = proc.to_proc
    Proc.new{ |_, *args| proc.call(*args) }
  end
end
