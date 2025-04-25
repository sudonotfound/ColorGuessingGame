class GameController < ApplicationController
  def index
    reset_game
  end

  def check_answer
    # 入力値の取得
    @r = params[:r].to_i
    @g = params[:g].to_i
    @b = params[:b].to_i

    # 正解の色を取得（新しい色を生成）
    @randam_num = generate_new_color
    @ran_r = @randam_num[:r]
    @ran_g = @randam_num[:g]
    @ran_b = @randam_num[:b]

    # 判定とスコア処理
    @result = calculate_score(@r, @g, @b, @ran_r, @ran_g, @ran_b)
    @color = session[:color]
    @correct_color = session[:color]

    render :index
  end

  private

  def reset
    reset_game
    render :index
  end

  def new_question
    generate_new_color
    render :index
  end

  def reset_game
    session[:score] = 0
    generate_new_color
  end

  def generate_new_color
    @color = { r: rand(256), g: rand(256), b: rand(256) }
    session[:color] = @color
    @color
  end

  def calculate_score(r, g, b, ran_r, ran_g, ran_b)
    if r == ran_r && g == ran_g && b == ran_b
      "正解！お見事！"
    else
      "残念、不正解です。"
    end
  end
end
