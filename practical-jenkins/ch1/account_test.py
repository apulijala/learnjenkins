import unittest
from account import Account

class AccountTest(unittest.TestCase):
    def setUp(self):
        self.account = Account()


    def test_correct_password(self):
        correct_passwords = ["Dattatreya2!", "LalithaSahsaranam", "Fearofgodbeginningofknwoledge"]

        for password in correct_passwords:
            self.assertTrue(self.account.check_password(password))

    def test_incorrect_password(self):
        incorrect_passwords =  ["Dattat", "abcde", "fguuu"]
        for incorrect_paswd in incorrect_passwords:
            self.assertFalse(self.account.check_password(incorrect_paswd))

if __name__ == "__main__":
    unittest.main()