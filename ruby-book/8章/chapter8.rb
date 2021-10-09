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