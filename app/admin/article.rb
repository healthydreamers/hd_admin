ActiveAdmin.register Article do
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Menu
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  menu parent: 'Content', priority: 0

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # permitted params
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  permit_params :title, :description, :url, :source_host, :slug, :topic_id, :tag_list, :user_id, :is_published, :is_featured

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Form
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  form :html => { :enctype => "multipart/form-data" }, class: 'block' do |f|
    f.inputs "Edit article" do
      f.input :title
      f.input :description
      f.input :url
      f.input :source_host
      f.input :slug
      f.input :image_url
      f.input :tag_list
      f.input :topic
      f.input :user
      f.input :cached_comments_count
      f.input :is_published
      f.input :is_featured
    end
    f.actions
  end

  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # Filter
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  filter :title
  filter :url
  filter :source_host
  filter :slug
  filter :topic
  filter :tags
  filter :user
  filter :cached_comments_count
  filter :is_published
  filter :is_featured
  filter :created_at
  filter :updated_at
  
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#
  # list page
  #~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~/\~~~~~~~~~#

  index do
    selectable_column
    id_column
    column :title
    column :url
    column :source_host
    column :slug
    column :topic
    column :tag_list
    column :cached_comments_count
    column :user
    column :is_published
    column :is_featured
    column :created_at
    column :updated_at
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

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  batch_action :update_status, form: {
    is_published: [['Published',true],['Not published',false]]
    } do |ids, inputs|
      Article.where(id: ids).update_all(is_published: inputs[:is_published])
    redirect_to collection_path, notice: "Status updated successfully"
  end
end
