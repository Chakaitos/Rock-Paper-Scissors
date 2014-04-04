module RPS
  class AcceptInvite < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session.nil?

      invite = @db.get_invite(inputs[:invite_id])
      return failure(:invite_not_found) if invite.nil?

      user_id = @db.get_user_by_session(inputs[:session_id])
      return failure(:user_not_invited) if invite.invitee_id != user_id


      user1 = @db.get_user(invite.inviter_id)
      user2 = @db.get_user(invite.invitee_id)
      match = @db.create_match(user1, user2)

      success :match => match
    end
  end
end
