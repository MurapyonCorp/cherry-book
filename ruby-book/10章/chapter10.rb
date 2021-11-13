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

# def greeting
#   puts 'おはよう'
#   # ブロックに引数を渡し、戻り値を受け取る
#   text = yield 'こんにちは'
#   # ブロックの戻り値をコンソールに出力する
#   puts text
#   puts 'こんばんは'
# end

# greeting do |text|
#   # yieldで渡された文字列（”こんにちは”）を2回繰り返す
#   text * 2
# end

-- 10.2.2 ブロック引数として明示的に受け取る
ブロックをメソッドの引数として明示的に受け取ることもできます。
ブロックを引数として受け取る場合は、引数名の前に&を付けます。また、そのブロックを実行する場合はcallメソッドを使います。
【 構文 】
# ブロックをメソッドの引数として受け取る
def メソッド(&引数)
  # ブロックを実行する
  引数.call
end
------------------------------------------------------------------------------------
# ブロックをメソッドの引数として受け取る
# def greeting(&block)
#   puts 'おはよう'
#   # callメソッドを使ってブロックを実行する
#   text = block.call('こんにちは')
#   puts text
#   puts 'こんばんは'
# end

# greeting do |text|
#   text * 2
# end

! 10.3 Procオブジェクト
-- 10.3.1 Procオブジェクトの基礎
# "Hello"という文字列を返すProcオブジェクトを作成する
# hello_proc = Proc.new do
#   'Hello!'
# end
または
hello_proc = Proc.new{'Hello!'}

Procオブジェクトを実行したい場合はcallメソッドを使います。
# Procオブジェクトを実行する(文字列が返る)
hello_proc.call

Procオブジェクトを作成する場合は、Proc.newだけでなく、Kernelモジュールのprocメソッドを使うこともできます。どちらを使ってもかまいません。
add_proc = proc{|a, b| a + b}

-- 10.3.2 Procオブジェクトをブロックの代わりに渡す
# def greeting(&block)
#   puts 'おはよう'
#   text = block.call('こんにちは')
#   puts text
#   puts 'こんばんは'
# end

# # Procオブジェクトを作成し、それをブロックの代わりとしてgreetingメソッドに渡す
# repeat_proc = Proc.new{|text| text * 2}
# greeting(&repeat_proc)

--　10.3.3 Procオブジェクトを普通の引数として渡す
次のコードはgreetingメソッドでブロックを受け取るのではなく、Procオブジェクトを普通の引数として受け取って実行するコード例です。
# ブロックではなく、1個のProcオブジェクトを引数として受け取る(&を付けない)
# def greeting(arrange_proc)
#   puts 'おはよう'
#   text = arrange_proc.call('こんにちは')
#   puts text
#   puts 'こんばんは'
# end

# # Procオブジェクトを普通の引数としてgreetingメソッドに渡す(＆を付けない)
# repeat_proc = Proc.new{|text| text * 2}
# greeting(repeat_proc)

-- 10.3.4 Proc.newとラムダの違い
次のような構文やメソッドを使ってもProcオブジェクトを作成することができる。
->(a, b){a + b}
lambda {|a, b| a + b}

Proc.newとラムダはほぼ同じものなのですが、微妙な違いが大きく分けて2つあります。
1つは引数の扱いです。単純な呼び出しではProc.newもラムダも引数の扱いに違いはありません。
以下はProc.newとラムダをそれぞれ実行するコード例です。

# Proc.newの作成と実行
add_proc = Proc.new{|a, b| a + b}
add_proc.call(10, 20)

# ラムダの作成と実行
add_lambda = ->(a, b){a + b}
add_lambda.call(10, 20)

しかしラムダはProc.newよりも引数のチェックが厳密になる。
#Proc.newの場合（引数がnilでもエラーが起きないようにto_iメソッドを使う）
add_proc = Proc.new{|a, b| a.to_i + b.to_i}
#Proc.newは引数が1つまたは3つでも呼び出しが可能
add_proc.call(10)
add_proc.call(10,20,100)
#ラムダの場合
add_lambda = ->(a, b){a.to_i + b.to_i}
#ラムダは個数について厳密なので、引数が2個ちょうどでなければエラーになる
add_lambda.call(10)
add_lambda.call(10,20,30)

-- 10.3.5 Proc.newかラムダかを判断するlambda？メソッド
ProcクラスのインスタンスがProc.newとして作られたのか、それともラムダとして作られたのか判断したい場合はlambda?メソッドを使います。
このメソッドはその名のとおり、ラムダとして作られたProcオブジェクトであればtrueを返します。
# Proc.newの場合
aa_proc = Proc.new{|a, b| a + b}
aa_proc.class
aa_proc.lambda?

# ラムダの場合
aa_lambda = ->(a, b){a + b}
aa_lambda.class
aa_lambda.lambda?

! 10.4 例題：ワードシンセサイザーの作成
-- 10.4.1 エフェクトの実装方法を検討する
module Effects
  def self.reverse
    # Procオブジェクト(ラムダ)をメソッドの戻り値にする
    ->(words)do
      # スペースで分解 ＞ 逆順に並び替え ＞ スペースで連結
      words.split('').map(&:reverse).join('')
    end
  end
end

-- 10.4.2 テストコードも2つに分ける
今回はWordSynthクラスとEffectsモジュールという2種類のクラス／モジュールが登場します。
EffectsモジュールについてはEffectsTestで、WordSynthクラスについてはWordSynthTestで、それぞれテストコードを書くことにします。

-- 10.4.3 テストコードを準備する
・最初に、testディレクトリにeffects_test.rbとword_synth_test.rbを作成します。
・続いて、libディレクトリにeffects.rbとword_synth.rbを作成します。
