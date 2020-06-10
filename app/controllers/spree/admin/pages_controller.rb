module Spree
  module Admin
    class PagesController < ResourceController

      def update
        format_translations if defined? SpreeGlobalize
        super
      end

      #def translate
      #  page = Spree::Page.find(params[:id])
      #  page.update update_page_attribute
      #  redirect_to spree.admin_pages_path
      #end

      private
      def update_page_attribute
        params.require(:page).permit(permitted_params)
      end

      def permitted_params
        [:translations_attributes => [:title, :body, :slug, :layout, :foreign_link, :meta_keywords, :meta_title, :meta_description]]
      end

      def format_translations
        return if params[:page][:translations_attributes].nil?
        params[:page][:translations_attributes].each do |_, data|
          translation = @vendor.translations.find_or_create_by(locale: data[:locale])
          translation.title = data[:title]
          translation.body = data[:body]
          translation.slug = data[:slug]
          translation.layout = data[:layout]
          translation.foreign_link = data[:foreign_link]
          translation.meta_keywords = data[:meta_keywords]
          translation.meta_title = data[:meta_title]
          translation.meta_dscription = data[:meta_description]
          translation.save!
        end
      end

    end
  end
end
