# ＜第6章 正規表現を理解する＞
# ! 6.1 イントロダクション
# -- 6.1.1 この章の例題：ハッシュ記法変換プログラム
# ハッシュの書き方2通り
{
  :name => 'Alice',
  :age => 20,
  :gender => :female
}
# 下記を使用
{
  name: 'Alice',
  age: 20,
  gender: :female
}

# -- 6.1.2 ハッシュ記法変換プログラムの実行例
# <<TEXTは行指向文字列リテラルであり、文字列を作成する構文
old_syntax = <<TEXT
{
  :name => 'Alice',
  :age => 20,
  :gender => :female
}
TEXT
convert_hash_syntax(old_syntax)

# -- 6.1.3 この章で学ぶこと
# ・正規表現そのもの
# ・Rubyにおける正規表現オブジェクト

# ! 6.2 正規表現って何？
# -- 6.2.1 正規表現の便利さを知る
# プログラミング用語っぽい文字列を抜き出すプログラムを書いてみよう
text = <<TEXT
I love Ruby.
Python is a great language.
Java and JavaScript are different.
TEXT
text.scan(/[A-Z][A-Za-z]+/)   # scanメソッドの引数部分が正規表現になる

# 次は文字列変換をしてみよう
text = <<TEXT
私の郵便番号は1234567です。
僕の住所は6770056 兵庫県西脇市板波町1234だよ。
TEXT
puts text.gsub(/(\d{3})(\d{4})/, '\1-\2')

# -- 6.2.2 正規表現をゼロから学習するための参考資料
# ・初心者 歓迎！ 手 と 目 で 覚える 正規表現 入門・その １「 さまざま な 形式 の 電話番号 を 検索 しよ う」 - Qiita
# ・初心者 歓迎！ 手 と 目 で 覚える 正規表現 入門・その ２「 微妙 な 違い を 許容 し つつ 置換 しよ う」 - Qiita
# ・初心者 歓迎！ 手 と 目 で 覚える 正規表現 入門・その ３「 空白 文字 を 自由自在 に 操ろ う」 - Qiita
# ・初心者 歓迎！ 手 と 目 で 覚える 正規表現 入門・その ４（ 最終回）「 中級 者 テクニック を マスター しよ う」 - Qiita

# ! 6.3 Rubyにおける正規表現オブジェクト
# -- 6.3.1 Rubularで視覚的にマッチするt文字列を確認する
Rubularのオンラインツールを起動し、”Your test string”欄に下記を記入
私の番号は090-1234-5678です。
”Your regular expression”欄に以下を記入
[\d-]+
”match result”欄に正規表現にマッチした文字列がハイライトされる

# -- 6.3.2 正規表現のキャプチャを利用する
私の誕生日は1977年7月17日です。
\d+年\d+月\d+日 とすると    => 1977年7月17日がハイライトされる

(\d+)年(\d+)月(\d+)日とすると　　=> ”Match group”という欄が表れて1977,7,17を抜き出すことができる

text = '私の誕生日は1977年7月17日です。'
m = /(\d+)年(\d+)月(\d+)日/.match(text)
m[0]
m[1]
m[2]
m[3]
m[2, 2]
m[-1]
m[1..3]

# -- 6.3.3 キャプチャの結果に名前を付ける
text = '私の誕生日は1977年7月17日です。'
m = /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/.match(text)
m[:year]
m[:month]
m[:day]
m['year']
m[2]

text = '私の誕生日は1977年7月17日です。'
if /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/ =~ text
  puts "#{year}/#{month}/#{day}"
end

-- 6.3.4 正規表現と組み合わせると便利なStringクラスのメソッド
◇scan
'123 456 789'.scan(/\d+/)
'1977年7月17日 2016年12月31日'.scan(/(\d+)年(\d+)月(\d+)日/)
'1977年7月17日 2016年12月31日'.scan(/(?:\d+)年(?:\d+)月(?:\d+)日/)
'1977年7月17日 2016年12月31日'.scan(/\d+年\d+月\d+日/)

◇[], slice, slice!
text = '郵便番号は123-4567です'
text[/\d{3}-\d{4}/]

text = '123-4567 456-7890'
text[/\d{3}-\d{4}/]

