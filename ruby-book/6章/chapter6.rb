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