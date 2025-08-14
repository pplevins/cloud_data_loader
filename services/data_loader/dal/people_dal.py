import mysql.connector

from services.data_loader.model import Person


class PeopleDAL:
    """Class to represent person's Data Layer, and implementing CRUD operations for people."""

    def __init__(self, conn_str=None):
        """Constructor"""
        self.conn_str = conn_str or {
            'host': '10.128.13.30',
            'user': 'root',
            'password': '1234',
            'port': 3306,
            'database': 'peopleDB'
        }

    def connect(self):
        """Connect to database."""
        return mysql.connector.connect(**self.conn_str)

    def get_all_agents(self):
        """Get all people from the database."""
        people = []
        with self.connect() as conn:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM data")
            for row in cursor:
                people.append(Person(
                    person_id=row['id'],
                    first=row['codeName'],
                    last=row['realName']
                ))
        return people
