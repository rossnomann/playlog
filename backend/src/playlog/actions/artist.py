from datetime import datetime

from sqlalchemy.sql import and_, func, select

from playlog.lib.validation import Int, ISODateTime, Length, OneOf, Optional, validate
from playlog.models import artist


async def create(conn, name):
    now = datetime.utcnow()
    return await conn.scalar(artist.insert().values(
        name=name,
        plays=1,
        first_play=now,
        last_play=now
    ))


async def find_one(conn, **kwargs):
    query = select([artist])
    for key, value in kwargs.items():
        query = query.where(getattr(artist.c, key) == value)
    result = await conn.execute(query)
    return await result.fetchone()


@validate(
    params={
        'name': Optional(Length(min_len=1, max_len=50)),
        'first_play_lt': Optional(ISODateTime()),
        'first_play_gt': Optional(ISODateTime()),
        'last_play_lt': Optional(ISODateTime()),
        'last_play_gt': Optional(ISODateTime()),
        'order_field': Optional(OneOf(['name', 'first_play', 'last_play', 'plays'])),
        'order_direction': Optional(OneOf(['asc', 'desc'])),
        'limit': Int(min_val=1, max_val=100),
        'offset': Int(min_val=0)
    }
)
async def find_many(conn, params):
    filters = []
    if 'name' in params:
        filters.append(artist.c.name.ilike('%{}%'.format(params['name'])))
    if 'first_play_gt' in params:
        filters.append(artist.c.first_play >= params['first_play_gt'])
    if 'first_play_lt' in params:
        filters.append(artist.c.first_play <= params['first_play_lt'])
    if 'last_play_gt' in params:
        filters.append(artist.c.last_play >= params['last_play_gt'])
    if 'last_play_lt' in params:
        filters.append(artist.c.last_play <= params['last_play_lt'])

    order_field = params.get('order_field', 'name')
    order_clause = artist.c[order_field]
    order_direction = params.get('order_direction', 'asc')
    order_clause = getattr(order_clause, order_direction)()

    stmt = select([artist])
    if filters:
        stmt = stmt.where(and_(*filters))
    total = await conn.scalar(stmt.with_only_columns([func.count(artist.c.id)]))
    stmt = stmt.offset(params['offset']).limit(params['limit']).order_by(order_clause)
    result = await conn.execute(stmt)
    items = await result.fetchall()

    return {'items': items, 'total': total}


async def update(conn, artist_id):
    await conn.execute(artist.update().values(
        plays=artist.c.plays + 1,
        last_play=datetime.utcnow()
    ).where(artist.c.id == artist_id))


async def count_total(conn):
    return await conn.scalar(artist.count())


async def count_new(conn, since):
    return await conn.scalar(select([func.count()]).where(artist.c.first_play >= since))