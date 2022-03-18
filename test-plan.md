### DDL
**Drop any existing assessment databases from previous code reviews**
* [ ] Run the DDL script
* [ ] Does the script create the database?
* [ ] Does the script create all of the tables?
* [ ] Does the script create all of the table relationships?
_If it helps, use Workbench to reverse engineer a database model diagram to review the table relationships_
* [ ] Re-run the DDL script
* [ ] Does the script drop database if it exists?
### DML
**If the DML script doesn't contain the create and insert statements for the provided denormalized data, then use Workbench to import the provided CSV file**
* [ ] Run the DML script
* [ ] Are the normalized tables populated from the provided denormalized data?
* [ ] Are the required updates completed?
* [ ] Are the required deletes completed?
### DQL
**Run each of the queries within the DQL script and confirm the below results**
* [ ] Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021) (Tell Me What To Think, Stop. Just Stop., Hair)
* [ ] List customers without duplication (73 rows)
* [ ] Find all customers without a .com email address (32 rows)
* [ ] Find the three cheapest shows (Hair 14.75, The Dress 14.85, Send in the Clowns 15.00)
* [ ] List customers and the show they're attending with no duplication (72 rows)
* [ ] List customer, show, theater, and seat number in one query (183 rows)
* [ ] Find customers without an address (9 rows)
* [ ] Recreate the spreadsheet data with a single query (183 rows)
* [ ] Count total tickets purchased per customer (64 rows)
 
* [ ] Calculate the total revenue per show based on tickets sold
```
show_name, revenue
Caddyshack, 198.25
Stop. Just Stop., 208.20
Dance Dance Vertical, 208.45
Hair, 221.25
The Dress, 237.60
Tell Me What To Think, 390.00
The Sky Lit Up, 507.00
Send in the Clowns, 570.00
Burr, 645.00
```
* [ ] Calculate the total revenue per theater based on tickets sold
```
theater, total
Little Fitz, 923.65
Horizon, 1064.50
10 Pin, 1197.60
```
* [ ] Who is the biggest supporter of RCTTC? Who spent the most in 2021?
```
customer, total_cost
Jammie Swindles, 220.80
```