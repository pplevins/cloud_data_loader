class Person:
    def __init__(self, person_id, first, last):
        self.id = person_id
        self.first_name = first
        self.last_name = last

    def __str__(self):
        """String representation"""
        return (f"Person No. {self.id}\n"
                f"First Name: {self.first_name}\n"
                f"Last Name: {self.last_name}\n")
