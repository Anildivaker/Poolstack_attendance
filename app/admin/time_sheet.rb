ActiveAdmin.register TimeSheet do
	permit_params :admin_user_id, :date, :login_time, :logout_time

	actions :all, except: [:destroy]

	index do
    selectable_column
    column "User", :admin_user
    column :date
    column :login_time do |time_sheet|
    	day = time_sheet&.created_at&.strftime("%A")
    	if (!time_sheet.login_time.present?) && ("Sunday" == day || "Saturday" == day)
    	else
    		time_sheet.login_time&.strftime("%I:%M%p")
    	end
    end
    column :logout_time do |time_sheet|
    	day = time_sheet&.created_at&.strftime("%A")
    	if (!time_sheet.login_time.present?) && ("Sunday" == day || "Saturday" == day)
    		"Holiday"
    	else
    		time_sheet.logout_time&.strftime("%I:%M%p")
    	end
    end
    column :present do |time_sheet|
    	day = time_sheet&.created_at&.strftime("%A")
    	if (!time_sheet.login_time.present?) && ("Sunday" == day || "Saturday" == day)
    	else
    		time_sheet.is_present
    	end
    end
    actions
  end

  show do |time_sheet|
  	attributes_table do 
  		row "User", :admin_user do
  			time_sheet.admin_user
  		end
	    row :date
	    row :login_time do |time_sheet|
	    	time_sheet.login_time.strftime("%I:%M%p")
	    end
	    row :logout_time do |time_sheet|
	    	time_sheet.logout_time.strftime("%I:%M%p")
	    end
	    row :present do |time_sheet|
	    	time_sheet.is_present
	    end
  	end
  end

	collection_action :login, method: :get do
    # Do some CSV importing work here...
    time_sheet = current_active_admin_user.time_sheets.find_or_create_by(date: Date.current)
    time_sheet.update(is_present: true, login_time: Time.current)
    redirect_to collection_path, notice: "Attendence mark successfully!"
  end

  collection_action :logout, method: :get do
    # Do some CSV importing work here...
    time_sheet = current_active_admin_user.time_sheets.find_or_create_by(date: Date.current)
    time_sheet.update(logout_time: Time.current)
    redirect_to collection_path, notice: "Attendence Time out successfully!"
  end

  scope :working, :default => true do |time_sheets|
  	if current_active_admin_user.role == "admin"
	  	time_sheets
	  else
	  	current_active_admin_user.time_sheets
	  end
	end

	action_item only: :index do
		if current_active_admin_user.role == "staff"
			time_sheet = current_active_admin_user.time_sheets.find_by(date: Date.current)
			if time_sheet&.is_present&.present? && time_sheet&.login_time.present? && time_sheet&.logout_time.present?
			else 
				unless time_sheet&.is_present&.present?
		  		link_to 'Time In', login_admin_time_sheets_url
		  	else
		  		link_to 'Time Out', logout_admin_time_sheets_url
		  	end
		  end
	  end
	end

end
