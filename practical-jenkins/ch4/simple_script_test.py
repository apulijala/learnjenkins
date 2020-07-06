import unittest
from simple_script import PasswordValidator

class TestSimpleScript(unittest.TestCase):

    def setUp(self):
        self.validator = PasswordValidator()

    def test_password_length_correct(self):
        passwords = ["ytttty5tyuiii!", "7897987!@34"]
        
        for passord in passwords:
            self.assertTrue(self.validator.check_password(passord))



    def test_password_length_wrong(self):
        passwords = ["ytt", "789"]
        for passord in passwords:
            self.assertFalse(self.validator.check_password(passord))

    def test_special_chars_right(self):
        pass
       

    def test_special_chars_wrong(self):
        passwords = ["89890890uuuuu", "jkljkljkljlj"]
        for passord in passwords:
            self.assertFalse(self.validator.check_password(passord))



if __name__ == "__main__":
    unittest.main()
    
