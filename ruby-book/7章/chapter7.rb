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

! 7.2 オブジェクト指向プログラミングの基礎知識
-- 7.2.1 クラスを使う場合と使わない場合の比較
# Userクラスを定義する
class User
  attr_reader :first_name, :last_name, :age
  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
  # 氏名を作成するメソッド
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end

# ユーザーデータを作成
users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Python', 30)

# ユーザーのデータを表示する
users.each do |user|
  puts "氏名: #{full_name(user)}", "年齢: #{user.age}"
end

-- 7.2.2 オブジェクト指向プログラミング関連の用語
alice = User.new('Alice', 'Ruby', 20)
bob = User.new('Bob', 'Python', 30)
alice.full_name
bob.full_name

! 7.3 クラスの定義
-- 7.3.1 オブジェクトの作成とInitializeメソッド
# class User
#   def initialize(name, age)
#     puts "name: #{name}, age: #{age}"
#   end
# end
# User.new('Alice', 20)

# user = User.new
# user.initialize   #=> 外部呼出しはできない

-- 7.3.2 インスタンスメソッドの定義
class User
  def hello
    "Hello!"
  end
end
user = User.new
user.hello

-- 7.3.3 インスタンス変数とアクセサメソッド
class Name
  def initialize(name)
    @name = name
  end

  def hello
    "Hello, I am #{@name}"
  end
end
alice = Name.new('Alice')
alice.hello

class Shuffle
  def initialize(name)
    @name = name
  end
  def hello
    shuffled_name = @name.chars.shuffle.join
    "Hello, I am #{shuffled_name}"
  end
end
shuffle = Shuffle.new('Alice')
shuffle.hello

# アクセサメソッド
class UserBob
  def initialize(name)
    @name = name
  end
  def name
    @name
  end
  def name=(value)
    @name = value
  end
end
bob = UserBob.new('Alice')
bob.name = 'Bob'
bob.name

-- 7.3.4 クラスメソッドの定義
class ClassMethod
  def initialize(name)
    @name = name
  end
  
  def self.create_users(names)
    names.map do |name|
      ClassMethod.new(name)
    end
  end

  def hello
    "Hello, I am #{@name}"
  end
end
names = ['Alice', 'Bob', 'Carol']
users = ClassMethod.create_users(names)
users.each do |user|
  puts user.hello
end

-- 7.3.5 定数
class Product
  DEFAULT_PRICE = 0
  attr_reader :name, :price
  def initialize(name, price = DEFAULT_PRICE)
    @name = name
    @price = price
  end
end
product = Product.new('A free movie')
product.price


! 7.4 例題：改札機プログラムの作成
-- 7.4.1 テストコードを準備する
・gate_test.rbを作成
・gate.rbを作成

-- 7.4.2 必要なメソッドやクラスを仮実装する
テストシナリオを実装する
・150円の切符を購入する
・梅田で入場し、十三で出場する
・期待する結果：出場できる

-- 7.4.3 運賃が足りているかどうかを判別する
テストシナリオを実装する
・150円の切符を購入する
・梅田で入場し、三国で出場する
・期待する結果：出場できない