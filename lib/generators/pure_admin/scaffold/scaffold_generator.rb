##
# Generator class for creating simple CRUD views and controllers
class PureAdmin::ScaffoldGenerator < Rails::Generators::NamedBase
  desc 'This generator creates a controller and simple partials for the given model'
  source_root File.expand_path('../templates', __FILE__)
  class_option :quickedits, type: :boolean, default: false,
  desc: 'Includes Quick Edit for the controller'

  def copy_controller
    file_to_copy = options[:quickedits] ? 'models_quickedit_controller.rb' : 'models_controller.rb'
    copy_file file_to_copy, controller_path

    gsub_file(controller_path, /ModelClassNameReadable/, model_class_title)
    gsub_file(controller_path, /ModelClassTitlePlural/, model_class_heading)
    gsub_file(controller_path, /ModelClassNamePlural/, model_class_name_plural)
    gsub_file(controller_path, /ModelClassName/, model_class_name)
    gsub_file(controller_path, /model_instance_collection/, model_instance_collection)
    gsub_file(controller_path, /model_instance_singular/, model_instance_singular)
  end

  def copy_table
    copy_file '_table.html.erb', table_path

    gsub_file(table_path, /model_instance_collection/, model_instance_collection)
    gsub_file(table_path, /model_instance_singular/, model_instance_singular)
  end

  def copy_form
    copy_file '_form.html.erb', form_path
    gsub_file(form_path, /model_instance_singular/, model_instance_singular)
  end

  def copy_show
    copy_file '_show.html.erb', show_path
    gsub_file(show_path, /model_instance_singular/, model_instance_singular)
  end

  private

    def model_instance_collection
      file_name.underscore.pluralize
    end

    def model_instance_singular
      model_instance_collection.singularize
    end

    def model_class_name
      model_instance_collection.singularize.camelize
    end

    def model_class_name_plural
      model_instance_collection.camelize
    end

    def model_class_title
      model_instance_collection.titleize.singularize
    end

    def model_class_heading
      model_instance_collection.titleize.pluralize
    end

    def controller_path
      "app/controllers/#{model_instance_collection}/controller.rb"
    end

    def table_path
      "app/views/#{model_instance_collection}/_table.html.erb"
    end

    def form_path
      "app/views/#{model_instance_collection}/_form.html.erb"
    end

    def show_path
      "app/views/#{model_instance_collection}/_show.html.erb"
    end
end
