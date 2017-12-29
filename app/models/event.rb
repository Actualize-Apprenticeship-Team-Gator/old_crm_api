class Event < ApplicationRecord
  belongs_to :lead, touch: :updated_at
end
