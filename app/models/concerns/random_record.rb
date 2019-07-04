module RandomRecord
  extend ActiveSupport::Concern

  included do
    def self.random
      offset = rand(self.count)
      self.offset(offset).first
    end
  end
end
