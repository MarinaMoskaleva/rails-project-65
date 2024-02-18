# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    @record.published? || author? || admin?
  end

  def create?
    @user
  end

  def new?
    create?
  end

  def update?
    author? || admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  def to_moderation?
    author?
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  def archive?
    author? || admin?
  end

  def author?
    @record.user == @user
  end
end
