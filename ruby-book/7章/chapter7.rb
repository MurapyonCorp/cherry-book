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

-- 7.4.4 テストコードのリファクタリング
テストメソッドの名前に一貫性がない
Gateオブジェクトの作成を共通化しよう

-- 7.4.5 残りのテストケースをテストする
3つ目のシナリオ
・190円の切符を購入する
・梅田で入場し、三国で出場する
・期待する結果：出場できる

4つ目のシナリオ
・150円の切符を購入する
・十三で入場し、三国で出場する
・期待する結果：出場できる

! 7.5 selfキーワード
-- 7.5.1 selfの付け忘れで不具合が発生するケース
class SelfForget
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def rename_to_bob
    # selfなしでname=メソッドを呼ぶ
    name = 'Bob'
  end

  def rename_to_carol
    # self付きでname=メソッドを呼ぶ
    self.name = 'Carol'
  end

  def rename_to_dave
    # 直接インスタンス変数を書き換える
    @name = 'Dave'
  end
end
user = SelfForget.new('Alice')
user.rename_to_bob
user.name
user.rename_to_carol
user.name
user.rename_to_dave
user.name

-- 7.5.2 クラスメソッドやクラス構文直下のself
class Foo
  # このputsはクラス定義の読み込み時に呼び出される
  puts "クラス構文直下のself: #{self}"
  def self.bar
    puts "クラスメソッド内のself: #{self}"
  end

  def baz
    puts "インスタンスメソッド内のself: #{self}"
  end
end
Foo.bar
foo = Foo.new
foo.baz

-- 7.5.3 クラスメソッドをインスタンスメソッドで呼び出す
class CallInstance
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  # 金額を整形するクラスメソッド
  def self.format_price(price)
    "#{price}円"
  end

  def to_s
    # インスタンスメソッドからクラスメソッドを呼び出す
    formatted_price = CallInstance.format_price(price)
    "name: #{name}, price: #{formatted_price}"
  end
end

product = CallInstance.new('A great movie', 1000)
product.to_s

! 7.6 クラスの継承
--　7.6.1 標準ライブラリの継承関係
          BasicObject
              ↑
            Object
   ___________↑_____________
  |         |        |      |
String   Numeric   Array   Hash
   _________↑___________________
  |         |         |         |
Integer   Float   Rational   Complex