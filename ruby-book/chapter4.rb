numbers = [1,2,3,4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n*10:n
  sum += sum_value
end
puts sum

# --- 配列や文字列の一部を抜き出す ---
a = [1,2,3,4,5]
puts a[1..3]
a = 'abcdef'
puts a[1..3]

# --- n以上m以下、n以上m未満の判定をする ---
def liquid?(temperature)
  (0...100).include?(temperature)
end
puts liquid?(50)

# --- case文で使う ---
def charge(age)
  case age
  when 0..5
    0
  when 6..12
    300
  when 13..18
    600
  else
    1000
  end
end

puts charge(3)
puts charge(12)
puts charge(16)
puts charge(25)

# 4.5.4 値が連続する配列を作成する ---
puts (1..5).to_a
puts (1...5).to_a
puts "splat展開"
puts [*1..5]
puts [*1...5]