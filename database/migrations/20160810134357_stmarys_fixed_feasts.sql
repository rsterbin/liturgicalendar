
-- rambler up

-- Fixed feasts: January
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('The Holy Name of Our Lord Jesus Christ', 2, 1, 1, 'holy-name', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Epiphany of Our Lord Jesus Christ', 1, 1, 6, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Laud, Archbishop of Canterbury, 1645', 4, 1, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aelred, Abbot of Rievaulx, 1167', 4, 1, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hilary, Bishop of Poitiers, 367', 4, 1, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Antony, Abbot in Egypt, 356', 4, 1, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Confession of Saint Peter the Apostle', 3, 1, 18, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Wulfstan, Bishop of Worcester, 1095', 4, 1, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Fabian, Bishop and Martyr of Rome, 250', 4, 1, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Agnes, Martyr at Rome, 304', 4, 1, 21, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Vincent, Deacon of Saragossa, and Martyr, 304', 4, 1, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Conversion of Saint Paul the Apostle', 3, 1, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Timothy and Titus, Companions of Saint Paul', 4, 1, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Aquinas, Priest and Friar, 1274', 4, 1, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Charles, King and Martyr, 1649', 4, 1, 30, 'red');

-- Fixed feasts: February
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Brigid (Bride), 523', 4, 2, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Presentation of Our Lord Jesus Christ in the Temple', 2, 2, 2, 'candlemas', true, 'candlemas-eve', 'gold', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Presentation of Our Lord Jesus Christ in the Temple', 2, 2, 2, 'candlemas', true, 'candlemas-eve', 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('Blase, Bishop and Martyr, c. 316', 4, 2, 3, 'blase', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cornelius the Centurion', 4, 2, 4, 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Anskar, Archbishop of Hamburg, Missionary to Denmark and Sweden, 865', 4, 2, 4, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Japan, 1597', 4, 2, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cornelius the Centurion', 4, 2, 7, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Scholastica, Religious, 542', 4, 2, 10, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Absalom Jones, Priest, 1818', 4, 2, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Monk, and Methodius, Bishop, Missionaries to the Slavs, 869, 885', 4, 2, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Bray, Priest and Missionary, 1730', 4, 2, 15, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Polycarp, Bishop and Martyr of Smyrna, 156', 4, 2, 23, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Matthias the Apostle', 3, 2, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- Fixed feasts: March

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Joseph', 3, 3, 19, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Annunciation of Our Lord Jesus Christ', 3, 3, 25, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Annunciation of Our Lord Jesus Christ', 3, 3, 25, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

-- Fixed feasts: April

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Frederick Denison Maurice, Priest, 1872', 4, 4, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Lloyd Breck, Priest, 1876', 4, 4, 2, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Richard, Bishop of Chichester, 1253', 4, 4, 3, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Martin Luther King, Jr., Civil Rights Leader, 1968', 4, 4, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Augustus Muhlenberg, Priest, 1877', 4, 4, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Law, Priest, 1761', 4, 4, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('George Augustus Selwyn, Bishop of New Zealand, and of Lichfield, 1878', 4, 4, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alphege, Archbishop of Canterbury, and Martyr, 1012', 4, 4, 19, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Anselm, Archbishop of Canterbury, 1109', 4, 4, 21, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Genocide Remembrance', 4, 4, 24, 'red', '2015-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Mark the Evangelist', 3, 4, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Catherine of Siena, 1380', 4, 4, 29, 'white');

-- Fixed feasts: May

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Philip and Saint James, Apostles', 3, 5, 1, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Athanasius, Bishop of Alexandria, 373', 4, 5, 2, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Monnica, Mother of Augustine of Hippo, 387', 4, 5, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dame Julian of Norwich, c. 1417', 4, 5, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Gregory of Nazianzus, Bishop of Constantinople, 389', 4, 5, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dunstan, Archbishop of Canterbury, 988', 4, 5, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alcuin, Deacon, and Abbot of Tours, 804', 4, 5, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jackson Kemper, First Missionary Bishop in the United States, 1870', 4, 5, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bede, the Venerable, Priest, and Monk of Jarrow, 735', 4, 5, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, First Archbishop of Canterbury, 605', 4, 5, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Visitation of the Blessed Virgin Mary', 3, 5, 31, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');

