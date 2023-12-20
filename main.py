import psycopg2
import pandas as pd
def getConn():
    pwFile = open("pw.txt", "r")
    pw = pwFile.read()
    pwFile.close()
    connStr = "host='cmpstudb-01.cmp.uea.ac.uk' \
               dbname='yvh23wau' user='yvh23wau' password=" + pw
    conn = psycopg2.connect(connStr)
    return conn

def clearOutput():
    with open("femi_data/output.txt", "w") as clearfile:
        clearfile.write('')

def writeOutput(output):
    with open("femi_data/output.txt", "a") as myfile:
        myfile.write(output)

def split_text(task_text):
    raw = task_text.split("#", 1)
    if len(raw) > 1:
        raw[1] = raw[1].strip()
        data = raw[1].split("#")
        return data
    return []

def execute_sql(conn, cur, sql):
    try:
        cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")
        cur.execute(sql)
        writeOutput(cur.statusmessage + "\n \n")
    except Exception as e:
        writeOutput(str(e) + "\n \n")

def write_output(conn, sql):
    try:
        cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")
        table_df = pd.read_sql_query(sql, conn)
        table_str = table_df.to_string()
        writeOutput(table_str + "\n \n")
    except Exception as e:
        writeOutput(str(e) + "\n \n")

def report_total_spectators(conn, cur):
    try:
        cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")
        sql = """
            SELECT e.elocation, e.edate, COUNT(t.tno) as total_spectators
            FROM event e
            LEFT JOIN ticket t ON e.ecode = t.ecode
            GROUP BY e.elocation, e.edate
            ORDER BY e.elocation, e.edate;
        """
        writeOutput("\nTASK F - Report Total Spectators Liable to Travel\n")
        cur.execute(sql)
        table_df = pd.read_sql_query(sql, conn)
        table_str = table_df.to_string()
        writeOutput(table_str + "\n \n")
    except Exception as e:
        writeOutput(str(e) + "\n \n")

conn = None
try:
    conn = getConn()
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")

    f = open("femi_data/input.txt", "r")
    clearOutput()

    for x in f:
        print(x)
        if x[0] == 'A':
            data = split_text(x)
            if data:
                try:
                    sql = "INSERT INTO spectator(sno, sname, semail) VALUES ('{}', '{}', '{}');".format(data[0], data[1], data[2])
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM spectator;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'B':
            data = split_text(x)
            if data:
                try:
                    sql = "INSERT INTO event(ecode, edesc, elocation, edate, etime, emax) VALUES ('{}', '{}', '{}', '{}', '{}', {});".format(data[0], data[1], data[2], data[3], data[4], data[5])
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM event;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'C':
            data = split_text(x)
            if data:
                spectator_id = data[0].strip()
                try:
                    sql = "DELETE FROM spectator WHERE sno = {};".format(spectator_id)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM spectator;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'D':
            data = split_text(x)
            if data:
                event_code = data[0].strip()
                try:
                    sql = "DELETE FROM event WHERE ecode = '{}';".format(event_code)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM event;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'E':
            raw = x.split("#", 1)
            raw[1] = raw[1].strip()
            data = raw[1].split("#")
            try:
                # Write the task name
                writeOutput("TASK " + x[0] + ": Issue a ticket for an event" + "\n")

                # SQL query to show all events before adding new event
                writeOutput("Showing all Tickets for an event held by a particular spectator \n")
                sql = "select * from ticket where ecode='{}' and sno={};".format(data[0], data[1])
                write_output(conn, sql)

                # Insert the new event
                writeOutput("Attempt to issue a ticket if they don't alrady have one \n")
                sql = "INSERT INTO ticket VALUES((SELECT COALESCE(MAX(tno),0) FROM ticket) + 1, '{}', {});".format(
                    data[0], data[1])
                execute_sql(conn, cur, sql)

                # SQL query to show spectaor was successfully added
                writeOutput("Showing all Tickets for an event held by a particular spectator \n")
                sql = "select * from ticket where ecode='{}' and sno={};".format(data[0], data[1])
                write_output(conn, sql)

                # Space
                print("\n\n")
            except Exception as e:
                writeOutput(str(e) + "\n")


        elif x[0] == 'F':
            report_total_spectators(conn, cur)




        elif x[0] == 'G':
            # Placeholder for unspecified action
            try:
                cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")
                sql = "SELECT event.ecode, event.edesc, COUNT(ticket.tno) AS total_tickets " \
                      "FROM event LEFT JOIN ticket ON event.ecode = ticket.ecode " \
                      "GROUP BY event.ecode, event.edesc " \
                      "ORDER BY event.edesc;"
                writeOutput("TASK " + x[0] + "\n")
                write_output(conn, sql)
            except Exception as e:
                writeOutput(str(e) + "\n")


        elif x[0] == 'H':
            data = split_text(x)
            if data:
                event_code = data[0].strip()

                try:
                    sql = "SELECT * FROM ticket WHERE ecode = '{}';".format(event_code)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                    table_df = pd.read_sql_query(sql, conn)
                    table_str = table_df.to_string()
                    writeOutput(table_str + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

        elif x[0] == 'I':
            data = split_text(x)
            if data:
                spectator_id = data[0].strip()

                try:
                    sql = "SELECT * FROM ticket WHERE sno = {};".format(spectator_id)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                    table_df = pd.read_sql_query(sql, conn)
                    table_str = table_df.to_string()
                    writeOutput(table_str + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

        elif x[0] == 'J':
            data = split_text(x)
            if data:
                ticket_id = data[0].strip()

                try:
                    sql = "DELETE FROM ticket WHERE tno = {};".format(ticket_id)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM ticket;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'K':
            data = split_text(x)
            if data:
                event_code = data[0].strip()

                try:
                    sql = "DELETE FROM ticket WHERE ecode = '{}';".format(event_code)
                    writeOutput("TASK " + x[0] + "\n")
                    cur.execute(sql)
                    writeOutput(cur.statusmessage + "\n")
                except Exception as e:
                    writeOutput(str(e) + "\n")

                try:
                    sql = "SELECT * FROM ticket;"
                    write_output(conn, sql)
                except Exception as e:
                    print(e)

        elif x[0] == 'L':
            try:
                cur.execute("SET SEARCH_PATH TO Pieran_game, PUBLIC;")

                # Delete the contents of the event table
                cur.execute("DELETE FROM event;")
                writeOutput("TASK " + x[0] + "\nDeleted contents of the event table.\n")

                # Delete the contents of the spectator table
                cur.execute("DELETE FROM spectator;")
                writeOutput("Deleted contents of the spectator table.\n")

                # Delete the contents of the ticket table (all tickets will be deleted when the event is deleted and will be moved to the cancel table)
                cur.execute("DELETE FROM ticket;")
                writeOutput("Deleted contents of the ticket table.\n")

                # Delete the contents of the cancel table
                cur.execute("DELETE FROM cancel;")
                writeOutput("Deleted contents of the cancel table.\n")

                # Commit the changes
                conn.commit()
            except Exception as e:
                writeOutput(str(e) + "\n")

except Exception as e:
    print(e)
finally:
    if conn is not None:
        conn.close()
