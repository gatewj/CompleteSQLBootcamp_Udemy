/* Assessment Test 2
Section 10, Lecture 58
ASSESSMENT TEST 2 */

/*DataBase: exercises */
/* The exercises database has three tables
bookings
facilities
members
*/


/* COMPLETE THE FOLLOWING TASKS! */

/* 1. How can you retrieve all the information from the cd.facilities table?*/
SELECT *
FROM cd.facilities;


/* 2. You want to print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs?*/
SELECT  name, membercost
FROM cd.facilities;

/* 3. How can you produce a list of facilities that charge a fee to members?*/
SELECT name
FROM cd.facilities
WHERE membercost > 0;


/* 4. How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly
 maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.*/
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE (membercost > 0) AND ((1/50.0)*monthlymaintenance);


/* 5. ow can you produce a list of all facilities with the word 'Tennis' in their name?*/
SELECT name
FROM cd.facilities
WHERE name LIKE '%Tennis%';


/* 6. How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.*/
SELECT *
FROM cd.facilities
WHERE facid IN (1,5);


/* 7. How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members
 in question.*/
SELECT memid, surname, firtsname, joindate
FROM cd.members
WHERE extract(MONTH from joindate) >= 9;


/* 8. How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.*/
SELECT DISTINCT(surname)
FROM cd.members
ORDER BY surname
LIMIT 10

/* 9. You'd like to get the signup date of your last member. How can you retrieve this information? */
SELECT joindate
FROM cd.members
ORDER BY joindate DESC
LIMIT 1;



/* 10. Produce a count of the number of facilities that have a cost to guests of 10 or more. */
SELECT COUNT(*)
FROM cd.facilities
WHERE guestcost >= 10



/* 11. Produce a count of the number of recommendations each member has made. Order by member ID. */
SELECT memid, SUM(recommendby)
FROM cd.members
GROUP BY memid
ORDER BY memid DESC


/* 12. Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and
 slots, sorted by the number of slots. */
SELECT facilities, name, bookings, slots
FROM cd.bookings
INNER JOIN cd.bookings
ON bookings.facid = facilities.facid


/* 13. Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id.
*/
SELECT facid, SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid ASC


/* 14. How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility
 name pairings, ordered by the time.*/
SELECT bks.starttime as start, facs.name as name
FROM cd.facilities facs 
INNER JOIN cd.bookings bks 
ON facs.facid = bks.facid 
WHERE facs.facid IN (0,1) AND 
bks.starttime >= '2012-09-21' AND 
bks.starttime < '2012-09-22'
ORDER BY bks.starttime;


/* 15. How can you produce a list of the start times for bookings by members named 'David Farrell'?*/
SELECT bks.starttime 
FROM cd.bookings bks 
INNER JOIN cd.members mems 
ON mems.memid = bks.memid 
WHERE mems.firstname='David' AND mems.surname='Farrell';