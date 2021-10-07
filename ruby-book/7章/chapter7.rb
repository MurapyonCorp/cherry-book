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
# class Product
#   DEFAULT_PRICE = 0
#   attr_reader :name, :price
#   def initialize(name, price = DEFAULT_PRICE)
#     @name = name
#     @price = price
#   end
# end
# product = Product.new('A free movie')
# product.price


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

# class DVD < Item
#   attr_reader :running_time
#   def initialize(name, price, running_time)
#     super(name, price)
#     @running_time = running_time
#   end

#   def to_s
#     "#{super}, running_time: #{running_time}"
#   end
# end
# item = Item.new('A great movie', 1000)
# item.to_s
# dvd = DVD.new('An awesome film', 3000, 120)
# dvd.to_s

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

! 7.8 定数についてもっと詳しく
-- 7.8.0
# class Product
#   DEFAULT_PRICE = 0
# end
# Product::DEFAULT_PRICE  => 0

# class Product
#   DEFAULT_PRICE = 0
#   private_constant :DEFAULT_PRICE
# end
# Product::DEFAULT_PRICE  => private constant Product::DEFAULT_PRICE referenced (NameError)

# class Product
#   def foo
#     DEFAULT_PRICE = 0   => dynamic constant assignment (SyntaxError)
#   end
# end

--7.8.1 定数と再代入
# class Product
#   DEFAULT_PRICE = 0
#   DEFAULT_PRICE = 1000
# end
# Product::DEFAULT_PRICE = 3000
# Product.freeze
# Product::DEFAULT_PRICE = 5000

--7.8.2 定数はミュータブルなオブジェクトに注意する
# class Product
#   中身 の 文字列 も freeze する
#   SOME_ NAMES = ['Foo'. freeze, 'Bar'. freeze, 'Baz'. freeze]. freeze
#                                   ＝
#   SOME_NAMES = ['Foo', 'Bar', 'Baz'].map(&:freeze).freeze
# end
# 今度 は 中身 も freeze し て いる ので 破壊的 な 変更 は でき ない
# Product:: SOME_ NAMES[ 0]. upcase! => RuntimeError: can' t modify frozen String

! 7.9 さまざまな種類の変数
-- 7.9.1 クラスインスタンス変数
# class Product
#   クラスインスタンス変数
#   @name = 'Product'
#   def self.name
#     クラスインスタンス変数
#     @name
#   end

#   def initialize(name)
#     インスタンス変数
#     @name = name
#   end

#   def name
#     インスタンス変数
#     @name
#   end
# end

# class Audio < Product
#   @name = 'DVD'
#   def self.name
#     # クラスインスタンス変数を参照
#     @name
#   end
  
#   def upcase_name
#     # インスタンス変数を参照
#     @name.upcase
#   end
# end
# Product.name
# Audio.name
# product = Product.new('A great movie')
# product.name

# dvd = Audio.new('An awesome film')
# dvd.name
# dvd.upcase_name

# Product.name
# Audio.name

-- 7.9.2 クラス変数
# class Product
#   @@name = 'Product'
#   def self.name
#     @@name
#   end

#   def initialize(name)
#     @@name = name
#   end

#   def name
#     @@name
#   end
# end

# class Audio < Product
#   @@name = 'DVD'
#   def self.name
#     @@name
#   end
  
#   def upcase_name
#     @@name.upcase
#   end
# end
# Product.name
# Audio.name
# product = Product.new('A great movie')
# product.name

# dvd = Audio.new('An awesome film')
# dvd.name
# dvd.upcase_name

# Product.name
# Audio.name

-- 7.9.3 グローバル変数と組み込み変数
# $program_name = 'Awesome program'
# class Program
#   def initialize(name)
#     $program_name = name
#   end

#   def self.name
#     $program_name
#   end

#   def name
#     $program_name
#   end
# end
# Program.name
# program = Program.new('Super program')
# program.name

# Program.name
# $program_name

! 7.10 クラス定義やRubyの言語使用に関する高度な話題
-- 7.10.1 エイリアスメソッドの定義
# class User
#   def hello
#     'Hello!'
#   end
#   alias greeting hello
# end
# user = User.new
# user.hello
# user.greeting

-- 7.10.2 メソッドの削除
# class User
#   undef freeze
# end
# user = User.new
# user.freeze

-- 7.10.3 ネストしたクラスの定義
# class User
#   class BloodType
#     attr_reader :type
#     def initialize(type)
#       @type = type
#     end
#   end
# end
# blood_type = User::BloodType.new('B')
# blood_type.type

-- 7.10.4 演算子の挙動を独自に再定義する
# class User
#   def name=(value)
#     @name = value
#   end
# end
# user = User.new
# user.name = 'Alice'

# class Product
#   attr_reader :code, :name
#   def initialize(code, name)
#     @code = code
#     @name = name
#   end
#   # 付け加える
#   def ==(other)
#     if other.is_a?(Product)
#       code == other.code
#     else
#       false
#     end
#   end
# end
# a = Product.new(' A-0001', 'A great movie')
# b = Product.new(' B-0001', 'An awesome film')
# c = Product.new(' A-0001', 'A great movie')

# a == b  #'false'
# a == c  #'false'  付け加えた後 => true
# a == a  #'true'

-- 7.10.5 等値を判断するメソッドや演算子を理解する
[equal?]
a = 'abc'
b = 'abc'
a.equal?(b)
c = a
a.equal?(c)

[==]
1 == 1.0

[eql?]
h = {1 => 'Integer', 1.0 => 'Float'}
h[1]
h[1.0]
1.eql?(1.0)
a = 'japan'
b = 'japan'
c = 1
d = 1.0
a.eql?(b)
a.hash
b.hash
c.eql?(d)
c.hash
d.hash

[===]
text = '03-1234-5678'
case text
when /^\d{3}-\d{4}$/
  puts '郵便番号です'
when /^\d{4}\/\d{1, 2}\/\d{1, 2}$/
  puts '日付 です'
when /^\d+-\d+-\d+$/
  puts '電話番号です'
end

-- 7.10.6 オープンクラスとモンキーパッチ
# class User
#   def initialize(name)
#     @name = name
#   end

#   def hello
#     "Hello, #{@name}"
#   end
# end

# class User
#   alias hello_original hello
#   def hello
#     "#{hello_original}じゃなくて、#{@name}さん、こんにちは！"
#   end
# end
# user = User.new('Alice')
# user.hello

--  7.10.7 特異メソッド
# alice = 'I am Alice'
# class << alice
#   def shuffle
#     chars.shuffle.join
#   end
# end
# alice.shuffle