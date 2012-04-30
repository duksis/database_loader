$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'active_support/core_ext'

require 'database_loader/sql_statement'
require 'database_loader/sql_file'
