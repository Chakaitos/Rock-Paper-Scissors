module RPS
  class CreateInvite < UseCase
    def run(inputs)
      session_key = inputs[:session_key]
      inviter = RPS.db.get_user_by_session(session_key)
      invitee = RPS.db.get_user(inputs[:invitee_id])

      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session.nil?

      invitee = @db.get_user(inputs[:invitee_id])
      return failure(:invitee_not_found) if invitee.nil?

      invite = @db.create_invite(inviter.id, invitee.id)

      success( :invite => invite, :invitee => invitee )
    end
  end
end
