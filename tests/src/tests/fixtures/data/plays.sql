INSERT INTO artist
    (id, name, first_play, last_play, plays)
VALUES
    (1, 'Ulcerate', '2013-05-19T16:24:00', '2017-08-31T23:04:00', 2351),
    (2, 'Sterbend', '2012-12-08T14:23:00', '2012-12-08T14:23:00', 1)
;

INSERT INTO album
    (id, artist_id, name, first_play, last_play, plays)
VALUES
    (1, 1, 'Shrines Of Paralysis', '2016-10-24T10:32:00', '2017-08-31T15:16:00', 442),
    (2, 2, 'Einsamkeit', '2012-12-08T14:23:00', '2012-12-08T14:23:00', 1)
;

INSERT INTO track
    (id, album_id, name, first_play, last_play, plays)
VALUES
    (1, 1, 'Extinguished Light', '2016-10-24T11:23:00', '2017-08-31T15:07:00', 70),
    (2, 2, 'Introduction', '2012-12-08T14:23:00', '2012-12-08T14:23:00', 1)
;

INSERT INTO play
    (track_id, date)
VALUES
    (1, '2016-10-24T11:23:00'),
    (1, '2017-08-31T15:07:00'),
    (1, '2017-08-31T14:59:00'),
    (1, '2017-08-30T22:28:00'),
    (1, '2017-08-29T21:47:00'),
    (1, '2017-08-29T11:50:00'),
    (1, '2017-08-28T14:46:00'),
    (1, '2017-08-25T16:45:00'),
    (1, '2017-08-23T10:35:00'),
    (1, '2017-08-22T11:47:00'),
    (1, '2017-08-21T01:09:00'),
    (1, '2017-08-18T10:30:00'),
    (1, '2017-08-10T15:51:00'),
    (1, '2017-08-06T21:36:00'),
    (1, '2017-08-06T21:12:00'),
    (1, '2017-08-06T01:22:00'),
    (1, '2017-08-06T01:00:00'),
    (1, '2017-08-01T12:26:00'),
    (1, '2017-05-23T22:10:00'),
    (1, '2017-03-29T10:49:00'),
    (1, '2017-03-27T17:30:00'),
    (1, '2017-03-25T22:03:00'),
    (1, '2017-03-23T16:40:00'),
    (1, '2017-03-22T00:05:00'),
    (1, '2017-03-19T17:47:00'),
    (1, '2017-03-17T16:46:00'),
    (1, '2017-03-12T21:35:00'),
    (1, '2017-03-07T15:42:00'),
    (1, '2017-03-05T13:37:00'),
    (1, '2017-03-03T16:23:00'),
    (1, '2017-03-02T11:07:00'),
    (1, '2017-02-28T15:31:00'),
    (2, '2012-12-08T14:23:00')
;
