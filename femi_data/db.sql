CREATE SCHEMA Pieran_game;
SET SEARCH_PATH TO Pieran_game, PUBLIC;

CREATE TABLE event (
    ecode CHAR(4) PRIMARY KEY,
    edesc VARCHAR(20) NOT NULL,
    elocation VARCHAR(20) NOT NULL,
    edate DATE NOT NULL CHECK (edate >= '2024-07-01' AND edate <= '2024-07-31'),
    etime TIME NOT NULL CHECK (etime >= '09:00:00') ,
    emax SMALLINT CHECK (emax BETWEEN 1 AND 1000)
);

CREATE TABLE spectator (
    sno INTEGER PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    semail VARCHAR(20) NOT NULL
);

CREATE TABLE ticket (
    tno INTEGER PRIMARY KEY,
    ecode CHAR(4) NOT NULL,
    sno INT NOT NULL,
    FOREIGN KEY (ecode) REFERENCES event(ecode) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (sno) REFERENCES spectator(sno) ON DELETE CASCADE ON UPDATE RESTRICT,
    UNIQUE (ecode, sno)
);

CREATE TABLE cancel (
    tno INTEGER NOT NULL,
    ecode CHAR(4) NOT NULL,
    sno INT NOT NULL,
    cdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cuser VARCHAR(255),
    PRIMARY KEY (tno, ecode, sno)

);

-- Insert sample events
-- Insert sample events
-- INSERT INTO event (ecode, edesc, elocation, edate, etime, emax)
-- VALUES
--     ('E001', 'Athletics', 'Stadium A', '2024-07-01', '09:30', 500),
--     ('E002', 'Swimming', 'Aquatic Center', '2024-07-02', '10:00', 300),
--     ('E003', 'Basketball', 'Arena B', '2024-07-03', '11:00', 1000),
--     ('E004', 'Football', 'Field X', '2024-07-04', '12:00', 800),
--     ('E005', 'Tennis', 'Court Y', '2024-07-05', '13:00', 200);

-- -- Insert sample spectators
-- INSERT INTO spectator (sno, sname, semail)
-- VALUES
--     (1, 'John Doe', 'john@example.com'),
--     (2, 'Jane Smith', 'jane@example.com'),
--     (3, 'Bob Johnson', 'bob@example.com'),
--     (4, 'Alice Williams', 'alice@example.com'),
-- 	(5, 'femi Adeyemo', 'femi@example.com');

-- -- Insert sample tickets

-- INSERT INTO ticket VALUES
--     ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'E001',  1);
-- INSERT INTO ticket VALUES
--     ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'E002',  2);
-- INSERT INTO ticket VALUES
--     ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'E003',  3);
-- INSERT INTO ticket VALUES
--     ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'E003',  4);
-- INSERT INTO ticket VALUES
--     ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'E004',  5);

-- inserting the asssessment data
INSERT INTO event VALUES
    ('A100', '100 metres sprint','Stadium 1','2024-07-12','16:00',1000),
    ('AMTH', 'Marathon', 'Stadium 1', '2024-07-12', '18:00', 1000),
    ('A400', '400 metres sprint', 'Stadium 1', '2024-07-12', '10:00', 1000),
    ('ALJP', 'Long Jump', 'Stadium 1', '2024-07-12', '10:00', 1000),
    ('YCHT', 'Yacht Racing', 'Marina', '2024-07-12', '09:00', 200),
    ('WSRF', 'Wind Surfing', 'Marina', '2024-07-12', '12:00', 200),
    ('JUDO', 'Judo', 'Arena 2', '2024-07-12', '10:00', 3),
    ('SWIM', 'Swimming', 'Pool', '2024-07-12', '10:00', 100);



 INSERT INTO spectator VALUES
    (100, 'J. Chin','j.chin@uea.ac.uk'),
    (200, 'W. Wang','whw@somewhere.net'),
    (300, 'P. Mayhew','pwm@gmail.com'),
    (400, 'R. Lapper', 'rl@uea.ac.uk'),
    (500, 'P. Chardaire', 'pc@uea.ac.uk');


INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100', 100);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100', 500);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'ALJP', 100);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'ALJP', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'AMTH', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'AMTH', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'AMTH', 500);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A400', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A400', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'YCHT', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'YCHT', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'YCHT', 500);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'WSRF', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'WSRF', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'JUDO', 100);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'JUDO', 300);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'JUDO', 200);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100', 400);






