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
# class User
#   attr_reader :first_name, :last_name, :age
#   def initialize(first_name, last_name, age)
#     @first_name = first_name
#     @last_name = last_name
#     @age = age
#   end
#   # 氏名を作成するメソッド
#   def full_name(user)
#     "#{user.first_name} #{user.last_name}"
#   end
# end

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
# class User
#   def hello
#     "Hello!"
#   end
# end
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

-- 7.6.2 デフォルトで継承されるObjectクラス
class DefaultObject
end
user = DefaultObject.new
user.to_s
user.nil?
DefaultObject.superclass
user.methods.sort

-- 7.6.3 オブジェクトのクラスを確認する
user = DefaultObject.new
user.class
user.instance_of?(DefaultObject)
user.instance_of?(String)
user.is_a?(DefaultObject)
user.is_a?(Object)
user.is_a?(BasicObject)
user.is_a?(String)

-- 7.6.4 ほかのクラスを継承したクラスを作る
# Itemクラスとそれを継承したDVDクラス
        Item
         ↑
        DVD
# class Item
# end

# class DVD < Item
# end

-- 7.6.5 superでスーパークラスのメソッドを呼び出す
# class Item
#   attr_reader :name, :price
#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
# end
# item = Item.new('A great movie', 1000)
# item.name
# item.price

# class DVD < Item
  # def initialize(name, price)
  #   super
  # end
# end
# dvd = DVD.new('A great movie', 1000)
# dvd.name
# dvd.price

-- 7.6.6 メソッドのオーバーライド
class Item
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
  
  def to_s
    "name: #{name}, price: #{price}"
  end
end

class DVD < Item
  attr_reader :running_time
  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end

  def to_s
    "#{super}, running_time: #{running_time}"
  end
end
item = Item.new('A great movie', 1000)
item.to_s
dvd = DVD.new('An awesome film', 3000, 120)
dvd.to_s

-- 7.6.7 クラスメソッドの継承
class FooSucceed
  def self.hello
    'hello'
  end
end

class Bar < FooSucceed
end
FooSucceed.hello
Bar.hello

! 7.7 メソッドの公開レベル
-- 7.7.1 publicメソッド
class Public
  def hello
    'Hello!'
  end
end
user = Public.new
user.hello

-- 7.7.2 privateメソッド
# class Private
#   private
#   def hello
#     'Hello!'
#   end
# end
# user = Private.new
# user.hello

class Private
  def hello
    "Hello, I am #{self.name}"
  end

  private
  def name
    'Alice'
  end
end
user = Private.new
user.hello

-- 7.7.3 privateメソッドはサブクラスでも呼び出せる
class ProSubclass
  private
  def name
    'A great movie'
  end
end

class CD < ProSubclass
  def to_s
    "name: #{name}"
  end
end

cd = CD.new
cd.to_s

-- 7.7.4 クラスメソッドをprivateにしたい場合
# class User
#   class << self

#     private
#     def hello
#       'Hello!'
#     end
#   end
# end
# User.hello

# class User
#   def self.hello
#     'Hello!'
#   end
#   private_class_method :hello
# end
# User.hello

-- 7.7.5 privateメソッドから先に定義する場合
# class User
#   private
#   def Foo
#   end

#   public
#   def bar
#   end
# end

-- 7.7.6 あとからメソッドの公開レベルを変更する場合
# class User
#   def foo
#     'foo'
#   end
#   def bar
#     'bar'
#   end

#   private :foo, :bar

#   # bazはpublicメソッド
#   def baz
#     'baz'
#   end
# end
# user = User.new
# user.foo
# user.bar
# user.baz

-- 7.7.7 protectedメソッド
# class User
#   # weightは外部に公開しない
#   attr_reader :name
#   def initialize(name, weight)
#     @name = name
#     @weight = weight
#   end
#   # 自分がother_userより重い場合はtrue
#   def heavier_than?(other_user)
#     other_user.weight < @weight
#   end

#   protected
#   def weight
#     @weight
#   end
# end
# alice = User.new('Alice', 50)
# bob = User.new('Bob', 60)
# alice.heavier_than?(bob)
# bob.heavier_than?(alice)
# alice.weight