from datetime import datetime ,timedelta


def EmpLog(id,mysql):
    con = mysql.connection.cursor()
    con.execute("""SELECT at.id, at.checkIn, at.checkOut, at.late, at.early, at.overtime, emp.id, emp.username
                    FROM attendances as at LEFT JOIN employees as emp
                    ON at.empId=emp.id
                    WHERE at.empId=%s
                    ORDER BY checkIn DESC;""",id)
    empLogData = con.fetchall()
    con.close()
    return empLogData

def CheckIn(id,mysql):
    now=datetime.now()
    checkIn=now
    startTime =timedelta(hours = 9)

    lateAsMinute=0
    if now.hour>9:
        lateH=(now-startTime).hour
        lateM=(now-startTime).minute
        lateAsMinute=lateH*60+lateM

    overtime=0
    if now.hour<9:
        overtimeH=(startTime-now).hour
        overtimeM=(startTime-now).minute
        overtimeAsMinute=overtimeH*60+overtimeM
        overtime =overtimeAsMinute
    
    con = mysql.connection.cursor()
    con.execute("INSERT INTO attendances (checkIn,late,overtime,empID) VALUES (%s,%s,%s,%s) "
                ,(checkIn,lateAsMinute,overtime,id))
    mysql.connection.commit()
    con.close()

def CheckOut(id,mysql):
    now=datetime.now()
    checkOut=now

    earlyAsMinute=0
    if now.hour<17:
        EndTime =timedelta(hours = 17)
        earlyH=(EndTime-now).hour
        earlyM=(EndTime-now).minute
        earlyAsMinute=earlyH*60+earlyM

    overtime=0
    if now.hour>17:
        EndTime =timedelta(hours = 17)
        overtimeH=(now-EndTime).hour
        overtimeM=(now-EndTime).minute
        overtimeAsMinute=overtimeH*60+overtimeM
        overtime =overtimeAsMinute
    
    con = mysql.connection.cursor()
    con.execute("""UPDATE attendances
                   SET checkOut=%s, early=%s, overtime=%s
                   WHERE empID=%s 
                   ORDER BY checkIn DESC
                   LIMIT 1"""
                ,(checkOut,earlyAsMinute,overtime,id))
    mysql.connection.commit()
    con.close()
