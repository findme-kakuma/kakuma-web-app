class Admin::MatchesController < Admin::ApplicationController
  def index
    @matches = Relationship.matches
  end
end
