require 'colorize'

class ConsoleInterface
  # В константе FIGURES будут лежать все текстовые файлы из папки figures,
  # помещённые в массив. Один элемент массива — одна строка с содержимым целого
  # файла.
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"]
    .sort
    .map { |file_name| File.read(file_name) }

  # На вход конструктор класса ConsoleInterface принимает экземпляр класса Game.
  #
  # Экземпляр ConsoleInterface выводит информацию юзеру. При выводе использует
  # статические строки типа "У вас осталось ошибок:" и информацию из экземпляра
  # класса Game, дёргая у него методы, которые мы придумали.
  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      #{colorize("Слово: #{word_to_show}", :blue)}
      #{colorize(figure, :yellow)}
      #{colorize("Ошибки (#{@game.errors_made}): #{errors_to_show}", :red)}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts colorize('Поздравляем, вы выиграли!', :green)
    elsif @game.lost?
      puts colorize("Вы проиграли, загаданное слово: #{@game.word}", :red)
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letters_to_guess.map { |letter| letter || '__' }.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def get_input
    print 'Введите следующую букву: '
    gets[0].upcase
  end

  private

  def colorize(text, color)
    text.colorize(color)
  end
end
