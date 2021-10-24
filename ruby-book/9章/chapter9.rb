< 第9章  例外処理を理解する >
! 9.1 イントロダクション
-- 9.1.1 この章の例題：正規表現チェッカープログラム
・ターミナル 上 で 動作 する 対話 型 の CUI（ character user interface） プログラム と する。
・起動すると“ Text?:”の文言が表示され、正規表現の確認で使うテキストの入力を求められる。
・テキストを入力すると、“Pattern?:”の文言が表示され、正規表現パターンの入力を求められる。
・正規表現として無効な文字列だった場合は、“Invalid pattern:”の文言に続いて具体的なエラー内容が表示され、再度パターンの入力を求められる。
・正規表現の入力が終わると、“Matched:”の文言に続いて、すべてのマッチした文字列がカンマ区切りで表示される。
・1つもマッチしなかった場合は“Nothing matched.”の文言が表示される。・マッチング結果を表示したらプログラムを終了する。

-- 9.1.2 正規表現チェッカーの実行例

-- 9.1.3 この章で学ぶこと
・例外の捕捉
・意図的に例外を発生させる方法
・例外処理のベストプラクティス

! 9.2 例外の捕捉
-- 9.2.1 発生した例外を捕捉しない場合
# puts 'Start'
# module Greeter
#   def hello
#     'hello'
#   end
# end
# greeter = Greeter.new
# puts 'End'      # irbコマンドであれば続けて先のコードも動かすことができるがrubyコマンドでは最後のEndは出力されない。
