
# Pre-requisite
  # Need to have json gem installed
    gem install json

# Commands
1. Insert Record
   command:
     ruby no_sql.rb -i <json string>
   Example:
     ruby no_sql.rb -i "{\"_id\":2,\"title\":\"Introduction To C\",\"author\":\"Dennis Ritchie\",\"description\":\" Ruby programming\",\"price\":\"2500\"}"

2. Delete Record(s)
   command:
     ruby no_sql.rb -d <key-value-pair>
   Example:
     ruby no_sql.rb -d "{\"title\":\"Introduction To C\"}"

3. Find record(s) by value     
    command:
      ruby no_sql.rb -f "<value>"
    Example:
      ruby no_sql.rb -f "Dennis Ritchie"

4. Select particular fields while finding a record (Return all fields by default)
    command:
      ruby no_sql.rb -s <key>,<value> <field_1> <field_2>......<field_n>
    Example:
      ruby no_sql.rb -s author,Dennis Ritchie _id price
