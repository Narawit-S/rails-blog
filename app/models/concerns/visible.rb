module Visible 
    extend ActiveSupport::Concern

    VALID_STATUS = %w[published privated archived].freeze
    
    included do
        validates :status, inclusion: { in: VALID_STATUS }
    end

    class_methods do
        def public_count
            where(status: 'published').count
        end
    end

    def archived?
        status == 'archived'
    end
end
