class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.projects.include?(record.board.project)
  end

  def show?
    user.projects.include?(record.board.project)
  end

  def update?
    user.projects.include?(record.board.project)
  end

  def destroy?
   user.projects.include?(record.board.project)
  end
end
