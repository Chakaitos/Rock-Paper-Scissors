class Invite
  attr_accessor :id, :invitee_id, :inviter_id, :status, :mid
  @@counter = 0
    def initialize (inviter_id, invitee_id)
      @@counter += 1
      @id = @@counter
      @inviter_id = inviter_id
      @invitee_id = invitee_id
      @status = "pending"
      @mid = nil
    end
end