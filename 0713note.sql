-- joins and subqueries
# Cardinality relationships between tables
# Primary key, foreign key
# 4 different ways in which the tables are related to each other
  # 1 to 1 relationship
  # 1 to many relationship
  # many to 1 relationship
  # many to many relationship. (can be duplicates)

# when design the database, always think about, what is the kind of cardinality that you'll be maintaining between the table to table.
# Bridge table, e.g user and friendship table

-- joins (the diagram SQL JOINS)
# 1. Inner Join, A & B's common area
# 2. Left Join, A & B's common area + A's unqique area
# 3. Right Join, A & B's common area + B 's unqique area
# 4. Full Outer Join : 'Merge everything' or 'merge everything - common area'

# Cross join (uncommon, unless requested by client)
# Self Join

# Derived table : The scope is at the query level, not real table
# Subquery

# note: order of sql execution. The scope of the execution is only at the query level.
