class Precious::Views::Layout
  def partial(name)
    dir =  File.dirname(File.expand_path(__FILE__ + '/../../'))

    file_name = "#{dir}/templates/#{name}.#{template_extension}"
    file_name = "#{template_path}/#{name}.#{template_extension}" unless File.exists?(file_name)

    File.read(file_name)
  end
end
