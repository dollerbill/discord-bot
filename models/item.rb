# Table: items
# Columns:
#  name    | integer | PRIMARY KEY DEFAULT nextval('items_name_seq'::regclass)
#  damage  | text    |
#  healing | text    |
# Indexes:
#  items_pkey | PRIMARY KEY btree (name)

require 'sequel'
require_relative '../config/init/configure_sequel'

class Item < Sequel::Model

end
