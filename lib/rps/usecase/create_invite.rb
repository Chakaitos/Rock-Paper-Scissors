module RPS
  class CreateInvite < UseCase
    def run(inputs)
      @db = RPS.db

      session_key = inputs[:session_id]
      inviter = @db.get_user_by_session(session_key)
      invitee = @db.get_user_by_name(inputs[:invitee_id])
      # binding.pry
      inviter_user = @db.get_user(inviter)


      session = @db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session.nil?

      invitee2 = @db.get_user(invitee)
      if invitee2 == nil && invitee == nil
        return failure(:invitee_not_found)
      end

      invite = @db.create_invite(inviter, invitee.id)

      success(:invite => invite, :invitee => invitee, :inviter => inviter_user)
    end
  end
end
