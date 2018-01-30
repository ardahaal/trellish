class UsersController < Clearance::UsersController
  def create
    super.tap do |block|
      flash[:error] = @user.errors.to_a.join(". ") if @user.errors.any?
    end
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
    end
  end
end
