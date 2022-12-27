import json
import sqlalchemy
from sqlalchemy.orm import sessionmaker
from models import create_tables, Publisher, Book, Stock, Sale, Shop
import configparser

config = configparser.ConfigParser()
config.read("config.ini")
user = config['DSN']['user']
password = config['DSN']['password']
bd = config['DSN']['basedata']
DSN = f'postgresql://{user}:{password}@localhost:5432/{bd}'


def read_json(file_path):
    with open(file_path, encoding='utf-8') as data_file:
        journal = json.load(data_file)
        # Я сохранял поочередно по таблицам, но позже, увидев код из шпаргалки, удалил свой код, ибо стыдно стало.
        # Мне кажется я до такого бы лаконичного решения сам бы никогда не додумался.((
        for record in journal:
            model = {
                'publisher': Publisher,
                'shop': Shop,
                'book': Book,
                'stock': Stock,
                'sale': Sale,
            }[record.get('model')]
            session.add(model(id=record.get('pk'), **record.get('fields')))
        session.commit()


def name_id(publ_id):
    for c in session.query(Publisher.name).filter(Publisher.id == publ_id).all():
        return c[0]


def books_sales(author):
    print('|                     Title                  |     Shop     |   Price  |  Date Sale   |')
    print('---------------------------------------------------------------------------------------')
    for c in session.query(Publisher, Book.id).join(Book.publisher).filter(Publisher.name == author).all():
        for b in session.query(Book.title, Shop.name, Sale.price, Sale.date_sale).join(Stock.shop)\
                .filter(Stock.id_book == c[1]).join(Book).join(Sale).all():
            print('| ', str(b[0]).ljust(40), ' | ', str(b[1]).ljust(10), ' | ', str(b[2]).rjust(6), ' | ',
                  b[3], ' |')
    print('---------------------------------------------------------------------------------------')


if __name__ == '__main__':
    engine = sqlalchemy.create_engine(DSN)
    create_tables(engine)
    Session = sessionmaker(bind=engine)
    session = Session()
    read_json('fixtures/tests_data.json')
    publisher = input('Введите имя автора или его id: ')
    if publisher.isnumeric():
        publisher = name_id(publisher)
    books_sales(publisher)
    session.close()
