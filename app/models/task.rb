# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, :status, presence: true

  enum status: { read: 0, executed: 1, archived: 2 }
end
