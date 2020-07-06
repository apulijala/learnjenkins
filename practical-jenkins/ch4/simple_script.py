class PasswordValidator() :
    # Test it is of min 9 characters.
    # Contains atleast special character one special (!$_+@)
    # should return true or fasle.
    
    def check_password(self, password):
        special_chars = "!$_+@"
        if (len(password) >= 9):
            for i in  range(0, len(special_chars)):
                if password.find(special_chars[i]) > 0:
                    return True
            return False
    
        return False
    
    


