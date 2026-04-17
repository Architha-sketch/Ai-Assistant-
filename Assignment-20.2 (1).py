#Generate a simple Python user registration and login script that stores username and password.
users = {}

def register():
    username = input("Enter username: ")
    password = input("Enter password: ")
    users[username] = password

def login():
    username = input("Enter username: ")
    password = input("Enter password: ")
    
    if users.get(username) == password:
        print("Login successful")
    else:
        print("Invalid credentials")

register()
login()