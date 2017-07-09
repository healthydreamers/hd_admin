ActiveAdmin.register User do
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Menu
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  menu parent: 'Profiles', priority: 0

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # permitted params
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Form
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  form :html => { :enctype => "multipart/form-data" }, class: 'block' do |f|
    f.inputs "Edit user details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Filter
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at
  filter :last_sign_in_at
  filter :sign_in_count

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # list page
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    column :sign_in_count
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
