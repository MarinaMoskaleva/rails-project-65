# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    @record.published? || author? || admin?
  end

  def update?
    author? || admin?
  end

  def edit?
    author?
  end

  def to_moderation?
    author?
  end

  def archive?
    author? || admin?
  end

  def author?
    @record.user == @user
  end
end
