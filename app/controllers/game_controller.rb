class GameController < ApplicationController
  #GameControllerという名前のコントローラクラスを定義
  #ApplicationControllerを継承

  def index
    reset_game
    #reset_gameメソッドを呼び出す
  end

  def check_answer
    @r = params[:r].to_i
    @g = params[:g].to_i
    @b = params[:b].to_i


    @randam_num=generate_new_color()

    
    puts @randam_num
    puts @randam_num[:r]
    puts @randam_num[:g]
    puts @randam_num[:b]
    

    @ran_r=@randam_num[:r]
    @ran_g=@randam_num[:g]
    @ran_b=@randam_num[:b]

    
    @score = calculate_score(@r, @g, @b,@ran_r,@ran_g,@ran_b)#インスタンスを呼び出している
    
    @message = score_message(@score)#インスタンスを呼び出している
    @color = session[:color]#セッションから正解の色 (session[:color])を取得
    @correct_color = session[:color] # 正解の色をビューに渡す
    render :index
  end

  def reset
    #gameをリセットする,リセットボタン
    reset_game
    render :index
  end

  def new_question
    #新しいクイズ
    generate_new_color
    render :index

  end

  private

  def reset_game
    #ゲームをリセットする
    session[:score] = 0
    generate_new_color
  end

  def generate_new_color
    @color = { r: rand(256), g: rand(256), b: rand(256) }
    session[:color] = @color
    #puts @color
  end

  def calculate_score(r, g, b,ran_r,ran_g,ran_b)#RGB値の違いに基づいてスコアを計算する
    correct_color = session[:color]
        if r==ran_r && g==ran_g && b== ran_b then
          puts(r)
          puts(g)
          puts(b)
          puts("正解")
        else
          puts(r)
          puts(g)
          puts(b)
          puts("間違い")  
        end
    #  if correct_color.nil?
    #   generate_new_color
    #   correct_color = session[:color]
    # end
    # score = 0
    # score += point_for_color(r, correct_color[:r])
    # score += point_for_color(g, correct_color[:g])
    # score += point_for_color(b, correct_color[:b])
    # session[:score] += score
    # score
  end

  def point_for_color(guess, correct)
    #スコアに基づいてメッセージを生成する
    return 0 if correct.nil?

    diff = (guess - correct).abs
    case diff
    when 0
      10
    when 1..2
      8
    when 3..6
      6
    when 7..10
      4
    when 11..30
      2
    when 31..50
      1
    else
      0
    end
  end

  def score_message(score)
    if score == 30
      "正解です！"
    else
      "スコア: #{score}"
    end
  end
end
