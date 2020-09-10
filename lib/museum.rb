class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_interest = {}

    exhibits.each do |exhibit|
      exhibit_interest[exhibit] = find_patrons_interested(exhibit)
    end

    exhibit_interest
  end

  def ticket_lottery_contestants(exhibit)
    patrons.find_all do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    return nil if ticket_lottery_contestants(exhibit).empty?

    ticket_lottery_contestants(exhibit).sample.name
  end

  def announce_lottery_winner(exhibit)
    no_winner = "No winners for this lottery"

    return no_winner if ticket_lottery_contestants(exhibit).empty?

    "#{draw_lottery_winner(exhibit)} has won the #{exhibit.name} exhibit lottery"
  end

  private

  def find_patrons_interested(exhibit)
    patrons.find_all do |patron|
      patron.interests.include?(exhibit.name)
    end
  end
end
