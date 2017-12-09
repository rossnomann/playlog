INSERT INTO artist
    (id, name, first_play, last_play, plays)
VALUES
    (1, 'Analepsy', '2017-01-02T10:10:49.266031', '2017-01-04T11:29:13.497261', 46)
;

INSERT INTO album
    (id, artist_id, name, first_play, last_play, plays)
VALUES
    (1, 1, 'Atrocities From Beyond', '2017-01-02T10:10:49.266031', '2017-01-04T11:29:13.497261', 46)
;

INSERT INTO track
    (id, album_id, name, first_play, last_play, plays)
VALUES
    (1, 1, 'Apocalyptic Premonition', '2017-01-02T10:10:49.266031', '2017-01-04T00:30:13.801911', 5),
    (2, 1, 'Rifts To Abhorrence', '2017-01-03T21:28:13.534769', '2017-01-04T03:30:13.962872', 7),
    (3, 1, 'The Vermin Devourer', '2017-01-03T22:29:14.013657', '2017-01-04T00:30:13.465640', 3),
    (4, 1, 'Witnesses Of Extinction', '2017-01-03T23:29:13.613433', '2017-01-04T00:28:13.823189', 2),
    (5, 1, 'Ferocious Aftermath (Featuring Sergio Afonso)', '2017-01-04T00:28:13.733051', '2017-01-04T07:28:14.112046', 8),
    (6, 1, 'Engorged Absorption', '2017-01-04T01:29:14.057383', '2017-01-04T07:29:14.077525', 7),
    (7, 1, 'Eons In Vacuum', '2017-01-04T02:28:13.831975', '2017-01-04T02:28:13.831975', 1),
    (8, 1, 'Depths Of Agony (Instrumental)', '2017-01-04T03:28:13.943723', '2017-01-04T05:29:13.736572', 3),
    (9, 1, 'Atrocity Deeds (Featuring Larry Wang)', '2017-01-04T04:28:14.069693', '2017-01-04T06:30:14.007268', 3),
    (10, 1, 'Omen Of Return (Instrumental)', '2017-01-04T05:28:13.692549', '2017-01-04T11:29:13.497261', 7)
;

INSERT INTO play
    (track_id, date)
VALUES
    (1, '2017-01-02T10:10:49.266031'),
    (1, '2017-01-03T21:29:13.720421'),
    (1, '2017-01-03T22:28:13.624171'),
    (1, '2017-01-03T23:28:13.803075'),
    (1, '2017-01-04T00:30:13.801911'),
    (2, '2017-01-03T21:28:13.534769'),
    (2, '2017-01-03T22:28:13.657264'),
    (2, '2017-01-03T23:30:13.741417'),
    (2, '2017-01-04T00:30:13.936311'),
    (2, '2017-01-04T01:28:13.752405'),
    (2, '2017-01-04T02:28:13.468247'),
    (2, '2017-01-04T03:30:13.962872'),
    (3, '2017-01-03T22:29:14.013657'),
    (3, '2017-01-03T23:29:13.815177'),
    (3, '2017-01-04T00:30:13.465640'),
    (4, '2017-01-03T23:29:13.613433'),
    (4, '2017-01-04T00:28:13.823189'),
    (5, '2017-01-04T00:28:13.733051'),
    (5, '2017-01-04T01:28:13.522210'),
    (5, '2017-01-04T02:29:14.087728'),
    (5, '2017-01-04T03:28:13.992299'),
    (5, '2017-01-04T04:30:14.100820'),
    (5, '2017-01-04T05:28:13.445464'),
    (5, '2017-01-04T06:29:13.774101'),
    (5, '2017-01-04T07:28:14.112046'),
    (6, '2017-01-04T01:29:14.057383'),
    (6, '2017-01-04T02:30:14.009873'),
    (6, '2017-01-04T03:29:13.550359'),
    (6, '2017-01-04T04:28:14.109284'),
    (6, '2017-01-04T05:30:14.093445'),
    (6, '2017-01-04T06:28:14.129171'),
    (6, '2017-01-04T07:29:14.077525'),
    (7, '2017-01-04T02:28:13.831975'),
    (8, '2017-01-04T03:28:13.943723'),
    (8, '2017-01-04T04:30:13.785778'),
    (8, '2017-01-04T05:29:13.736572'),
    (9, '2017-01-04T04:28:14.069693'),
    (9, '2017-01-04T05:29:13.651389'),
    (9, '2017-01-04T06:30:14.007268'),
    (10, '2017-01-04T05:28:13.692549'),
    (10, '2017-01-04T06:28:13.673614'),
    (10, '2017-01-04T07:28:13.832995'),
    (10, '2017-01-04T08:28:13.435869'),
    (10, '2017-01-04T09:30:13.948995'),
    (10, '2017-01-04T10:30:13.744018'),
    (10, '2017-01-04T11:29:13.497261')
;
