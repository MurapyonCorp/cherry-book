# numbers = [1,2,3,4]
# sum = 0
# numbers.each do |n|
#   sum_value = n.even? ? n*10:n
#   sum += sum_value
# end
# puts sum

# --- 配列や文字列の一部を抜き出す ---
# a = [1,2,3,4,5]
# puts a[1..3]
# a = 'abcdef'
# puts a[1..3]

# --- n以上m以下、n以上m未満の判定をする ---
def liquid?(temperature)
  (0...100).include?(temperature)
end
puts liquid?(50)

