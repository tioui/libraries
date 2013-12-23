note
	description: "Summary description for {PS_READ_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_QUERY_CURSOR

inherit
	PS_ABEL_EXPORT

	ITERATION_CURSOR [ANY]

create
	make

feature {NONE} -- Initialization

	make (a_query: PS_ABSTRACT_QUERY [ANY, ANY]; a_filter: READABLE_INDEXABLE [STRING]; a_read_manager: PS_READ_MANAGER)
			-- Initialization for `Current'.
		local
			reflector: REFLECTOR
			stored_types: LIST [READABLE_STRING_GENERAL]
			subtypes_list: LINKED_LIST [PS_TYPE_METADATA]

			type, l_type: PS_TYPE_METADATA

			empty_result: LINKED_LIST [PS_BACKEND_ENTITY]
			empty_processed: LINKED_LIST [INTEGER]
		do
			query := a_query
			create filter.make (a_filter)
			read_manager := a_read_manager
			type := read_manager.metadata_factory.create_metadata_from_type (query.generic_type)

			create filter_lookup.make (filter.count)
			filter.do_all (agent filter_lookup.extend (True, ?))


			create reflector

			create subtypes_list.make
			subtypes_list.extend (type)

			if query.is_subtype_included then

				stored_types := read_manager.backend.stored_types

				across
					stored_types as cursor
				loop
					l_type := read_manager.metadata_factory.create_metadata_from_type_id (reflector.dynamic_type_from_string (cursor.item))
					if l_type.type.type_id /= type.type.type_id and reflector.type_conforms_to (l_type.type.type_id, type.type.type_id) then
						subtypes_list.extend (l_type)
					end
				end
			end

			subtypes := subtypes_list.new_cursor

			create empty_result.make
			current_result := empty_result.new_cursor
			create empty_processed.make

				-- Populate with a bogus item such that a call to `forth' can be used
				-- for proper initialization.
			empty_processed.extend (-1)
			processed_items := empty_processed.new_cursor
		end

feature {PS_ABEL_EXPORT}

	query: PS_ABSTRACT_QUERY [ANY, ANY]

	filter: PS_IMMUTABLE_STRUCTURE [STRING]

	filter_lookup: HASH_TABLE [BOOLEAN, STRING]

	subtypes: ITERATION_CURSOR [PS_TYPE_METADATA]

	current_result: ITERATION_CURSOR [PS_BACKEND_ENTITY]

	processed_items: ITERATION_CURSOR [INTEGER]

	read_manager: PS_READ_MANAGER



	advance_type
			-- Retrieve the query result for the next type and update `current_result'.
		do
			if not subtypes.after then
					-- Query the database and initialize the new current_result.
				current_result := read_manager.dispatch_retrieve (subtypes.item, query.criterion, filter, read_manager.transaction)
				subtypes.forth
			end
		end

	advance_current_result
			-- Build the next batch of items in `current_result' and update `processed_items'.
		do
			from
			until
				not current_result.after or after
			loop
				advance_type
			end

			if not after then
				build_batch
			end
		end

	advance_item
			-- Get the next item.
		do
			from
				processed_items.forth
			until
				not processed_items.after or after
			loop
				advance_current_result
			end
		end


	forth
			-- Get objects until one satisfies the query criteria.
		do
			from
				advance_item
			until
				after or else (attached maybe_item as it and then query.criterion.is_satisfied_by (it))
			loop
				advance_item
			end
		end

	build_batch
			-- Build all objects which were returned in the last batch by the backend.
		local
			index: INTEGER
			batch_count: INTEGER

			retrieved_entity: PS_BACKEND_ENTITY
			new_object: PS_OBJECT_READ_DATA

			to_build: PS_INTEGER_INTERVAL

			processed_interval: PS_INTEGER_INTERVAL
			processed_array: ARRAYED_LIST [INTEGER]

			processed: INDEXABLE [INTEGER, INTEGER]
		do


			from

				batch_count := read_manager.backend.batch_retrieval_size
				if batch_count < 1 then
						-- Some reasonable default to exploit caches.
					batch_count := 100
				end

				if query.object_initialization_depth >= 0 then
						-- Wipe out the read manager, because there are a lot of half-initialized objects.
					read_manager.wipe_out
				end

				create to_build.make_new (read_manager.count + 1, read_manager.count)
				create processed_interval.make_new (read_manager.count + 1, read_manager.count)
				processed := processed_interval
			until
				batch_count = 0 or current_result.after
			loop
				retrieved_entity := current_result.item
				current_result.forth
					-- Ignore non-root objects when not required.
				if retrieved_entity.is_root or not query.is_non_root_ignored then

						-- Check if the object has been loaded previously.
					index := read_manager.cache_lookup (retrieved_entity.primary_key, retrieved_entity.metadata)

					if index = 0 then


						index := read_manager.count + 1

						if read_manager.free_objects.is_empty then
							create new_object.make_with_primary_key (index, retrieved_entity.primary_key, retrieved_entity.metadata, 0)
						else
								-- Reuse one of the existing PS_OBJECT_READ_DATA.
							new_object := read_manager.free_objects.item
							read_manager.free_objects.remove
							new_object.reset (index, retrieved_entity.primary_key, retrieved_entity.metadata, 0)
						end

						read_manager.add_object (new_object, not query.is_tuple_query)

							-- Remove suberfluous attributes for tuple queries to prevent
							-- automatic loading in the handlers.
						if query.is_tuple_query and then attached {PS_BACKEND_OBJECT} retrieved_entity as backend_obj then
							backend_obj.filter_attributes (filter_lookup)
						end

						new_object.set_backend_representation (retrieved_entity)
						to_build.extend (index)

					elseif processed = processed_interval then
							-- The list is no longer continuous, and we need to store the retrieved items in an array.
						create processed_array.make (2 * processed_interval.count)
						processed_interval.do_all (agent processed_array.extend)
						processed := processed_array
					end

					processed.extend (index)

				end
				batch_count := batch_count - 1
			end

			read_manager.build (to_build, query.object_initialization_depth)
			processed_items := processed.new_cursor
		end

	item: ANY
		do
--			Result := read_manager.item (processed_items.item).reflector.object
			check attached maybe_item as safe then
				Result := safe
			end
		end

	after: BOOLEAN
		do
			Result := subtypes.after and current_result.after and processed_items.after
		end

	maybe_item: detachable ANY
		do
			if 0 < query.object_initialization_depth and query.object_initialization_depth <= 2 then
				Result := read_manager.item (processed_items.item).reflector.object
			elseif attached {REFLECTED_OBJECT} read_manager.object_item (processed_items.item) as res then
				Result := res.object
			else
				Result := read_manager.object_item (processed_items.item)
			end
		end

end
