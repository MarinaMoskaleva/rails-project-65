# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    false
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end
end
