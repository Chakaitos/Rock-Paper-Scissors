module RPS
  class AcceptInvite < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session.nil?

      invite = @db.get_invite(inputs[:invite_id])
      return failure(:invite_not_found) if invite.nil?

      user_id = @db.get_user_from_session(inputs[:session_id])
      return failure(:user_not_invited) if invite.invitee_id != user_id

      match = @db.create_match(invite.inviter_id, invite.invitee_id)

      success :match => match
    end
  end
end
