module Enumerable

  def my_each
    for i in self
      yield i
    end
  end

  def my_each_with_index
    i = 0
    for j in self
      yield j, i
      i += 1
    end
  end

  def my_select
    arr = []
    for i in self
      arr << i if yield i
    end
    arr
  end

  def my_all?(pat = nil)
    for i in self
      if block_given?
        if yield i
          next
        else
          return false
        end
      elsif pat != nil
        if patt.is_a?(Regexp)
          if pat =~ i
            next
          else
            return false
          end
        else
          if i.is_a?(pat)
            next
          else
            return false
          end
        end
      else
        return self.my_all?{|x| x}
      end
    end
    return true
  end

  def my_any?(pat = nil)
    for i in self
      if block_given?
        if yield i
          return true
        else
          next
        end
      elsif pat != nil
        if pat.is_a?(Regexp)
          if pat =~ i
            return true
          else
            next
          end
        else
          if i.is_a?(pat)
            return true
          else
            next
          end
        end
      else
        return self.my_any?{|x| x}
      end
    end
    return false
  end

  def my_none?(pat = nil)
    if block_given?
      !self.my_any?{|x| yield x}
    else
      !self.my_any?(pat)
    end
  end

  def my_count(item = nil)
    count = 0
    for i in self
      if item != nil
        count += 1 if i == item
      elsif block_given?
        count += 1 if yield i
      else
        count += 1
      end
    end
    count
  end

  def my_map(proc = nil)
    arr = []
    if proc != nil
      for i in self
        element = proc.call(i)
        arr << element
      end
    else
      for i in self
        element = yield i
        arr << element
      end
    end
    arr
  end

  def my_inject(init = nil)
    if init == nil
      init_num = true
    elsif init.is_a?(Symbol)
      return self.my_inject{|sum, n| sum.method(init).call(n)}
    else
      sum = init
      init_num = false
    end
    for i in self
      if init_num
        sum = i
        init_num = false
      else
        sum = yield sum, i
      end
    end
    sum
  end
end
