class BoardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.projects.include?(record.project)
  end
end
