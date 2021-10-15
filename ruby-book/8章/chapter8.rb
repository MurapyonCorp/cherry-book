< 第8章 モジュールを理解する >
! 8.1 イントロダクション
-- 8.1.1 この章の例題：deep_freezeメソッド
# class Team
#   # COUNTRIES = ['Japan', 'US', 'India'].freeze
#   COUNTRIES = ['Japan'.freeze, 'US'.freeze, 'India'.freeze].freeze
# end
上記のように全てにfreezeをつけるのは面倒だ

# class Team
#   COUNTRIES = deep_freeze(['Japan', 'US', 'India'])
# end
# Team::COUNTRIES.frozen? => true
# Team::COUNTRIES.all?{|country| country.frozen?} => true

# class Bank
#   CURRENCIES = deep_freeze({'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee'})
# end
# Bank::CURRENCIES.frozen? => true
# Bank::CURRENCIES.all?({|key, value| key.frozen? && value.frozen?}) => true

-- 8.1.2 この章で学ぶこと
・モジュールの概要
・モジュールのミックスイン(includeとextend)
・モジュールを利用した名前空間の作成
・関数や定数を提供するモジュールの作成
・状態を保持するモジュールの作成
・モジュールに関する高度な話題

! 8.2 モジュールの概要
-- 8.2.1 モジュールの用途
・継承を使わずにクラスにインスタンスメソッドを追加する、もしくは上書きする(ミックスイン)。
・複数のクラスに対して共通のお特異メソッド(クラスメソッド)を追加する(ミックスイン)。
・クラス名や定数名の衝突を防ぐために名前空間を作る。
・関数的メソッドを定義する。
・シングルトンオブジェクトのように扱って設定値などを保持する。

-- 8.2.2 モジュールの定義
# module Greeter
#   def hello
#     'hello'
#   end
# end
# module AwesomeGreeter < Greeter
# end   => syntax error, unexpected '<' (SyntaxError)

! 8.3 モジュールのミックスイン(includeとextend)
-- 8.3.1 モジュールをクラスにincludeする
# module Loggable
#   private
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# class Product
#   include Loggable
#   def title
#     log 'title is called.'
#     'A great movie'
#   end
# end

# class User
#   include Loggable
#   def name
#     log 'name is called.'
#     'Alice'
#   end
# end
# product = Product.new
# product.title
# user = User.new
# user.name

-- 8.3.2 モジュールをextendする
# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# class Product
#   extend Loggable
#   def self.create_products(names)
#     log 'create_products is called.'
#   end
# end
# Product.create_products([])
# Product.log('Hello.')

! 8.4 例題：deep_freezeメソッドの作成
-- 8.4.1 実装の方針を検討する
# module DeepFreezable
#   def deep_freeze(array_or_hash)
    
#   end
# end

# class Team
#   extend DeepFreezable
#   COUNTRIES = deep_freeze(['Japan', 'US', 'India'])
# end

# class Bank
#   extend DeepFreezable
#   CURRENCIES = deep_freeze({'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee'})
# end

-- 8.4.2 テストコードを準備する
・deep_freezable_test.rbを作成する
・deep_freezable.rbを作成する

-- 8.4.3 deep_freezeメソッドを実装する
・team.rbを作成する
・bank.rbを作成する

-- 8.4.4 deep_freezeメソッドをハッシュ対応させる
・テストコードを入力

! 8.5 ミックスインについてもっと詳しく
-- 8.5.1 includeされたモジュールの有無を確認する
# module Loggable
  
# end

# class Product
#   include Loggable
# end
# Product.include?(Loggable)
# Product.included_modules
# product = Product.new
# product.is_a?(Product)
# product.class.included_modules

-- 8.5.2 include先のメソッドを使うモジュール
# module Taggable
#   def  price_tag
#     # priceメソッドはinclude先で定義されているはずという前提
#     "#{price}円"
#   end
# end

# class Product
#   include Taggable
#   def price
#     1000
#   end
# end
# product = Product.new
# product.price_tag

-- 8.5.3 Enumerableモジュール
Array.include?(Enumerable)
Hash.include?(Enumerable)
Range.include?(Enumerable)

[1,2,3].map{|n| n*10}
{a: 1, b: 2, c: 3}.map{|k, v|[k, v *10]}
(1..3).map{|n| n *10}
[1,2,3].count
{a: 1, b: 2, c: 3}.count
(1..3).count

-- 8.5.4 Comparableモジュールと<=>演算子
2 <=> 1
2 <=> 2
1 <=> 2
2 <=> 'abc'

# class Tempo
#   include Comparable
#   attr_reader :bpm
#   def initialize(bpm)
#     @bpm = bpm
#   end

#   def <=>(other)
#     if other.is_a?(Tempo)
#       bpm <=> other.bpm
#     else
#       nil
#     end
#   end

#   def inspect
#     "#{bpm}bpm"
#   end
# end
# t_120 = Tempo.new(120)
# t_180 = Tempo.new(180)

# t_120 > t_180
# t_120 <= t_180
# t_120 == t_180