-- Check the contents of the ticket and cancel tables
SELECT * FROM ticket;
SELECT * FROM cancel;
SELECT * FROM event;
SELECT * FROM spectator;





select * from spectator;
select * from event;
select * from ticket;



-- Foreign Keys:

-- For the ticket table, I added foreign keys with ON DELETE CASCADE for both ecode and sno.
-- This means that if an event or spectator is deleted, the corresponding tickets will also be deleted. This is a cascading effect.



-- solution to the transaction of interest
-- A.Insert a new spectator
INSERT INTO spectator (sno, sname, semail)
VALUES (100, 'F Liza', 'f.liza@uea.ac.uk');
select * from spectator




-- B.Insert a new event
-- INSERT INTO event (ecode, edesc, elocation, edate, etime, emax)
-- VALUES ('A100', '100 metres sprint', 'Stadium 1', '2024-07-12', '16:00', 1000);

-- INSERT INTO event (ecode, edesc, elocation, edate, etime, emax)
-- VALUES ('A400', '400 metres sprint', 'Stadium 1', '2024-07-12', '10:00', 1000);

-- INSERT INTO event (ecode, edesc, elocation, edate, etime, emax)
-- VALUES ( 'A900', '900 metres sprint', 'Stadium 1', '2023-07-12','10:00',  1000);


select * from event;

--C. Function to delete a spectator with cancelled ticket
-- Trigger function to prevent deletion of spectator with valid tickets
CREATE OR REPLACE FUNCTION prevent_spectator_deletion()
RETURNS TRIGGER AS $$
DECLARE
    valid_ticket_count INTEGER;
BEGIN
    -- Check if the spectator has any valid (not cancelled) tickets
    SELECT COUNT(*)
    INTO valid_ticket_count
    FROM ticket
    WHERE sno = OLD.sno AND NOT EXISTS (
        SELECT 1
        FROM cancel
        WHERE cancel.tno = ticket.tno
    );

    -- If there are valid tickets, raise an exception
    IF valid_ticket_count > 0 THEN
        RAISE EXCEPTION 'Cannot delete spectator with valid tickets.';
    END IF;

    -- If no valid tickets, allow the deletion to proceed
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Creating the trigger
CREATE TRIGGER before_deleting_spectator
BEFORE DELETE ON spectator
FOR EACH ROW
EXECUTE FUNCTION prevent_spectator_deletion();


-- This should raise an exception since spectator with sno = 3 has valid tickets
DELETE FROM spectator WHERE sno = 300;
DELETE FROM spectator WHERE sno = 400;
SELECT * FROM spectator;







-- D. Function to delete an event with conditions
-- Function to cancel tickets for a specific event
DROP FUNCTION IF EXISTS cancel_tickets_for_event(character);

CREATE OR REPLACE FUNCTION cancel_tickets_for_event(event_code CHAR(4))
RETURNS VOID AS $$
BEGIN
    -- Insert canceled tickets into the cancel table
    INSERT INTO cancel (tno, ecode, sno, cuser)
    SELECT t.tno, t.ecode, t.sno, current_user
    FROM ticket t
    WHERE t.ecode = event_code;

    -- Delete canceled tickets from the ticket table
    DELETE FROM ticket
    WHERE ecode = event_code;
END;
$$ LANGUAGE plpgsql;

-- Function to delete an event and cancel associated tickets
CREATE OR REPLACE FUNCTION delete_event_and_cancel_tickets()
RETURNS TRIGGER AS $$
BEGIN
    -- Cancel tickets associated with the event being deleted
    PERFORM cancel_tickets_for_event(OLD.ecode);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger to delete an event and cancel associated tickets
CREATE TRIGGER before_delete_event_and_cancel_tickets
BEFORE DELETE ON event
FOR EACH ROW
EXECUTE FUNCTION delete_event_and_cancel_tickets();

DELETE FROM event WHERE ecode = 'A100';

select * from event
select * from ticket

SELECT * FROM cancel where ecode = 'A100';




 -- E.Function to issue a ticket for an event
CREATE OR REPLACE FUNCTION checking_multiple_ticket()
RETURNS TRIGGER AS $$
DECLARE
    counting_ticket INTEGER;
