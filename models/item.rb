# Table: items
# Columns:
#  id      | bigint | PRIMARY KEY DEFAULT nextval('items_id_seq'::regclass)
#  name    | text   | NOT NULL
#  damage  | text   |
#  healing | text   |
# Indexes:
#  items_pkey | PRIMARY KEY btree (id)

require 'sequel'
require_relative '../config/init/configure_sequel'

class Item < Sequel::Model
end
