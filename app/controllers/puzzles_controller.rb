class PuzzlesController < ApplicationController
  before_action :doorkeeper_authorize!
  def show
    puzzle_parser = XmlParser.new(:unix_timestamp => params[:unix_timestamp], :feature_code => params[:feature_code])
    if puzzle_parser.asset_url
      render json: puzzle_parser.puzzle_data
    else
      render json: {"message": "No puzzle for this date"}, status: :not_found
    end
  end
  
  def tournament
    puzzle_parser = XmlParser.new(:unix_timestamp => params[:unix_timestamp], :feature_code => "usaont")
    if puzzle_parser.asset_url
      render json: puzzle_parser.puzzle_data
    else
      render json: {"message": "No puzzle for this date"}, status: :not_found
    end
  end
  
  def packs
    bundles = Rails.cache.fetch("packs#{params[:format]}", expires_in: 1.hour){ Tag.get_bundles(params) }
    if params[:pack_name].nil?
      render json: bundles
    elsif bundles["#{params[:pack_name]}"]
      render json: {"dates" => bundles["#{params[:pack_name]}"]}
    else
      render json: {"message": "No puzzle pack with this name"}, status: :not_found
    end
  end
  
  def empty_dates
    empty_dates = Rails.cache.fetch("empty-dates", expires_in: 1.hour){ Feature.find_by_feature_code("usaon").empty_dates }
    render json: empty_dates
  end
end