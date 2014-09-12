class Gallery < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :token
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  mount_uploader :cover, ImageUploader

  has_many :pictures, :dependent => :destroy

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Gallery.where(token: random_token).exists?
    end
  end

end
