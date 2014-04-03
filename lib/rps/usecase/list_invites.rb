module RPS
  class ListInvites < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:no_session_found) if session.nil?

      user_id = @db.get_user_by_session(inputs[:session_id])
      invites = @db.invites.values.select {|x| !x.mid && (user_id == x.inviter_id || user_id == x.invitee_id)}

      return failure(:no_invites_for_user) if invites.count == 0

      success :invites => invites, :user_id => user_id
    end
  end
end
