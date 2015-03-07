class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    user.projects.include?(record)
  end

  def update?
    user.projects.include?(record)
  end

  def destroy?
   user.projects.include?(record)
  end
end