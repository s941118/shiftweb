class Admin::UserPolicy < AdminPolicy
  def update?
    user.present?# && user == record
    # 因為沒有 admin, 先設定為大家可以互相修改
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end