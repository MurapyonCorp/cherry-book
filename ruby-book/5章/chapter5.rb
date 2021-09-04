# 5.1 イントロダクション
puts "5.1.1 この章のこの章の例題 ：長さの単位変換プログラム ---"
puts "・メートル、フィート、インチの単位を相互変換する"
puts
puts "5.1.2 長さの単位プログラムの実行例 ---"
# puts convert_length(1,'m', 'in')
# puts convert_length(15, 'in', 'm')
# puts convert_length(35000, 'ft', 'm')
puts
puts "5.1.3 この章で学ぶこと ---"
puts "・ハッシュ"
puts "シンボル"
puts "ハッシュ・シンボルともにRubyプログラムの中ではすごく多く登場するデータ型。"
puts
puts "5.1.4 ハッシュ ---"
h = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
[1, 2, 3].each {|n| puts n }
puts

puts "5.2.1 要素の追加、変更、取得 ---"
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee'}
currencies['italy'] = 'euro'
currencies['japan'] = '円'
puts print currencies
puts print currencies['india']
puts

puts "5.2.2 ハッシュを使った繰り返し処理 ---"
currencies.each do |key, value|
  puts "#{key}: #{value}"
end
puts
# ブロック引数を１つにするとキーと値が配列に格納される。
currencies.each do |key_value|
  key = key_value[0]
  value = key_value[1]
  puts "#{key}: #{value}"
end
puts