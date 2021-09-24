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
