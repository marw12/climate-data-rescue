class FieldOption < ApplicationRecord
  include TranslationHelpers

  translates :name, :help,
             fallbacks_for_empty_translations: true,
             touch: true
  globalize_accessors

  has_many :field_options_fields, dependent: :destroy
  has_many :fields, through: :field_options_fields

  has_attached_file :image,
                  styles: { 
                    icon: ["16x16#", :png],
                    med: ["32x32", :png],
                    large: ["100x100#", :png]
                  },
                  default_style: :icon,
                  url: "/system/:class/:style/:hash.:extension",
                  hash_secret: "SECRET"
  validates_attachment :image,
                     content_type: { content_type: ["image/jpg","image/jpeg", "image/png"] }

  validates :name,
            presence: true
  validates :help,
            presence: true

  def self.only_defaults
    where(is_default: true)
  end
end
