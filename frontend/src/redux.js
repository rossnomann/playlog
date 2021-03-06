import humps from 'humps';
import {applyMiddleware, combineReducers, createStore} from 'redux';
import thunk from 'redux-thunk';

import {buildURL} from './utils';


const FETCH_PARAMS = {
    headers: {
        'Accept': 'application/json'
    }
};


function generate(config) {
    let actions = {},
        reducers = {};

    Object.entries(config).forEach(item => {
        const [key, maybeUrl] = item;

        const actionTypes = {
            start: `${key}_START`,
            success: `${key}_SUCCESS`,
            failed: `${key}_FAILED`
        };

        const initialState = {
            loaded: false,
            success: null,
            payload: null
        };

        actions[`${key}Request`] = (...query) => dispatch => {
            let url = typeof maybeUrl === 'function' ? maybeUrl(...query) : maybeUrl;

            dispatch({type: actionTypes.start});

            return fetch(url, FETCH_PARAMS).then(rep => {
                const json = rep.json();
                return rep.status === 200 ? json : json.then(err => {
                    throw err;
                });
            }).then(
                (payload) => dispatch({
                    type: actionTypes.success,
                    payload: humps.camelizeKeys(payload, {deep: true})
                }),
                (payload) => dispatch({
                    type: actionTypes.failed,
                    payload
                })
            );
        };

        reducers[key] = (state = initialState, {type, payload}) => {
            switch (type) {
                case actionTypes.start:
                    state = initialState;
                    break;
                case actionTypes.success:
                    state = {
                        loaded: true,
                        success: true,
                        payload
                    };
                    break;
                case actionTypes.failed:
                    state = {
                        loaded: true,
                        success: false,
                        payload
                    };
                    break;
                default:
                    break;
            }
            return state;
        };

    });

    return {actions, reducers};
}

const {actions, reducers} = generate({
    album: id => `/api/albums/${id}`,
    albums: params => buildURL('/api/albums', params),
    artist: id => `/api/artists/${id}`,
    artists: params => buildURL('/api/artists', params),
    counters: '/api/counters',
    overview: '/api/overview',
    plays: params => buildURL('/api/plays', params),
    playsCount: params => buildURL('/api/plays/count', params),
    track: id => `/api/tracks/${id}`,
    tracks: params => buildURL('/api/tracks', params)
});

const store = createStore(
    combineReducers(reducers),
    applyMiddleware(thunk)
);

export {actions, store};
