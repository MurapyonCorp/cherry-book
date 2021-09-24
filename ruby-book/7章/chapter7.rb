< 第7章 クラスの作成を理解する >
! 7.1 イントロダクション
-- 7.1.1 この章の例題：改札機プログラム

改札機オブジェクト
umeda = Gate.new(:umeda)
mikuni = Gate.new(:mikuni)

150円の切符を購入して梅田で乗車し、三国で降車する（足りない）
ticket = Ticket.new(150)
umeda.enter(ticket)
mikuni.exit(ticket) => false

190円の切符を購入して梅田で乗車し、三国で降車する（足りる）
ticket = Ticket.new(190)
umeda.enter(ticket)
mikuni.exit(ticket) => true

-- 7.1.2 この章で学ぶこと
・オブジェクト指向プログラミングの基礎知識
・クラスの定義
・selfキーワード
・クラスの継承
・メソッドの公開レベル
・定数
・様々な種類の変数
・クラス定義やRubyの言語使用に関する高度な話題
