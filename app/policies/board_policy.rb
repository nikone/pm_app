class BoardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def completed_tasks?
    user.projects.include?(record.project)
  end

  def create?
    user.projects.include?(record.project)
  end
end
