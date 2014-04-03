module RPS
  class CreateInvite < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session.nil?
      invitee = @db.get_user(inputs[:invitee_id])
      return failure(:invitee_not_found) if invitee.nil?
      inviter_id = @db.get_user_from_session(inputs[:session_id])

      invite = @db.create_invite(inviter_id, invitee.id)

      success :invite => invite
    end
  end
end
