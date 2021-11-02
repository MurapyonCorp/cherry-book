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

-- 9.2.2 例外を捕捉して処理を続行する場合
・例外処理の構文
# begin
#   # 例外が起きうる処理
# rescue => exception
#   # 例外が発生した場合の処理
# end

# puts 'Start.'
# module Greeter
#   def hello
#     'hello'
#   end
# end

# # 先ほどのプログラムに例外処理を組み込んで例外に対処する。
# begin
#   greeter = Greeter.new
# rescue => exception
#   puts '例外が発生したが、このまま続行する'
# end
# # 例外処理を組み込んだためrubyコマンドでも最後まで実行可能
# puts 'End.'

-- 9.2.3 例外処理の流れ
# method_1にだけ例外処理を記述する
# def method_1
#   puts 'method_1 start.'
#   begin
#     method_2
#   rescue => exception
#     puts '例外が発生しました'
#   end
#   puts 'method_1 end.'
# end

# def method_2
#   puts 'method_2 start.'
#   method_3
#   puts 'method_2 end.'
# end

# def method_3
#   puts 'method_3 start.'
#   # ZeroDivisionErrorを発生させる
#   1 / 0
#   puts 'method_3 end.'
# end
# # 処理を開始する
# method_1

-- 9.2.4 例外オブジェクトから情報を読み取る
・例外オブジェクトから情報を取得したい場合の構文
# begin
#   # 例外が起きうる処理
# rescue => 例外オブジェクトを格納する変数
#   # 例外が発生した場合の処理
# end

# begin
#   1 / 0
# rescue => e
#   puts "エラークラス: #{e.class}"
#   puts "エラーメッセージ: #{e.message}"
#   puts "バックトレース -----"
#   puts e.backtrace
#   puts "-----"
# end

-- 9.2.5 クラスを指定して捕捉する例外を限定する
・例外のクラスを指定し、例外オブジェクトのクラスが一致した場合のみ例外を捕捉する構文
# begin
#   # 例外が起きうる処理
# rescue 捕捉したい例外のクラス
#   # 例外が発生した場合の処理
# end

# begin
#   'abc'.foo
# # rescue ZeroDivisionError
# #   puts "0で除算しました"
# # rescue NoMethodError
# #   puts "存在しないメソッドが呼び出されました"
# rescue ZeroDivisionError, NoMethodError => e
#   puts "0で除算したか、存在しないメソッドが呼び出されました"
#   puts "エラー: #{e.class} #{e.message}"
# end

-- 9.2.6 例外クラスの継承関係を理解する
[例外処理の悪い例]
# begin
#   # 例外が起きそうな処理
# rescue Exception
#   # Exceptionとそのサブクラスが捕捉される。
#   # つまりNoMemoryErrorやSystemExitまで捕捉される。StandardErrorクラスか、そのサブクラスに限定すべき。
# end

-- 9.2.7 継承関係とrescue節の順番に注意する
Exception
    ↑
StandardError
    ↑
NameError
    ↑
NoMethodError

例：
# begin
#   # NoMethodErrorを発生させる
#   'abc'.foo
# rescue NameError
#   # NoMethodErrorはここで捕捉される
#   puts 'NameErrorです'
# rescue NoMethodError
#   # このrescue節は永遠に実行されない
#   # NameErrorはNoMethodErrorのスーパークラスなので、NameErrorクラスを指定した最初のrescue節で捕捉されます。そのため、どんなことがあっても2つめのrescue節に到達することはないわけです。
#   puts 'NoMethodErrorです'
# end

# begin
#   # NoMethodErrorを発生させる
#   # 'abc'.foo
#   Foo.new
# rescue NoMethodError
#   # NoMethodErrorはここで捕捉される
#   puts 'NoMethodErrorです'
# rescue NameError
#   puts 'NameErrorです'
# end

# begin
#   # ZeroDivisionErrorを発生させる
#   1 / 0
# rescue NoMethodError
#   puts 'NoMethodErrorです'
# rescue NameError
#   puts 'NameErrorです'
# rescue
#   puts 'その他のエラーです'
# end

-- 9.2.8 例外発生時にもう一度処理をやり直すretry
・retryを用いた構文
# begin
#   # 例外が発生するかもしれない処理
# rescue
#   retry   # 処理をやり直す
# end
カウンタ変数を用いてretryの回数を制限することが望ましい。

# retry_count = 0
# begin
#   puts "処理を開始します。"
#   # わざと例外を発生させる
#   1 / 0
# rescue
#   retry_count += 1
#   if retry_count <= 3
#     puts "retryします。(#{retry_count}回目)"
#     retry
#   else
#     puts "retryに失敗しました。"
#   end
# end

! 9.3 意図的に例外を発生させる
コードの中で意図的に例外を発生させることができる。その場合はraiseメソッドを使う。
以下はメソッドで想定していない国名が渡されたときに例外を発生させる。
# def currency_of(country)
#   case country
#     when :japan
#       'yen'
#     when :us
#       'dollar'
#     when :india
#       'rupee'
#     else
#       # 意図的に例外を発生させる
#       raise ArgumentError, "無効な国名です。#{country}"
#   end
# end
# currency_of(:japan)
# currency_of(:canada)

! 9.4 例外のベストプラクティス
-- 9.4.1 安易にrescueを使わない
rescueすべき例外のほうが少ない。プログラミング初心者の人は「例外が発生したら即座に異常終了させよう」もしくは「Railsなどのフレームワークの共通処理に全部丸投げしよう」と考えるほうが安全である。

-- 9.4.2 rescueしたら情報を残す
例外が発生してもrescueしない、というのが例外処理の原則。
しかしケースによっては例外rescueを使用するほうが合理的な場合もある。そのときは例外時の状況を確実に記録に残そう。
最低でも発生した例外の[クラス名、エラーメッセージ、バックトレース]の3つはログやターミナルに出力すべき。次のようなイメージだ。

