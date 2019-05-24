class Course < ApplicationRecord
    mount_uploader :img_name, PictureUploader
    validate     :picture_size
    
    def picture_size
        if img_name.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end
end
