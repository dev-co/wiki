class Mustache
  def self.template_override
    dir =  File.dirname(File.expand_path(__FILE__ + '/../../'))

    file_name = "#{dir}/templates/#{template_name}.#{template_extension}"
    file_name = "#{path}/#{template_name}.#{template_extension}" unless File.exists?(file_name)
    file_name 
  end

  def self.template_file
    @template_file || self.template_override
  end
end
