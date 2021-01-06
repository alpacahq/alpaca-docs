#### Events

Events API provide event push as well as historical queries via SSE.

##### Available Endpoints

`GET /v1/events/accounts/status`

`GET /v1/events/trades`

`GET /v1/events/journals/status`

###### 

##### `GET /v1/events/accounts/status`

###### Request

​	`since` - string <timestamp> (optional)

​	`until` - string <timestamp> (optional)

​	`since_id` - (optional)

​	`since_id` - (optional)

Notes

- if `until` is specified, `since` is required
- if `until_id` is specified, `since_id` is required
- `since` and `since_id` cannot be specified together
- if `until` and `until_id` are specified, and the stream reaches the end of the queried range, the server will disconnect from the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur. 

SSE Fields

​	`id` - monotonically increasing 64bit int

​	`event` - `account_status`

###### Updates (`account_status`)

​	`account_id` - UUID

​	`account_number` - string

​	`status_from` - string, status changed from

​	`status_to` - string, status changed to

​	`reason` - string

​	`at` - string <timestamp> of the event



##### `GET /v1/events/trades`

###### Request

​	`since` - string <timestamp> (optional)

​	`until` - string <timestamp> (optional)

​	`since_id` - (optional)

​	`since_id` - (optional)

Notes

- if `until` is specified, `since` is required
- if `until_id` is specified, `since_id` is required
- `since` and `since_id` cannot be specified together
- if `until` and `until_id` are specified, and the stream reaches the end of the queried range, the server will disconnect from the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur. 

SSE Fields

​	`id` - monotonically increasing 64bit int

​	`event` - `trade_update`

###### Updates (`trade_updates`)

​	`account_id` - UUID

​	`account_number` - string

​	`status_from` - string, status changed from

​	`status_to` - string, status changed to

​	`reason` - string

​	`at` - string <timestamp> of the event



#####  `GET /v1/events/journals/status`

###### Request

​	`since` - string <timestamp> (optional)

​	`until` - string <timestamp> (optional)

​	`since_id` - (optional)

​	`since_id` - (optional)

Notes

- if `until` is specified, `since` is required
- if `until_id` is specified, `since_id` is required
- `since` and `since_id` cannot be specified together
- if `since` or `since_id` are not specified, this will **not** return historical status changes.
- if `until` and `until_id` are specified, and the stream reaches the end of the queried range, the server will disconnect from the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur. 

SSE Fields

​	`id` - monotonically increasing 64bit int

​	`event` - `journal_update`

###### Updates (`journal_updates`)

​	`event_id` - UUID

​	`at` - string <timestamp> of the event

​	`entry_type` - string <timestamp> of the event

​	`journal_id` - string <timestamp> of the event

​	`status_from` - string, status changed from

​	`status_to` - string, status changed to