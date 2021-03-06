import moment from 'moment';
import queryString from 'query-string';

export const DATE_FORMAT = 'MMMM DD, YYYY';
export const DATETIME_FORMAT = 'MMMM DD, YYYY / HH:mm';

export function buildURL(url, params) {
    transformOrderParams(params);
    const qs = params ? queryString.stringify(params) : '';
    if (qs.length > 0) {
        url += '?' + qs;
    }
    return url;
}

export function formatDate(date) {
    return moment.utc(date).local().format(DATE_FORMAT);
}

export function formatDateTime(date) {
    return moment.utc(date).local().format(DATETIME_FORMAT);
}


function transformOrderParams(params) {
    if (params.hasOwnProperty('order_field')) {
        params.order = params.order_field;
        delete params.order_field;
        if (params.order_direction === 'desc') {
            params.order = `-${params.order}`;
        }
        delete params.order_direction;
    }
}
