class GameController < ApplicationController
  def index
    unless session[:color].is_a?(Hash) && session[:color].key?('r')
      generate_new_color
    end

    @correct_color = session[:color].transform_keys(&:to_sym)

    @r = session.delete(:r)
    @g = session.delete(:g)
    @b = session.delete(:b)
    @message = session.delete(:message)
    @attempts = session[:attempts] || 0
  end

  def check_answer
    r = params[:r].to_i
    g = params[:g].present? ? params[:g].to_i : nil
    b = params[:b].present? ? params[:b].to_i : nil

    if g.nil? || b.nil?
      session[:message] = "RGBの値をすべて入力してください。"
      redirect_to root_path
      return
    end

    session[:attempts] ||= 0
    correct_color = session[:color]&.transform_keys(&:to_sym)

    if correct_color.nil?
      session[:message] = "正解の色が設定されていません。再度お試しください。"
      redirect_to root_path
      return
    end

    puts "正解の色: R=#{correct_color[:r]}, G=#{correct_color[:g]}, B=#{correct_color[:b]}"
    puts "ユーザーの入力: R=#{r}, G=#{g}, B=#{b}"

    if r == correct_color[:r] && g == correct_color[:g] && b == correct_color[:b]
      puts "🎉 正解です！"

      session[:message] = "正解！お見事！新しい問題に挑戦しよう！"
      session[:attempts] = 0
      generate_new_color
    else
      session[:attempts] += 1
      puts "❌ 不正解です（#{session[:attempts]} 回目）"

      if session[:attempts] >= 3
        session[:message] = "3回間違えました！正解は R=#{correct_color[:r]}, G=#{correct_color[:g]}, B=#{correct_color[:b]} でした。新しい問題に挑戦しましょう。"
        session[:attempts] = 0
        generate_new_color
      else
        session[:message] = "残念、不正解です。あと #{3 - session[:attempts]} 回挑戦できます。"
      end
    end

    session[:r] = r
    session[:g] = g
    session[:b] = b

    redirect_to root_path
  end

  private

  def generate_new_color
    session[:color] = { 'r' => rand(256), 'g' => rand(256), 'b' => rand(256) }
  end
end
