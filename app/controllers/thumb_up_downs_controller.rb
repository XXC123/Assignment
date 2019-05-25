class ThumbUpDownsController < ApplicationController
    def new
        begin
            if !current_user
                break
            end
            
            cid = params[:id].to_s
            sql = "select count(*) count from votes where user=" + current_user.id.to_s + " and course=" + cid
            res = ActiveRecord::Base.connection.execute(sql)
            
            if (res.first.fetch("count") > 0)
                flash[:danger] = "Can not vote a course more than once !"
                break
            end

            if params[:type] == "1"
                up
            elsif params[:type] == "2"
                down
            end
            
            Vote.create(user: current_user.id.to_s, course: cid)
            break
        end while true
        redirect_to "/courses"
    end

private
    def up
        sql = "update courses set thumb_ups = thumb_ups + 1 where id=" + params[:id].to_s;
        ActiveRecord::Base.connection.execute(sql)
    end

    def down
        sql = "update courses set thumb_downs = thumb_downs + 1 where id=" + params[:id].to_s;
        ActiveRecord::Base.connection.execute(sql)
    end
end
