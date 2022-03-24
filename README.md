
# Tiny Theaters Assessment
<!-- set sql_safe_updates = 0; -->

## Tasks

_TODO_ Add time estimates to each of the top-level tasks

* [X] Create a new GitHub repo for this assessment (#.# hours)
  * [X] Update the README with the contents from this file
  * [X] Add the instruction team as collaborators

* [X] Review the requirements (#.# hours)

* [X] Download the provided data (#.# hours)

* [X] Review the provided data (#.# hours)

* [X] Identify any research that I need to do (#.# hours)

---

_These steps can be done in class on Friday_

* [X] Design initial database schema (#.# hours)
  * [X] Identify the tables that are needed
  * [X] For each table...
    * Define a primary key
    * Define its columns (name, data type, and nullability)
  * [X] Identify the relationships between tables
    * Define any foreign keys
  * [X] Identify any default or unique constraints

* [X] Draw a diagram of the database schema (#.# hours)
  * [X] Share with one or more classmates for feedback
  * [X] Update database schema as needed
  * [X] Share updated diagram with one or more classmates
  * [X] Update database schema as needed
  * [X] Share with assigned code reviewer for feedback

_Acceptable diagram formats_

* Diagrams.net (https://app.diagrams.net/) (saved as a PDF)
* Google Drawing (saved as a PDF)
* Really any other diagramming tool (saved as an image or PDF)
* Hand-written (must be well-organized and legible!!)

**Make sure that my GitHub repo is updated!**

---

_These steps can be done in class on Friday or over the weekend_

* [X] Write the DDL in a file named `rcttc-schema.sql` to create the database (#.# hours)
  * [X] Drop and create the database
  * [X] Create all of the tables

* [X] Import the provided data (#.# hours)
  * [X] Import the csv file using Workbench _or_
  * [X] Run the provided SQL script

* [X] Write the DML in a file named `rcttc-data.sql` to populate the database tables (#.# hours)
  * [X] Write insert-from-select statements to move the data from the denormalized table to the normalized tables

**Make sure that my GitHub repo is updated!**

---

_These steps will be completed over the weekend_

* [X] Write the DML to make the necessary data updates (as outlined below) (#.# hours)

* [X] Write the required queries (as outlined below) in a file named `rcttc-queries.sql` (#.# hours)

**Make frequent commits to my GitHub repo!**

---

## High Level Requirements

- Use RCTTC's data to design a multi-table schema with appropriate relationships.
- Build a SQL DDL script to create the schema.
- Populate the database with sample data from a delimited data file. Save the DML SQL so it can be executed whenever needed.
- Write report queries and confirm they're working with sample data.

## The Theaters

The **Little Fitz** was previously a storage room in the historic Fitzgerald Theater. It has three rows of four seats for a total of 12 seats.

The **10 Pin** is a cozy little spot tucked behind the lanes of a hipster bowling alley. It's a little noisy, but the atmosphere is one-of-a-kind. It has five rows of five seats for a total of 25 seats.

The **Horizon** is a rain-or-shine, summer-to-winter backyard theater hosted by the Thao family. It has two rows of eight seats for a total of 16 seats.

## The Performances

The 2021 schedule:

- High School Musical
- Hair
- Dance, Dance Vertical: dance performed on a vertical surface using climbing equipment.
- Caddyshack
- Burr: the real dirt on Alexander Hamilton
- Send in the Clowns
- The Dress
- Tell Me What To Think
- The Sky Lit Up: cosmic horror
- Ocean: the life of Frank Ocean as performed by Frank Ocean
- Stop. Just Stop.
- Wen

## Data

Download the full RCTTC comma-delimited data from the LMS.

## Approach

### Step 1: DDL

Save all DDL in a file named `rcttc-schema.sql`;

* The delimited data is denormalized (i.e. it's a single table)
* Analyze the data
* Decide which values belong to an independent concept
* Decide how concepts are related
* Draw a diagram
* Finalize names, keys, and data types
* Column names in the data file shouldn't necessarily be used as-is
* Likely will need to add columns including, but not limited to, surrogate keys
* The DDL script should be able to be executed over and over

### Step 2: DML

Save all DML in a file named `rcttc-data.sql`.

#### Inserts

* Insert the delimited data into the database
* Use MySQL Workbench's *Table Data Import Wizard* to import all data into a denormalized table
* Use SQL to populate the normalized schema
* Drop the denormalized table after the data has been populated into the normalized tables
* Scan the data carefully
* Repeated data shouldn't be repeated in a normalized database

#### Updates

- The Little Fitz's 2021-03-01 performance of *The Sky Lit Up* is listed with a $20 ticket price. The actual price is $22.25 because of a visiting celebrity actor. (Customers were notified.) Update the ticket price for that performance only.
- In the Little Fitz's 2021-03-01 performance of *The Sky Lit Up*, Pooh Bedburrow and Cullen Guirau seat reservations aren't in the same row. Adjust seating so all groups are seated together in a row. This may require updates to all reservations for that performance. Confirm that no seat is double-booked and that everyone who has a ticket is as close to their original seat as possible.
- Update Jammie Swindles's phone number from "801-514-8648" to "1-801-EAT-CAKE".

#### Deletes

- Delete *all* single-ticket reservations at the 10 Pin. (You don't have to do it with one query.)
- Delete the customer Liv Egle of Germany. It appears their reservations were an elaborate joke.

### Step 3: DQL (Data Query Language)

Save all DQL in a file named `rcttc-queries.sql`.

Complete the following queries.

- Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021).
- List customers without duplication.
- Find all customers without a `.com` email address.
- Find the three cheapest shows.
- List customers and the show they're attending with no duplication.
- List customer, show, theater, and seat number in one query.
- Find customers without an address.
- Recreate the spreadsheet data with a single query.
- Count total tickets purchased per customer.
- Calculate the total revenue per show based on tickets sold.
- Calculate the total revenue per theater based on tickets sold.
- Who is the biggest supporter of RCTTC? Who spent the most in 2021?

## Deliverables

- Database diagram
- `rcttc-schema.sql`: re-runnable DDL
- `rcttc-data.sql`: data populating DML
- `rcttc-queries.sql`: queries