-- Fixed feasts: June

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Justin, Martyr at Rome, c. 167', 4, 6, 1, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Lyons, 177', 4, 6, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Uganda, 1886', 4, 6, 3, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Boniface, Archbishop of Mainz, Missionary to Germany, and Martyr, 754', 4, 6, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Columba, Abbot of Iona, 597', 4, 6, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ephrem of Edessa, Syria, Deacon, 373', 4, 6, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Barnabas the Apostle', 3, 6, 11, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Basil the Great, Bishop of Caesarea, 379', 4, 6, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph Butler, Bishop of Durham, 1752', 4, 6, 16, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Bernard Mizeki, Catechist and Martyr in Rhodesia, 1896', 4, 6, 18, 'red', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bernard Mizeki, Catechist and Martyr in Mashonaland, 1896', 4, 6, 18, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alban, First Martyr of Britain, c. 304', 4, 6, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Nativity of Saint John the Baptist', 2, 6, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Patriarch of Alexandria, 444', 4, 6, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Irenaeus, Bishop of Lyons and Martyr, c. 202', 4, 6, 28, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Peter and Saint Paul, Apostles', 3, 6, 29, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- Fixed feasts: July

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Independence Day', 3, 7, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Jan Hus, Prophetic Witness and Martyr, 1415', 4, 7, 6, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Benedict of Nursia, Abbot of Monte Casino, c. 540', 4, 7, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bonaventure, Bishop and Friar, 1274', 4, 7, 15, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William White, Bishop of Pennsylvania, 1836', 4, 7, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Macrina, Monastic and Teacher, 379', 4, 7, 19, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Mary Magdalene', 3, 7, 22, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas a Kempis, Priest, 1471', 4, 7, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint James the Apostle', 3, 7, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Parents of the Blessed Virgin Mary', 4, 7, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Reed Huntington, Priest, 1909', 4, 7, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Mary and Martha of Bethany', 4, 7, 29, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Wilberforce, Abolitionist, 1833', 4, 7, 30, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Ignatius of Loyola, Priest and Monastic, 1556', 4, 7, 31, 'white', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- Fixed feasts: August

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph of Arimathaea', 4, 8, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Transfiguration of Our Lord Jesus Christ', 1, 8, 6, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Mason Neale, Priest, 1866', 4, 8, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dominic, Priest and Friar, 1221', 4, 8, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lawrence, Deacon, and Martyr at Rome, 258', 4, 8, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clare, Abbess at Assisi, 1253', 4, 8, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Florence Nightingale, Nurse, Social Reformer, 1910', 4, 8, 12, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jeremy Taylor, Bishop of Down, Connor, and Dromore, 1667', 4, 8, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jonathan Myrick Daniels, Seminarian and Witness for Civil Rights, 1965', 4, 8, 14, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Assumption of the Blessed Virgin Mary', 3, 8, 15, 'assumption', true, 'assumption-eve', 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Assumption of the Blessed Virgin Mary', 3, 8, 15, 'assumption', true, 'assumption-eve', 'gold', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bernard, Abbot of Clairvaux, 1153', 4, 8, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Bartholomew the Apostle', 3, 8, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Louis, King of France, 1270', 4, 8, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Thomas Gallaudet, Priest, 1902, with Henry Winter Syle, Priest, 1890, Missioners to the Deaf', 4, 8, 27, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, Bishop of Hippo, 430', 4, 8, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Beheading of Saint John the Baptist', 4, 8, 29, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aidan, Bishop of Lindisfarne, 651', 4, 8, 31, 'white');

