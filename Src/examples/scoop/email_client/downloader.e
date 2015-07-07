note
	description: "Downloads email messages and stores them in a separate list."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOADER

inherit
	TUTORIAL_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_client: separate CLIENT; a_controller: separate CONTROLLER)
			-- Initialization for `Current'.
		do
			client := a_client
			controller := a_controller
		end

feature -- Access

	client: separate CLIENT
			-- The client where new messages should be stored.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

	count: INTEGER
			-- Number of downloaded messages.

	computed_count: INTEGER
			-- Number of messages in client's message list.
		do
			separate client as m do
				Result := m.messages.count
			end
		end

feature -- Status report

	is_over: BOOLEAN
			-- Shall `Current' stop its operation?
		do
			separate controller as c do
				Result := c.is_over
			end
		end

feature -- Basic operations.

	download_one
			-- Read one message and record it in `client'.
		local
			latest: STRING
		do
				-- Simulate the time it takes to download a message.
				-- Note: To get deterministic results, use `wait (1000)' instead.
			random_wait

				-- Generate a new message.
			count := count + 1
			latest := "Message" + count.out

				-- Add the message to the client.
			print ("Adding message: " + latest + "%N")
			record_one (client, latest)
		end

	record_one (a_client: separate CLIENT; a_email: STRING)
			-- Store message `a_email' in `a_client'.
		do
			a_client.extend (a_email)
		end

	live
			-- Get messages and add them to the client message list.
		do
			from until is_over loop
				download_one
			end
		end

feature -- Stopping a Processor: the wrong approach.


--	is_over: BOOLEAN
			-- Shall `Current' stop its operation?

--	stop
--			-- Set `is_over' to True.
--			-- Note: It isn't possible to stop a SCOOP processor like this, as the client will never get exclusive
--			-- access while `Current' is executing {DOWNLOADER}.live.
--		do
--			is_over := True
--		end

end