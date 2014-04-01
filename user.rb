class User
  attr_accessor :name, :password
  attr_reader :id
  @@counter = 0
  def initialize(name, options={})
    @@counter += 1
    @id = @@counter
    @name = name
    @password = options[:password]
  end

  def set_password(password)
    if @password == nil
      @password = password
    end
  end

end
