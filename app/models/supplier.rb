class Supplier < ApplicationRecord
  SUPPLIERS_PARAMS = %i(name taxNum address sup_type).freeze
  VALID_TAX_NUMBER_REGEX = Settings.validations.supplier.tax_regex

  enum sup_type: {personal: true, organization: false}

  belongs_to :user

  has_many :incomes, dependent: :destroy

  delegate :name, to: :user, prefix: true

  validates :name, presence: true,
                   uniqueness: {case_sensitive: false}
  validates :taxNum, presence: true,
                     format: {with: VALID_TAX_NUMBER_REGEX, message: I18n.t("accountant.suppliers.message_err")},
                     uniqueness: {case_sensitive: false}
  validates :address, presence: true
  validates :sup_type, presence: true, inclusion: {in: sup_types.keys}

  scope :own_supplier, ->(user_id){where user_id: user_id}
  scope :sort_by_name, ->{order name: :asc}
  scope :sort_by_created_at, ->{order created_at: :desc}
end
