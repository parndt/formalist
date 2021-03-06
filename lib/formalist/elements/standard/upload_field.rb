require "formalist/element"
require "formalist/elements"
require "formalist/types"

module Formalist
  class Elements
    class UploadField < Field
      attribute :initial_attributes_url, Types::String
      attribute :presign_url, Types::String
      attribute :presign_options, Types::Hash
      attribute :render_uploaded_as, Types::String
      attribute :upload_prompt, Types::String
      attribute :upload_action_label, Types::String
      attribute :max_file_size, Types::String
      attribute :max_file_size_message, Types::String
      attribute :permitted_file_type_message, Types::String
      attribute :permitted_file_type_regex, Types::String
    end

    register :upload_field, UploadField
  end
end