-- Fixed feasts: September

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of New Guinea, 1942', 4, 9, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Nativity of the Blessed Virgin Mary', 3, 9, 8, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Constance, Nun, and her Companions, 1878', 4, 9, 9, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Alexander Crummel, 1898', 4, 9, 10, 'white', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Requiem for the Victims of September 11, 2011', 4, 9, 11, 'black', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_end) VALUES ('Parish Requiem: Victims of September 11, 2011', 4, 9, 11, 'parish-requiem', 'purple', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Henry Hobart, Bishop of New York, 1830', 4, 9, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('John Chrysostom, Bishop of Constantinople, 407', 4, 9, 13, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 13, 'red', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('Holy Cross Day', 2, 9, 14, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('Holy Cross Day', 2, 9, 14, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'red', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 15, 'red', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Ninian, Bishop in Galloway, c. 430', 4, 9, 16, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Hildegard of Bingen, 1170', 4, 9, 17, 'white', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Edward Bouverie Pusey, Priest, 1882', 4, 9, 18, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Theodore of Tarsus, Archbishop of Canterbury, 690', 4, 9, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Coleridge Patteson, Bishop of Melanesia, and his Companions, Martyrs, 1871', 4, 9, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Matthew, Apostle and Evangelist', 3, 9, 21, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Sergius, Abbot of Holy Trinity, Moscow, 1392', 4, 9, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lancelot Andrewes, Bishop of Winchester, 1626', 4, 9, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Michael and All Angels', 2, 9, 29, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jerome, Priest, and Monk of Bethlehem, 420', 4, 9, 30, 'white');

-- Fixed feasts: October

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Remigius, Bishop of Rheims, c. 530', 4, 10, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Dedication of the Church', 5, 10, 3, 'white', '2005-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Francis of Assisi, Friar, 1226', 4, 10, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('William Tyndale, Priest, 1536', 4, 10, 6, 'red', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('William Tyndale, Priest, 1536', 4, 10, 6, 'white', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Robert Grosseteste, Bishop of Lincoln, 1253', 4, 10, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Philip, Deacon and Evangelist', 4, 10, 11, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Samuel Isaac Joseph Schereschewsky, Bishop of Shanghai, 1906', 4, 10, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Teresa of Avila, Nun, 1582', 4, 10, 15, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Hugh Latimer and Nicholas Ridley, Bishops, 1555', 4, 10, 16, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ignatius, Bishop of Antioch, and Martyr, c. 115', 4, 10, 17, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Luke the Evangelist', 3, 10, 18, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Henry Martyn, Priest and Missionary to India and Persia, 1812', 4, 10, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint James of Jerusalem, Brother of Our Lord Jesus Christ, and Martyr, c. 62', 4, 10, 23, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alfred the Great, King of the West Saxons, 899', 4, 10, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Simon and Saint Jude, Apostles', 3, 10, 28, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Hannington, Bishop of Eastern Equatorial Africa, and his Companions, Martyrs, 1885', 4, 10, 29, 'red');

-- Fixed feasts: November

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('All Saints', 1, 11, 1, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('All Saints', 1, 11, 1, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, code, schedule_pattern, color) VALUES ('All Souls Day', 3, 11, 2, 'all-souls', 'all-souls', 'black');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Richard Hooker, Priest, 1600', 4, 11, 3, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Willibrord, Archbishop of Utrecht, Missionary to Frisia, 739', 4, 11, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Leo the Great, Bishop of Rome, 461', 4, 11, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Martin, Bishop of Tours, 397', 4, 11, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Charles Simeon, Priest, 1836', 4, 11, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Samuel Seabury, First American Bishop, 1796', 4, 11, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Margaret, Queen of Scotland, 1093', 4, 11, 16, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hugh, Bishop of Lincoln, 1200', 4, 11, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hilda, Abbess of Whitby, 680', 4, 11, 18, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Elizabeth, Princess of Hungary, 1231', 4, 11, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Edmund, King of East Anglia, Martyr, 870', 4, 11, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Cecilia, Virgin and Martyr, c. 117', 4, 11, 22, 'red', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clement, Bishop of Rome, c. 100', 4, 11, 23, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Otis Sargent Huntington, Priest and Monk, 1935', 4, 11, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Kamehameha and Emma, King and Queen of Hawaii, 1864, 1885', 4, 11, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Andrew the Apostle', 4, 11, 30, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- Fixed feasts: December

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Nicholas Ferrar, Deacon, 1637', 4, 12, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John of Damascus, Priest, c. 760', 4, 12, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clement of Alexandria, Priest, c. 210', 4, 12, 5, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Nicholas, Bishop of Myra, c. 342', 4, 12, 6, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ambrose, Bishop of Milan, 397', 4, 12, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('The Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('The Immaculate Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Immaculate Conception', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2007-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Anniversary of the Dedication of the Church, 1895', 2, 12, 12, 'gold', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('Anniversary of the Consecration of the Church, 1895', 2, 12, 12, true, 'fixed-feast-eve', 'white', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('Anniversary of the Dedication of the Church, 1895', 2, 12, 12, true, 'fixed-feast-eve', 'white', '2006-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Lucy, Virgin and Martyr, c. 304', 4, 12, 13, 'red', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Lucy, Martyr at Syracuse, 304', 4, 12, 13, 'red', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('John of the Cross, Priest, 1591', 4, 12, 14, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Thomas the Apostle', 3, 12, 21, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color, note, valid_start) VALUES ('The Nativity of Our Lord Jesus Christ: Christmas Day', 1, 12, 25, 'christmas', true, 'christmas-eve', 'Eve of the Nativity of our Lord Jesus Christ: Christmas Eve', 'gold', 'The church opens at 10:00 AM today and closes at 2:00 PM.', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color, note, valid_end) VALUES ('The Nativity of Our Lord Jesus Christ: Christmas Day', 1, 12, 25, 'christmas', true, 'christmas-eve', 'Eve of the Nativity of our Lord Jesus Christ: Christmas Eve', 'white', 'The church opens at 10:00 AM today and closes at 2:00 PM.', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_start) VALUES ('Saint Stephen, Deacon and Martyr', 3, 12, 26, 'without-prayers', 'red', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_end) VALUES ('Saint Stephen, Deacon and Martyr', 3, 12, 26, 'weekday-feast', 'red', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('Saint John, Apostle and Evangelist', 3, 12, 27, 'weekday-feast', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('The Holy Innocents', 3, 12, 28, 'weekday-feast', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Becket, 1170', 4, 12, 29, 'red');

-- rambler down

TRUNCATE TABLE fixed_feasts RESTART IDENTITY;

-- todo: answered questions:
-- Is the change from white to gold for Annunciation an intentional change or a mistake that got carried from the previous year's transfer?
    -- YES, this is correct
-- The list of Commemorations needs confirmation, as there are some important variations from the Episcopal calendars I've found (e.g. http://satucket.com/lectionary/Calendar.htm)
    -- Will review
-- If a major feast falls on a Saturday in Lent, what happens to Stations of the Cross?
    -- Omitted for a solemn mass; mass is dropped for regular feasts
-- Was Ignatius of Loyola dropped from the calendar intentionally?
    -- Yes, but Fr. Smith sometimes does it anyway
-- Confirm that The Nativity of the Blessed Virgin Mary doesn't get transferred from Sunday, despite otherwise looking like a level 3
    -- Correctly, it would be transferred as usual

-- todo: suggestions
-- July 18 [Bartolomé de las Casas, Friar and Missionary to the Indies, 1566] - WE SHOULD DO THIS: http://theoatmeal.com/comics/columbus_day

-- todo: ask for clarification
-- Confirm that Hildegard was meant to be a breif blip on the schedule
-- Is there a Healing Mass on a feast day (level 3) at 12:10? At 6:20?
-- Confirm that Saint Michael and All Angels *and* Holy Cross are level 2s but have a level 3 service schedule
-- Ditto for Transfiguration, only that it's a level 1
-- Are there season-based schedule pattern adjustments?
-- Should I standardize the shifting names of Immaculate Conception and the Dedication of the Church? (if so, we just have one color change, not three name changes)

