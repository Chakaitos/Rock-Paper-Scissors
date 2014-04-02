class Session

attr_accessor :id
@@counter = 0
  def initialize (user_id)
    @@counter+=1
    @id = @@counter
    @user_id = user_id
  end
end