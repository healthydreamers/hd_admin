ActiveAdmin.register Comment, :as => "Commentable" do
#ActiveAdmin.register Comment do
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Menu
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  menu parent: 'Content', priority: 0

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # permitted params
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  permit_params :body, :commentable_id, :commentable_type, :user_id
  
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Form
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  form :html => { :enctype => "multipart/form-data" }, class: 'block' do |f|
    f.inputs "Edit article" do
      f.input :body
      f.input :commentable
      f.input :commentable_type
      f.input :user
    end
    f.actions
  end

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Filter
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  filter :body
  filter :commentable_id
  filter :commentable_type
  filter :user
  filter :created_at
  
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # list page
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  index do
    selectable_column
    id_column
    column :body
    column :commentable
    column :commentable_type
    column :user
    column :created_at
    actions
  end

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Scopes
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Detail page
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  # show do
  #   columns do
  #     column do
  #       panel "Campaign owner"  do
  #         div do
  #           link_to campaign.client_user.name, admin_client_user_path(campaign.client_user.id)
  #         end
  #         div do
  #           campaign.client_user.email
  #         end
  #         div do
  #           campaign.profiles.count
  #         end
  #       end
  #     end
  #     column span: 3 do
  #       attributes_table do
  #         row :id
  #         row :name
  #         row :description
  #         row :date_start
  #         row :date_end
  #         # row (:status) { |b| status_tag(b.status_label, b.status_class) }
  #       end
  #     end
  #   end
  #   panel "Drivers" do
  #     if campaign.profiles.count > 0
  #       table_for campaign.profiles do
  #         column(:id) { |profile| link_to profile.id, admin_profile_path(profile.id)  }
  #         column :first_name
  #         column :last_name
  #         column :phone_number
  #         column :city
  #       end
  #     end
  #   end
  # end

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Side bars
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

end