# 大量のユーザーにメールを送信する(例外が起きても最後まで続行する)
# users.each do |user|
#   begin
#     # メール送信を実行する
#     send_mail_to(user)
#   rescue => e
#     # (ログファイルがあればそこに出力するほうがベター)
#     puts "#{e.class}: #{e.message}"
#     puts e.backtrace
#   end
# end
例外をrescueしたらその場で情報を残さないと詳細な情報が失われてしまう。素早く原因を突き止め、適切な対策がとれるように詳細な情報を確実に残すようにしよう。

-- 9.4.3 例外処理の対象範囲と対称クラスを極力絞り込む
# require 'date'
# def convert_heisei_to_date(heisei_text)
#   m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
#   year = m[:jp_year].to_i + 1988
#   month = m[:month].to_i
#   day = m[:day].to_i
#   # 例外処理の範囲を狭め、捕捉する例外クラスを限定する
#   begin
#     Date.new(year, month, day)
#   rescue ArgumentError
#     # 無効な日付であればnilを返す
#     nil
#   end
# end
# convert_heisei_to_date('平成26年12月31日')
# convert_heisei_to_date('平成30年60月87日')

-- 9.4.4 例外処理よりも条件分岐を使う
# require 'date'
# def convert_heisei_to_date(heisei_text)
#   m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
#   year = m[:jp_year].to_i + 1988
#   month = m[:month].to_i
#   day = m[:day].to_i
#   # 正しい日付の場合のみ、Dateオブジェクトを作成する
#   if Date.valid_date?(year, month, day)
#     Date.new(year, month, day)
#   end
# end
# convert_heisei_to_date('平成26年12月31日')
# convert_heisei_to_date('平成30年60月87日')
bigin~rescueを使うよりも条件分岐を使ったほうが可読性やパフォーマンスの面で有利になる。
例外処理を書く前に問題の有無を事前に確認できるメソッドが用意されていないかチェックしよう。

-- 9.4.5 予期しない条件は異常終了させる
# elseを用意しないパターン(良くない例)
# def currency_of(country)
#   case country
#   when :japan
#     'yen'
#   when :us
#     'dollar'
#   when :india
#     'rupee'
#   end
# end
# # 想定外の国名を渡すとnilが返る
# currency_of(:italy)

# elseを:indiaとして扱うパターン(良くない例)
# def currency_of(country)
#   case country
#   when :japan
#     'yen'
#   when :us
#     'dollar'
#   else
#     'rupee'
#   end
# end
# currency_of(:italy)

# elseに入ったら例外を発生させるパターン(良い例)
# def currency_of(country)
#   case country
#   when :japan
#     'yen'
#   when :us
#     'dollar'
#   when :india
#     'rupee'
#   else
#     raise ArgumentError, "無効な国名です。#{country}"
#   end
# end
# currency_of(:italy)

! 9.5 例題：正規表現チェッカープログラムの作成
-- 9.5.1 テスト駆動開発をするかどうか
今まではテスト駆動開発で開発を行ってきたが、今回はユーザー入力やターミナル上での結果の表示などの少し上級者向けの技術要素が含まれているため無理にテスト駆動の
開発はしない。

-- 9.5.2 実装のフローチャートを考える
No.8163の図9-6参照

-- 9.5.3 文字入力を受け付けるgetsメソッド
# input = gets.chomp
# 改行は要らないため、chompメソッドを使う
# input

-- 9.5.4 実装を開始する

-- 9.5.5 例外処理を組み込む
例外処理を組み込み、例外が発生したらエラーメッセージを表示させて再試行(retry)するようにする。

! 9.6 例外処理についてもっと詳しく
-- 9.6.1 ensure
例外処理を入れたときに例外が発生するしないに関わらず必ず実行したい処理が出てくる場合にensure節を加える。
以下は例外発生の有無に関わらず速やかにfileオブジェクトをクローズ(システム開放)
する場合のコード例。

# 書き込みモードでファイルを開く
# file = File.open('some.txt', 'w')
# begin
#   # ファイルに文字列を書き込む
#   file << 'Hello'
# ensure
#   # 例外の有無に関わらず必ずファイルをクローズする
#   file.close
# end

-- 9.6.2 ensureの代わりにブロックを使う
ファイルの読み書きを行う場合、openメソッドにブロックを渡すことでensure節やクローズ処理を省くことが可能。

# ブロック付きでオープンすると、メソッドの実行後に自動的にクローズされる
# File.open('some.txt', 'w') do |file|
#   file << 'Hello'
# end

-- 9.6.3 例外処理のelse
例外が発生しなかった場合に実行されるelse節を書くことも可能。
しかしelse節はあまり使われない。begin節に処理を書けばよいから。

# else節を使用
# begin
#   puts 'Hello'
# rescue
#   puts '例外が発生しました。'
# else
#   puts '例外は発生しませんでした。'
# end

# else節を使用しない
# begin
#   puts 'Hello'
#   puts '例外は発生しませんでした。'
# rescue
#   puts '例外が発生しました。'
# end

-- 9.6.4 例外処理と戻り値
例外処理にも戻り値があります。例外が発生せず、最後まで正常に処理が進んだ場合はbegin節の最後の式が戻り値になります。
また、例外が発生してその例外が捕捉された場合はrescue節の最後の式が戻り値になります。
例外処理の戻り値を変数に格納する方法もありますが、次のようにメソッドの戻り値として使うこともできます。

# def some_method(n)
#   begin
#     1 / n
#     'OK'
#   rescue
#     'error'
#   ensure
#     'ensure'
#   end
# end
# some_method(1)
# some_method(0)
