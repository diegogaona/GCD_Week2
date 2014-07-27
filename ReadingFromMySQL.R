## Reading from MySQL Lecture
## https://class.coursera.org/getdata-005/lecture/21

# it connects to the genome ucsc genome databases
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); 
# disconnect from database 
dbDisconnect(ucscDb);

# connects directly to a database
hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu");
# list all the tables in the db
allTables <- dbListTables(hg19);
# amount of tables
length(allTables);

# list the fields of the table affyU133Plus2 in the db hg19
dbListFields(hg19,"affyU133Plus2");

# exe a sql query
dbGetQuery(hg19, "select count(*) from affyU133Plus2");

# fetch the information of a table in the variable affyData
affyData <- dbReadTable(hg19, "affyU133Plus2");
# show the header of the table fetched
head(affyData);

# set and perform a query
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3");
affyMis <- fetch(query); 
# find the quantiles of the data fetched 
quantile(affyMis$misMatches);

# used to fetch an small subset, the first 10 rows, dbClearResults clear the query
affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall);

# prevent extra connections
dbDisconnect(hg19);
