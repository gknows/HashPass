#! /usr/bin/env python
"""HashPass module
Python version: 2.7
Feedback: gknows.github.io
Update: 2016-05-26
"""
import hashlib

"""Class HashPass
"""
class HashPass():
    def __init__(self):
        self.personal_key = "example"
        self.hash_type = "md5"
        self.hash_times = 1
        self.password_length = 12
        self.mixed_case = True

    def __dir__(self):
        return ['GetPassword']

    def _hexdigest_hash(self, key):
        result = ""
        if self.hash_type == "md5":
            result = hashlib.md5(key).hexdigest()
        elif self.hash_type == "sha1":
            result = hashlib.sha1(key).hexdigest()
        elif self.hash_type == "sha224":
            result = hashlib.sha224(key).hexdigest()
        elif self.hash_type == "sha256":
            result = hashlib.sha256(key).hexdigest()
        elif self.hash_type == "sha384":
            result = hashlib.sha384(key).hexdigest()
        elif self.hash_type == "sha512":
            result = hashlib.sha512(key).hexdigest()
        return result

    def _hash_once(self, key):
        """hash once with mixed_case config
        """
        result = self._hexdigest_hash(key)
        if self.mixed_case == False:
            return result;
        result_upper = result.upper()
        result_lower = result.lower()
        length = len(result)/2
        result = ""
        for i in range(length):
          if i%2 == 0:
            result += result_upper[i*2:(i+1)*2]
          else:
            result += result_lower[i*2:(i+1)*2]
        return result

    def GetPassword(self):
        """calc the password
        """
        account_key = raw_input('Account Key: ').lower()
        key = self.personal_key + account_key
        if self.hash_times <= 0:
            self.hash_times = 1
        result = key
        for i in range(self.hash_times):
            result = self._hash_once(result)
        return result[0:self.password_length]

"""end
"""

if __name__ == '__main__':
    h = HashPass()
    h.hash_type = "md5" #support: "md5","sha1","sha224","sha256","sha384","sha512"
    h.personal_key = "example"
    h.hash_times = 1
    h.mixed_case = True #support: True, False
    h.password_length = 12
    print h.GetPassword()
