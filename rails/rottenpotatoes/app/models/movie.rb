class Movie < ActiveRecord::Base

  def self.ratings
    @valid_ratings ||= {'G' => true,'PG' => true,'PG-13' => true,'R' => true}
  end
  def self.reset_rating
    @valid_ratings = nil
  end
end
