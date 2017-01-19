SET GLOBAL event_scheduler = ON;

show processlist;

-- Create a one-time event that store a record on creation
CREATE EVENT IF NOT EXISTS message_event
ON schedule at current_timestamp()
do
	insert into messages(messages, messages.created_at)
    values('Event test MySQL', now());
   
-- Create a preserved event that store a record on creation
CREATE EVENT IF NOT EXISTS message_event2
ON schedule at current_timestamp()
ON completion preserve
do
	insert into messages(messages, messages.created_at)
    values('Event test MySQL', now());

-- Create an event that is executed at 1 minute from creation 
CREATE EVENT IF NOT EXISTS message_event_after_minute
ON schedule at current_timestamp + interval 1 minute
on completion preserve
do
	insert into messages(message, created_at)
    values('Test mysqk recurring event', NOW());
    
CREATE EVENT IF NOT EXISTS message_event_every_minute_hour
ON schedule every 1 minute
starts current_timestamp()
ends current_timestamp() + interval 1 hour
on completion preserve
do
	insert into messages(message, created_at)
    values('Test mysqk recurring event', NOW());
    
    
-- Print all events
show events from classicmodels;

-- Print records
select * from messages;

