class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count(" ") - @text.count("\r") - @text.count("\n")

    @word_count = @text.split.size

    words = @text.split
    frequency = Hash.new(0)
    words.each do |word|
      frequency[word.downcase] = frequency[word.downcase]+1
    end

    @special_word.downcase
    @occurrences = frequency[@special_word.downcase]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    r = @apr*0.01/12
    months = @years*12
    @monthly_payment = (@principal*(r*(1+r)**months)/((1+r)**months-1))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    if @sorted_numbers.count % 2==1
      then @median = @sorted_numbers[@sorted_numbers.count/2]
    else @median = (@sorted_numbers[@sorted_numbers.count/2]+@sorted_numbers[@sorted_numbers.count/2-1])/2
    end

    total = 0
    @numbers.each do |num|
      total = num + total
    end
    @sum = total

    @mean = @sum/@count

    total = 0
    @numbers.each do |num|
      total = (num-@mean)**2+total
    end

    @variance = total/(@count)

    @standard_deviation = @variance**0.5


    frequency = Hash.new(0)
    @numbers.each do |num|
      frequency[num] = frequency[num]+1
    end

    max_freq = -1
    @numbers.each do |num|
      if max_freq<frequency[num]
        max_freq=frequency[num]
        @mode = num
      end
    end

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
