# frozen_string_literal: true

class User < ApplicationRecord
  self.per_page = 3

  def name
    [first_name, last_name].join(' ')
  end
end
