# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    @record.published? || author? || admin?
  end

  def update?
    author?
  end

  def edit?
    author?
  end

  def to_moderation?
    author?
  end

  def archive?
    author?
  end

  private

  def author?
    @record.user == @user
  end

  def admin?
    @user.admin?
  end
end
