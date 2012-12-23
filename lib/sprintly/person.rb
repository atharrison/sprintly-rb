# Person
# ======
class Sprintly::Person
  include Sprintly::Model

  # Attributes
  # ----------
  attribute :id
  attribute :first_name
  attribute :last_name
  attribute :email
  attribute :admin?

  def name
    [self.first_name, self.last_name].compact.join(" ")
  end

end