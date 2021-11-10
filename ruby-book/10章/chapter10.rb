< yieldとProcを理解する >
! 10.1 イントロダクション
-- 10.1.1 この章の例題：ワードシンセサイザー
エフェクトの種類
・リバース
・エコー
・ラウド

-- 10.1.2 この章で学ぶこと
・ブロックを利用するメソッドの定義とyield
・Procオブジェクト

! 10.2 ブロックを利用するメソッドの定義とyield
-- 10.2.1 yieldを使ってブロックの処理を呼び出す
# def greeting
#   puts 'おはよう'
#   # ブロックの有無を確認してからyieldを呼び出す
#   if block_given?
#     yield
#   end
#   puts 'こんばんは'
# end
# # ブロック付きでgreetingメソッドを呼び出す
# greeting do
#   puts 'こんにちは'
# end

def greeting
  puts 'おはよう'
  # ブロックに引数を渡し、戻り値を受け取る
  text = yield 'こんにちは'
  # ブロックの戻り値をコンソールに出力する
  puts text
  puts 'こんばんは'
end

greeting do |text|
  # yieldで渡された文字列（”こんにちは”）を2回繰り返す
  text * 2
end
