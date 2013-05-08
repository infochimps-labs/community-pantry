module Ironfan
  module Collectd
    def collectd_key(key)
      case key
      when Symbol then key.to_s.split('_').map(&:capitalize).join
      else key.to_s
      end
    end

    def collectd_value(value)
      case value
      when Numeric, TrueClass, FalseClass then value
      else "\"#{value.to_s}\""
      end
    end

    def collectd_section(type, value=nil, &blk)
      section = []
      section << "<#{collectd_key(type)}#{value.nil? ? '' : ' ' + collectd_value(value)}>"
      section << blk.call.split("\n").map{|line| "  " + line }.join("\n")
      section << "</#{collectd_key(type)}>"

      section.join("\n")
    end

    def collectd_settings(options={})
      settings = []
      options.each_pair do |key, value|
        case value
        when Array
          settings << [collectd_key(key), value.map{|val| collectd_value(val) }].join(' ')
        when Hash
          settings << collectd_section(*key){ collectd_settings(value) }
        else
          settings << "#{collectd_key(key)} #{collectd_value(value)}"
        end
      end
      settings.join("\n")
    end
  end
end