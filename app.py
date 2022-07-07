from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
from Attendance import attendance


app = Flask(__name__)
app.secret_key = 'many random bytes'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'attendance'

mysql = MySQL(app)

@app.route('/')
def Run():
    return redirect(url_for('Login'))

@app.route("/Login",  methods=["GET","POST"])
def Login():
    if request.method == 'POST':
        username = request.form["username"]
        password = request.form['password']
        con = mysql.connection.cursor()
        con.execute("SELECT * FROM employees WHERE username='"+username+"' and password='"+ password+"'")
        user = con.fetchone()
        con.close()

        if user is None :
            flash("Invalid Username or Password",'error')
            return render_template("registration/login.html")  
        else:
            return redirect(url_for('.Attenadce',empId=user[0],user=user[1]))
    else:
        return render_template("registration/login.html")

@app.route("/Register", methods=["GET","POST"])
def Register():
    if request.method == 'GET':
        return render_template("registration/register.html")
    else:
        username = request.form['username']
        password = request.form['password']
        con = mysql.connection.cursor()
        email = request.form['email']
        con.execute("SELECT * FROM employees WHERE username='"+username+"'")
        userChecker = con.fetchone()

        if userChecker is None :
            con.execute("INSERT INTO employees (username, password,email) VALUES (%s,%s,%s)", (username, password,email))
            mysql.connection.commit()
            con.close()
            flash("Successful Registration")
            return redirect(url_for('Login')) 
        else:
            flash("Username already exists, You must choose another Username!!!",'error')
            return render_template("registration/register.html")

@app.route("/Attenadce/<empId>/<user>", methods=["GET","POST"])
def Attenadce(empId,user):
    empLogData = list(attendance.EmpLog(empId,mysql))
    #print(empLogData)
    checkINCase=False

    if request.method=='GET':
        if not empLogData :
            return render_template("hr/attendance.html",user=user,checkINCase=checkINCase)
        else:
            lastCase=empLogData[0]
            if (lastCase[1] is not None) and (lastCase[2] is None):
                checkINCase=True
                empLogData=empLogData[1:]
            return render_template("hr/attendance.html",empLogData=empLogData,user=user,checkINCase=checkINCase)
    elif request.method=='POST':
        if request.form['check'] == 'checkIn':
            CheckIn(empId=empId)
            checkINCase = True
        elif request.form['check'] == 'checkOut':
            CheckOut(empId=empId)
            checkINCase = False
            empLogData=list(attendance.EmpLog(empId,mysql))
        return render_template("hr/attendance.html",empLogData=empLogData,user=user,checkINCase=checkINCase)
                
def CheckIn(empId):
    attendance.CheckIn(empId,mysql)

def CheckOut(empId):
    attendance.CheckOut(empId,mysql) 
   
if __name__ == "__main__":
    app.run(debug=True)

