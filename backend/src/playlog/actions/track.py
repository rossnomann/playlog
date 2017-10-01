from datetime import datetime

from sqlalchemy.sql import and_, func, select

from playlog.lib.validation import Int, ISODateTime, Length, OneOf, Optional, validate
from playlog.models import album, artist, track


async def create(conn, album_id, name):
    now = datetime.utcnow()
    return await conn.scalar(track.insert().values(
        name=name,
        album_id=album_id,
        plays=1,
        first_play=now,
        last_play=now
    ))


async def find_one(conn, **kwargs):
    query = select([
        artist.c.id.label('artist_id'),
        artist.c.name.label('artist_name'),
        album.c.name.label('album_name'),
        track
    ])
    for key, value in kwargs.items():
        query = query.where(getattr(track.c, key) == value)
    query = query.select_from(track.join(album).join(artist))
    result = await conn.execute(query)
    return await result.fetchone()


@validate(
    params={
        'artist': Optional(Length(min_len=1, max_len=50)),
        'album': Optional(Length(min_len=1, max_len=50)),
        'track': Optional(Length(min_len=1, max_len=50)),
        'first_play_lt': Optional(ISODateTime()),
        'first_play_gt': Optional(ISODateTime()),
        'last_play_lt': Optional(ISODateTime()),
        'last_play_gt': Optional(ISODateTime()),
        'order_field': Optional(OneOf([
            'artist',
            'album',
            'track',
            'first_play',
            'last_play',
            'plays'
        ])),
        'order_direction': Optional(OneOf(['asc', 'desc'])),
        'limit': Int(min_val=1, max_val=100),
        'offset': Int(min_val=0)
    }
)
async def find_many(conn, params):
    artist_name = artist.c.name.label('artist')
    album_name = album.c.name.label('album')

    filters = []
    if 'artist' in params:
        filters.append(artist_name.ilike('%{}%'.format(params['artist'])))
    if 'album' in params:
        filters.append(album_name.ilike('%{}%'.format(params['album'])))
    if 'track' in params:
        filters.append(track.c.name.ilike('%{}%'.format(params['track'])))
    if 'first_play_gt' in params:
        filters.append(track.c.first_play >= params['first_play_gt'])
    if 'first_play_lt' in params:
        filters.append(track.c.first_play <= params['first_play_lt'])
    if 'last_play_gt' in params:
        filters.append(track.c.last_play >= params['last_play_gt'])
    if 'last_play_lt' in params:
        filters.append(track.c.last_play <= params['last_play_lt'])

    order_field = params.get('order_field', 'artist')
    if order_field == 'artist':
        order_clause = artist_name
    elif order_field == 'album':
        order_clause = album_name
    elif order_field == 'track':
        order_clause = track.c.name
    else:
        order_clause = track.c[order_field]
    order_direction = params.get('order_direction', 'asc')
    order_clause = getattr(order_clause, order_direction)()

    stmt = select([artist.c.id.label('artist_id'), artist_name, album_name, track])
    if filters:
        stmt = stmt.where(and_(*filters))
    stmt = stmt.select_from(track.join(album).join(artist))
    total = await conn.scalar(stmt.with_only_columns([func.count(track.c.id)]))
    stmt = stmt.offset(params['offset']).limit(params['limit']).order_by(order_clause)
    result = await conn.execute(stmt)
    items = await result.fetchall()
    return {'items': items, 'total': total}


async def find_for_album(conn, album_id):
    query = select([track]).where(track.c.album_id == album_id).order_by(track.c.plays.desc())
    result = await conn.execute(query)
    return await result.fetchall()


async def update(conn, track_id):
    await conn.execute(track.update().values(
        plays=track.c.plays + 1,
        last_play=datetime.utcnow()
    ).where(track.c.id == track_id))


async def count_total(conn):
    return await conn.scalar(track.count())


async def count_new(conn, since):
    return await conn.scalar(select([func.count()]).where(track.c.first_play >= since))