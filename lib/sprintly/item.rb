class Sprintly::Item
  include Sprintly::Model

  def self.payload_identity(payload)
    [payload["product"]["id"], payload["number"]]
  end


  # Attributes
  # ----------
  ### Identity
  attribute :number,               read_only: true
  attribute :product,    :Product, read_only: true
  attribute :created_by, :Person,  read_only: true

  ### Content
  attribute :who
  attribute :what
  attribute :why
  attribute :title
  attribute :description

  ### Statuses
  attribute :type,        :Symbol
  attribute :status,      :Symbol
  attribute :archived?,   :Symbol
  attribute :assigned_to, :Person
  attribute :score,       :Symbol

  ### Metadata
  attribute :tags,                 read_only: true
  attribute :short_url,            read_only: true
  attribute :created_at,    :Time, read_only: true
  attribute :last_modified, :Time, read_only: true

  # An email address for a particular portion of the item.
  #
  # Known options:
  # `files`:      Email attachments to the item to this address.
  # `discussion`: Email additional comments to this address.
  def email_for(task)
    @email[task.to_s] if @email
  end


  # Relationships
  # -------------
  def children
    client.api.get_child_items(self.product.id, self.number).map { |payload|
      client.model(:Item, payload)
    }
  end

end
