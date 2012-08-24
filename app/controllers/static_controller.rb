# encoding: utf-8
class StaticController < ApplicationController

  def index
    @infos = Refinery::Infos::Info.recent.limit(5).order("created_at DESC, position ASC")
  end

  ## 更新到最新版本
  def git_pull
   # path = "/aries-lv-01/aries_srv/rails/cooper/current/"
  #  cmd = CommandBuilder::new("cd")
    #path = "/srv/rails/cooper/current/"
  #  cmd << path
  #  cmd.execute!
    #Dir.chdir(path)
    # system "git pull origin deploy"

    exec " cd /srv/rails/cooper/current/ && git pull origin  deploy"  
   # git = CommandBuilder::new("git")
   # git << "pull"
   # git << "origin"
   # git << "deploy"
    
   # git.execute!
    render :text => "a", :layout => false
  end
  
end
