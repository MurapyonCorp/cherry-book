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

# 4.5.5 繰り返し処理を行う ---
numbers = (1..4).to_a
sum = 0
numbers.each {|n| sum += n}
puts sum
## 範囲オブジェクトに対して直接eachメソッドを呼び出す
sum = 0
(1..4).each {|n| sum += n}
puts sum
## stepメソッドで値を増やす間隔を指定できる
numbers = []
### 1から10まで2つ飛ばしで繰り返し処理を行う
(1..10).step(2) {|n| numbers << n}
puts numbers

# 4.7.1 さまざまな要素の取得方法 ---
a = [1,2,3,4,5]
puts a[1,3]
puts ""
puts a.values_at(0,2,4)
puts a[a.size - 1]
puts ""
puts a.last
puts a.last(2)
puts
puts a.first
puts a.first(2)
puts

# 4.7.2 様々な要素の変更方法 ---

a = [1,2,3]
a[-3] = -10
puts a[-3]
a = [1,2,3,4,5]
a[1,3] = 100
puts a
a = []
a.push(1)
a.push(2,3)
puts a
puts
a = [1,2,3,1,2,3]
a.delete(2)
puts a
a.delete(5)

puts
# 4.7.3 配列の連結 ---

a = [1]
b = [2,3]
a.concat(b)
puts a
puts b
puts
a = [1]
b = [2,3]
a + b
puts a
puts b
puts

# 4.7.4 配列の和集合、差集合、積集合 ---
a = [1,2,3]
b = [3,4,5]
puts a | b
puts
puts a - b
puts
puts a & b
puts
require 'set'
a = Set.new([1,2,3])
b = Set.new([3,4,5])
puts a | b
puts
puts a - b
puts
puts a & b
puts
puts "4.7.5 多重代入で残りの全要素を配列として受け取る ---"
e,f = 100,200,300
puts e
puts f
puts
e,*f = 100,200,300
puts e
puts f
puts
puts "4.7.6 1つの配列を複数の因数として展開する ---"
a = []
b = [2,3]
puts a.push(1)
puts a.push(b)
puts
puts a.push(*b)
puts
puts "4.7.7 メソッドの可変長引数 ---"
def greeting(*names)
  "#{names.join('と')}, こんにちは！ "
end
puts greeting('田中さん')
puts greeting('田中さん','鈴木さん')
puts greeting('田中さん','鈴木さん','佐藤さん')
puts
puts "4.7.8 *で配列同士を非破壊的に連結する ---"
a = [1,2,3]
puts [-1,0,*a,4,5]
puts
puts [-1,0] + a + [4,5]
puts