text = '私の誕生日は1977年7月17日です。'
text[/(\d+)年(\d+)月(\d+)日/, 3]
text[/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/, :day]
text[/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/, 'day']

text = '郵便番号は123-4567です'
text.slice(/\d{3}-\d{4}/)
text = '私の誕生日は1977年7月17日です。'
text.slice(/(\d+)年(\d+)月(\d+)日/, 3)
text = '郵便番号は123-4567です'
text.slice!(/\d{3}-\d{4}/)
text

◇split
text = '123,456-789'
text.split(',')
text.split(/,|-/)

◇gsub, gsub!
text = '123,456-789'
text.gsub(',', ':')
text.gsub(/,|-/, ':')

text = '私の誕生日は1977年7月17日です。'
text.gsub(/(\d+)年(\d+)月(\d+)日/, '\1-\2-\3')
text.gsub(/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/, '\k<year>-\k<month>-\k<day>')

text = '123,456-789'
hash = {',' => ':', '-' => '/'}
text.gsub(/,|-/, hash)
text.gsub(/,|-/){|matched| matched == ',' ? ':' : '/'}

text.gsub!(/,|-/, ':')
text


! 6.4 例題：Rubyのハッシュ記法を変換する
Rubyのハッシュ記法を文字列として受け取り、シンボルがキーであるものに関しては=>を使わない新しい記法に修正して返すプログラムを作る
-- 6.4.1 テストコードを準備する
convert_hash_syntax_test.rbを作成する。
convert_hash_syntax.rbを作成する。
convert_hash_syntaxメソッドを仮実装する。

-- 6.4.2 ハッシュ記法変換プログラムを実装する
正規表現を使って効率的に変換する。
Rubularの”Your test string”欄に入力する
Rubular : https://rubular.com/

! 6.5 正規表現オブジェクトについてもっと詳しく
-- 6.5.1 正規表現オブジェクトを作成する様々な方法
Regexp.new('\d{3}-\d{4}')
%r!http://example\.com!
%r{http://example\.com}
pattern = '\d{3}-\d{4}'
'123-4567' =~ /#{pattern}/

-- 6.5.2 case文で正規表を使う
  text = '03-1234-5678'
  case text
  when /^\d{3}-\d{4}$/
    puts '郵便番号です'
  when /^\d{4}\/\d{1,2}\/\d{1,2}$/
    puts '日付です'
  when /^\d+-\d+-\d+$/
    puts '電話番号です'
  end

  -- 6.5.3 正規表現オブジェクト作成時のオプション
  "Hello\nBye" =~ /Hello.Bye/m
regexp = Regexp.new('Hello.Bye', Regexp::MULTILINE)
"Hello\nBye" =~ regexp

regexp = /
  \d{3}#郵便番号の先頭3桁
  - #区切り文字のハイフン
  \d{4}#郵便番号の末尾4桁
/x
'123-4567' =~ regexp

pattern = <<'TEXT'
  \d{3}#郵便番号の先頭3桁
  -
  \d{4}#郵便番号の末尾4桁
TEXT
regexp = Regexp.new(pattern, Regexp::EXTENDED)
'123-4567' =~ regexp
regexp = Regexp.new('Hello.Bye', Regexp::IGNORECASE | Regexp::MULTILINE)
"HELLO\nBYE" =~ regexp

-- 6.5.4 組み込み変数でマッチの結果を取得する
text = '私の誕生日は1977年7月17日です。'
text =~ /(\d+)年(\d+)月(\d+)日/
$~
$&
$1
$2
$3
$+

-- 6.5.5 Regexp.last_matchでマッチの結果を取得する
text = '私の誕生日は1977年7月17日です。'
text =~ /(\d+)年(\d+)月(\d+)日/
Regexp.last_match
Regexp.last_match(0)
Regexp.last_match(1)
Regexp.last_match(-1)

-- 6.5.6 組み込み変数を書き換えないmatch?メソッド
/\d{3}-\d{4}/.match?('123-4567')
$~
Regexp.last_match
'123-4567'.match?(/\d{3}-\d{4}/)

! 6.6 この章のまとめ
正規表現は理解できると非常に便利な道具
いろんな場面で使用して作業効率を高めましょう！
