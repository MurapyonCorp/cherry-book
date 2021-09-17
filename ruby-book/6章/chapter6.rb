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