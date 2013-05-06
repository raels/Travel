
# When using the datepicker on a datetime instead of a date, the LTE datetime is set to YYYY-MM-DD 00:00:00.000000
# which means that it is not actually inclusive of any time on that date.  Add a capability to set a time part



module ActiveAdmin
  module Inputs
    class FilterDateRangeInput

      def to_html
        input_wrapping do
          [ label_html,
            builder.text_field(gt_input_name, input_html_options(gt_input_name)),
            template.content_tag(:span, "-", :class => "seperator"),
            builder.text_field(lt_input_name, input_html_options(lt_input_name, ' datepickerlte')),
          ].join("\n").html_safe
        end
      end

      def input_html_options(input_name = gt_input_name, extra_class = '')
        current_value = @object.send(input_name)
        { :size => 12,
          :class => "datepicker" + extra_class,
          :max => 10,
          :value => current_value.respond_to?(:strftime) ? current_value.strftime("%Y-%m-%d") : "" }
      end
    end
  end
end


if false
	module ActiveAdmin
	  module Inputs
	    class FilterDateRangeInput < ::Formtastic::Inputs::StringInput
	      include FilterBase

	      def to_html
	        input_wrapping do
	          [ label_html,
	            builder.text_field(gt_input_name, input_html_options(gt_input_name)),
	            template.content_tag(:span, "-", :class => "seperator"),
	            builder.text_field(lt_input_name, input_html_options(lt_input_name, ' datepickerlte')),
	          ].join("\n").html_safe
	        end
	      end

	      def gt_input_name
	        "#{method}_gte"
	      end
	      alias :input_name :gt_input_name

	      def lt_input_name
	        "#{method}_lte"
	      end

	      def input_html_options(input_name = gt_input_name, extra_class = '')
	        current_value = @object.send(input_name)
	        { :size => 12,
	          :class => "datepicker" + extra_class,
	          :max => 10,
	          :value => current_value.respond_to?(:strftime) ? current_value.strftime("%Y-%m-%d") : "" }
	      end
	    end
	  end
	end
end
