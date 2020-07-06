class Account: 
    def check_password(self, password):
        return len(password) > 8


if __name__ == "__main__":
    accVerify = Account()
    print("The Password Length is " + str(accVerify.check_password("Dattatreya2!")))