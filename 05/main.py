import psycopg2

conn = psycopg2.connect(database='clients', user='postgres', password='3450')


class Clients:

    def __init__(self):
        self.name = ''
        self.surname = ''
        self.email = ''
        self.phone = ''


    def create_db(self):
        with conn.cursor() as cur:
            cur.execute("""DROP TABLE phone, client;""")
            cur.execute("""
                        CREATE TABLE IF NOT EXISTS client(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(40) NOT NULL,
                        surname VARCHAR(40) NOT NULL,
                        email VARCHAR(40)  NOT NULL UNIQUE);
                        """)
            cur.execute("""
                        CREATE TABLE IF NOT EXISTS phone(
                        id_phone SERIAL PRIMARY KEY,
                        number VARCHAR(20),
                        id_client INTEGER NOT NULL REFERENCES client(id));
                        """)
            conn.commit()
            print('База данных успешно создана')
            # cur.execute("""
            #             SELECT * FROM client;
            #             """)

    def create_client(self):
        self.name = input('Введите имя: ')
        self.surname = input('Введите фамилию: ')
        self.email = input('Введите e-mail: ')
        with conn.cursor() as cur:
            cur.execute("""
                        INSERT INTO 
                            client(name, surname, email) 
                        VALUES
                            (%s, %s, %s);
                        """, (self.name, self.surname, self.email))
            conn.commit()
            print('Новый клиент успешно создан')
            cur.execute("""
                        SELECT * FROM client
                        ORDER BY id DESC LIMIT 1;
                        """)
            client = cur.fetchone()
            phone = self._phone(client)
            self._table_header()
            self._table_body(client, phone)
            input('Нажмите Enter для возвращения в меню...')

    def create_phone(self):
        id = input('Введите id клиента которому нужно добавить номер телефона: ')
        with conn.cursor() as cur:
            cur.execute("""
                        SELECT * FROM client
                        WHERE id = %s;
                        """, (id,))
            search_id = cur.fetchone()
            if search_id:
                phone = input('Введите номер телефона: ')
                # with conn.cursor() as cur:
                cur.execute("""
                            INSERT INTO
                                phone(number, id_client) 
                            VALUES
                                (%s, %s);
                            """, (phone, id))
                print('Номер успешно добавлен')
                conn.commit()
            else:
                print('Клиента с  таким id не существует')
            input('Нажмите Enter для возвращения в меню...')

    def change_data(self):
        with conn.cursor() as cur:
            client_id = input('Введите id клиента у которого нужно нужно изменить данные: ')
            cur.execute("""
                        SELECT * FROM client
                        WHERE id =%s;
                        """, (client_id,))
            client_info = cur.fetchone()
            if client_id is None:
                print('Клиент с данным id не найден')
                input('Нажмите Enter для возвращения в меню...')
                return
            else:
                phone = self._phone(client_info)
                self._table_header()
                self._table_body(client_info, phone)
                name = input('Введите новое имя: ')
                surname = input('Введите новую фамилию: ')
                email = input('Введите новый e-mail: ')
                cur.execute("""
                            UPDATE client
                            SET name=%s, surname=%s, email=%s
                            WHERE id =%s;                            ;
                            """, (name, surname, email, client_id))
                cur.execute("""
                            UPDATE phone
                            SET number=%s
                            WHERE id_client=%s;
                """, (phone, client_id))
                conn.commit()
                print('Данные обновлены:')
                with conn.cursor() as cur:
                    cur.execute("""
                                SELECT * FROM client
                                WHERE id=%s;
                                """, (client_id,))
                    client = cur.fetchone()
                    phone = self._phone(client)
                    self._table_header()
                    self._table_body(client, phone)
                input('Нажмите Enter для возврата в меню...')

    def del_phone(self):
        with conn.cursor() as cur:
            client_id = int(input('Введите id клиента у которого нужно удалить номер телефона: '))
            cur.execute("""
                        SELECT * FROM phone
                        WHERE id_client =%s;
                        """, (client_id,))
            clients_phone = cur.fetchall()
            if clients_phone != []:
                print(f'По данному клиенту имеется следующие номера:')
                for client_phone in clients_phone:
                    print(f'id = {client_phone[0]} номер телефона = {client_phone[1]}')
                id = int(input('Введите id удаляемого номера телефона: '))
                cur.execute("""
                            DELETE FROM phone 
                            WHERE id_phone=%s;
                            """, (id,))
                if id == clients_phone[0][0]:
                    print(f'Номер с id = {id} удален')
                    conn.commit()
                else:
                    print('Нет номера телефона с таким id')
            else:
                print('У данного клиента нет телефона либо неверно указан id')
            input('Нажмите Enter для возвращения в меню...')

    def search_client(self):
        with conn.cursor() as cur:
            client_name = input('Введите имя клиента: ')
            cur.execute("""
                        SELECT * FROM client 
                        WHERE name=%s;
                        """, (client_name,))
            client = cur.fetchone()
            if client is None:
                print(f'Пользователь {client_name} не найден')
                return
            phone = self._phone(client)
            self._table_header()
            self._table_body(client, phone)
        input('Нажмите Enter для возвращения в меню...')

    def _table_header(self):
        print(
            '|  id  |          name          |          surname        |             email           |     main phone  |')
        print(
            '-----------------------------------------------------------------------------------------------------------')

    def _table_body(self, info_client, phone):
        print(str(info_client[0]).rjust(5), info_client[1].rjust(25), info_client[2].rjust(25),
              info_client[3].rjust(30), phone[1].rjust(17))
        print(
            '-----------------------------------------------------------------------------------------------------------')

    def _phone(self, info_client):
        with conn.cursor() as cur:
            cur.execute(""" 
                        SELECT * FROM phone
                        WHERE id_client=%s
                        """, (info_client[0],))
            phone = cur.fetchone()
            # if phone1 == None:
            if phone is None:
                phone = '--'
            else:
                phone = list(phone)
        return phone

    def all_show(self):
        with conn.cursor() as cur:
            cur.execute(""" 
                        SELECT COUNT(*) FROM client;
                        """)
            # tmp = cur.fetchone()
            qty_clients = cur.fetchone()[0]
            self._table_header()
            for ret in range(1, qty_clients + 1):
                cur.execute("""
                            SELECT * FROM client
                            WHERE id =%s;
                            """, (ret,))
                info_client = list(cur.fetchone())
                phone = self._phone(info_client)
                self._table_body(info_client, phone)
        input('Нажмите Enter для возврата в меню...')


if __name__ == '__main__':
    while True:
        command = input("""
-------Выберите операцию---------
| 1. Создать БД                 |
| 2. Создать нового клиента     |
| 3. Добавить телефон клиента   |
| 4. Изменить данные клиента    |
| 5. Удалить телефон клиента    |
| 6. Поиск клиента              |
| 7. Просмотр всех клиентов     |
| 0. Выход                      |
---------------------------------
    """)
        client = Clients()
        if command == '1':
            client.create_db()
        elif command == '2':
            client.create_client()
        elif command == '3':
            client.create_phone()
        elif command == '4':
            client.change_data()
        elif command == '5':
            client.del_phone()
        elif command == '6':
            client.search_client()
        elif command == '7':
            client.all_show()
        elif command == '0':
            conn.close()
            print('Работа программы завершена')
            break
        else:
            print('Такой команды нет, повторите ввод')
