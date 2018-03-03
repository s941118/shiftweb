class <%= options[:namespace].camelize %>Controller < ApplicationController
	layout "<%= options[:namespace] %>"
end