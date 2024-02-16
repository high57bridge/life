class Admin::HomesController < ApplicationController

  def top
    @tops = Top.all
  end

end