BEGIN
    --check if the spectator has a ticket for the event
    SELECT COUNT(*)
    INTO counting_ticket
    FROM ticket
    WHERE sno = NEW.sno
      AND ecode = NEW.ecode;
    -- if the spectator has a ticket then the insertion should not be done
    IF counting_ticket > 0 THEN
        RAISE EXCEPTION 'Spectator has ticket for that event';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---CREATING TRIGGER
CREATE TRIGGER before_inserting_ticket
BEFORE INSERT ON ticket
FOR EACH ROW
EXECUTE FUNCTION checking_multiple_ticket();

-- testing the trigger
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A100',  100);

INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'JUDO',  400);

INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'AXXX',  100);
INSERT INTO ticket VALUES
    ((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, 'A400',  900);



	select * from ticket;



 --F. Report showing the total number of spectators liable to travel to a location
SELECT
    event.elocation,
    event.edate,
    COUNT(DISTINCT ticket.sno) AS total_spectators
FROM
    event
LEFT JOIN
    ticket ON event.ecode = ticket.ecode
GROUP BY
    event.elocation, event.edate
ORDER BY
    event.elocation, event.edate;

	--G. Produce a report showing the total number of tickets issued for each event.
---Present the data in event description sequence.
----create view here
CREATE VIEW "ticket_report" AS
select count(tno) as total_tickets,e.edesc from event e
left join
ticket t on e.ecode=t.ecode
group by e.edesc
Order by e.edesc;

---to see the report we then select the view
select* from "ticket_report";
--G. Report showing the total number of tickets issued for each event
-- SELECT
--     event.ecode,
--     event.edesc,
--     COUNT(ticket.tno) AS total_tickets
-- FROM
--     event
-- LEFT JOIN
--     ticket ON event.ecode = ticket.ecode
-- GROUP BY
--     event.ecode, event.edesc
-- ORDER BY
--     event.edesc;

-- H. Report showing the total number of tickets issued for a given event
SELECT
    event.ecode,
    event.edesc,
    COUNT(ticket.tno) AS total_tickets
FROM
    event
LEFT JOIN
    ticket ON event.ecode = ticket.ecode
WHERE
    event.ecode = 'A100'
GROUP BY
    event.ecode, event.edesc
ORDER BY
    event.edesc;

-- I Report showing the schedule for a given spectator
SELECT
    spectator.sno,
    spectator.sname,
    event.edate,
    event.elocation,
    event.etime,
    event.edesc
FROM
    spectator
JOIN
    ticket ON spectator.sno = ticket.sno
JOIN
    event ON ticket.ecode = event.ecode
WHERE
    spectator.sno = '200'
ORDER BY
    event.edate, event.etime;

-- J Displaying information for a specific ticket reference number
SELECT
    spectator.sname,
    ticket.ecode,
    CASE
        WHEN cancel.cdate IS NULL THEN 'Valid'
        ELSE 'Cancelled'
    END AS ticket_status
FROM
    ticket
JOIN
    spectator ON ticket.sno = spectator.sno
LEFT JOIN
    cancel ON ticket.tno = cancel.tno AND ticket.ecode = cancel.ecode AND ticket.sno = cancel.sno
WHERE
    ticket.tno = '20';



-- K Create a view for details of cancelled tickets for a specific event
CREATE OR REPLACE VIEW cancelled_tickets_view AS
SELECT
    cancel.tno,
    cancel.ecode,
    cancel.sno,
    spectator.sname,
    cancel.cdate,
    cancel.cuser
FROM
    cancel
JOIN
    spectator ON cancel.sno = spectator.sno
WHERE
    cancel.ecode = 'A100';  -- Replace 'your_event_code' with the desired event code
	select * from cancelled_tickets_view

-- L. Delete the contents of the database tables.

-- Delete the contents of the event table
DELETE FROM event;
select * FROM event;

-- Delete the contents of the spectator table
DELETE FROM spectator;
select * FROM spectator;

-- Delete the contents of the ticket table ( all tickets will be deleted when the event is deleted and will be moved to cancel table )
DELETE FROM ticket;
select * FROM ticket;

-- Delete the contents of the cancel table
DELETE FROM cancel;
select * FROM cancel;
