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

# 5.2 ハッシュ
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

puts "5.2.3 ハッシュの同値比較、要素数の取得、要素の削除 ---"
a = {'x' => 1, 'y' => 2, 'z' => 3}
b = {'x' => 1, 'y' => 2, 'z' => 3}
puts print a == b
c = {'z' => 3, 'y' => 2, 'x' => 1}
puts print a == c
d = {'x' => 10, 'y' => 2, 'z' => 3}
puts print a == d
puts a.size
puts
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee'}
currencies.delete('japan')
puts print currencies
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee'}
currencies.delete('italy'){|key| "Not found: #{key}"}
puts print currencies
puts

# 5.3 シンボル
puts "5.3.1 シンボルと文字列の違い ---"
:apple.class #=> Symbol
'apple'.class #=> String
# シンボルのほうが文字列より高速比較が可能。
puts 'apple' == 'apple'
puts :apple == :apple
# シンボルは同じIDになるが文字列はすべて異なる
puts print :apple.object_id
puts print :apple.object_id
puts print 'apple'.object_id
puts print 'apple'.object_id
puts #シンボルはイミュータブルなオブジェクトであるため、破壊的な変更はできない。
string = 'apple'
string.upcase!
puts print string
puts
symbol = :apple
# symbol.upcase!
puts print symbol
puts

puts "5.3.2 シンボルの特徴と主な用途 ---"
currencies = {:japan => 'yen', :us => 'dollar', :india => 'rupee'}
# シンボルと使って文字列より高速に値を取り出す。
puts print currencies[:japan]
puts #オブジェクトが持っているメソッド名をシンボルの配列にして返す。
puts print 'apple'.methods
puts print :apple.methods
puts

# 5.4 続・ハッシュについて
puts "5.4.1 ハッシュのキーにシンボルを使う---"
currencies = {japan: :yen, us: :dollar, india: :rupee}    #83行目とまったく一緒になる。
puts print currencies[:us]
currencies[:italy] = 'euro'
puts print currencies
puts

puts "5.4.2 キーや値に異なるデータ型を混在させる---"
# 文字列とシンボルのキーをそれぞれ混在させる。
hash = {'abc' => 123, def: 456}
puts print hash['abc']
puts print hash[:def]
# ハッシュに格納する値は異なるデータ型が混在する可能性がある
person = {
  name: 'Alice',
  age: 20,
  friends: ['Bob', 'Carol'],
  phones: {home: '1234-0000', mobile: '5678-0000'}
}
puts print person
puts print person[:age]
puts

puts "5.4.3 メソッドのキーワード引数とハッシュ---"
# キーワード引数に変更してみる
def buy_burger(menu, drink: true, potato: true)
  if drink
    
  end
  if potato
    
  end
end
buy_burger('cheese', drink: true, potato: true)
buy_burger('fish')
# デフォルト値を持たないキーワード引数は呼び出し時に省略できない。
# キーワード引数に一致するハッシュを引数に渡すことができる。
params = {drink: true, potato: true}
# buy_burger('fish', params)
puts

# 5.5 例題：長さの単位変換プログラムを作成する
puts "5.5.1 テストコードを準備する　---"
# 1. convert_length_testファイルを作成
# 2. convert_lengthファイルを作成

puts "5.5.2 いろんな単位を変換できるようにする ---"
# インチからメートルへ変換
# フィートからメートルへの変換

puts "5.5.3 convert_lengthメソッドを改善する　---"
# メソッドの引数を文字列からシンボルへ変換
# キーワード引数を使用して引数の意味を明確化させる
# ハッシュを定数化させる
puts

# 5.6 ハッシュについてもっと詳しく
puts "5.6.1 ハッシュで使用頻度の高いメソッド　---"

'1. keys'
"keysメソッドはハッシュのキーを配列で返す"
currencies = {japan: 'yen', us: 'dollar', india: 'rupee'}
puts print currencies.keys
puts

'2. values'
"valuesメソッドはハッシュの値を配列で返す"
puts print currencies.values
puts

'3. has_key?, key?, include?, member?'
"has_key?メソッドはハッシュの中に指定されたキーが存在するかどうかを確認する"
puts print currencies.has_key?(:japan)
puts print currencies.has_key?(:italy)
puts
