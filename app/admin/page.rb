ActiveAdmin.register Page do
  permit_params :title, :introduction, :published, :publish_on, :body, :meta_title, :meta_keywords, :meta_description
end
