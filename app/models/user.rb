class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, presence: true

  validate :create_email

  private

  def create_email
    return if email.blank?

    email_aux = email.split('@')
    return unless email_aux.last != 'smartflix.com.br'

    errors.add(:email, '. Cadastro permitido somente para colaborador Smartflix')
  end
end
