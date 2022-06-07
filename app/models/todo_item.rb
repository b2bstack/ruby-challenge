# frozen_string_literal: true

class TodoItem < ::ApplicationRecord
  scope :with_softdelete, -> { where('deleted_at IS NULL') }
  scope :softdeleted, -> { where('deleted_at IS NOT NULL') }

  scope :with_filters, lambda { |p|
    return if p.blank?

    wheres = {}
    wheres[:is_archived] = p[:is_archived] if p[:is_archived].present?
    wheres[:is_readed] = p[:is_readed] if p[:is_readed].present?
    wheres[:is_executed] = p[:is_executed] if p[:is_executed].present?

    where(wheres)
  }

  scope :search_by_title, lambda { |p|
    return if p[:title].blank?

    where("title ILIKE ?", "%#{sanitize_sql_like(p[:title])}%")
  }
end
