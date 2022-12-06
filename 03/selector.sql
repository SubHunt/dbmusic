--�������� � ��� ������ ��������, �������� � 2018 ����;
SELECT name, year FROM albums
WHERE YEAR = 2018;
--�������� � ����������������� ������ ����������� �����;
SELECT name, duration FROM tracks 
WHERE  duration = (SELECT max(duration) FROM  tracks);
--�������� ������, ����������������� ������� �� ����� 3,5 ������;
SELECT name, duration FROM tracks
WHERE duration >= 3.5;
--�������� ���������, �������� � ������ � 2018 �� 2020 ��� ������������;
SELECT name, year FROM collections
WHERE YEAR BETWEEN 2018 AND 2020;
--�����������, ��� ��� ������� �� 1 �����;
SELECT * FROM singers
WHERE name NOT LIKE '% %';
--�������� ������, ������� �������� ����� "���"/"my".
SELECT name FROM tracks
WHERE name LIKE '%My%';