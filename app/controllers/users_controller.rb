class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "user_templates/index" })
  end

  def show
    url_username = params.fetch("path_username")

    matching_username = User.where({ :username => url_username })

    @the_user = matching_username.at(0)

    render({:template => "user_templates/show"})
  end

  def create
    input_username = params.fetch("query_username")

    a_new_user = User.new

    a_new_user.username = input_username

    a_new_user.save

    redirect_to("/users/" + a_new_user.username, { :notice => "User added successfully." })
  end

  def destroy
    url_username = params.fetch("path_username")

    matching_users = User.where({ :id => url_username })

    the_user = matching_users.at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully." })
  end

  def update
    the_username = params.fetch("path_username")

    matching_users = User.where({:id => the_username})

    the_user = matching_users.at(0)

    input_username = params.fetch("query_username")

    the_user.username = input_username

    the_user.save
    
    next_url = "/users/" + the_user.username
    redirect_to(next_url)
  end
end
