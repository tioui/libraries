note

	description:

	"[
		Eiffel AST printers.
		Use UTF-8 encoding. Note that the byte order mark (BOM) for UTF-8 is not
		printed unless it was found in the class file when parsing the class text
		and `bom_enabled' is True, or it is explicitly printed by calling `print_bom'.
	]"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_AST_PRINTER

inherit

	ET_AST_ITERATOR
		rename
			make as make_null
		redefine
			make_null,
			process_break,
			process_binary_integer_constant,
			process_c1_character_constant,
			process_c2_character_constant,
			process_c3_character_constant,
			process_class,
			process_hexadecimal_integer_constant,
			process_octal_integer_constant,
			process_regular_integer_constant,
			process_underscored_integer_constant,
			process_regular_real_constant,
			process_underscored_real_constant,
			process_regular_manifest_string,
			process_special_manifest_string,
			process_verbatim_string,
			process_symbol,
			process_token
		end

	KL_SHARED_STREAMS

create

	make, make_null

feature {NONE} -- Initialization

	make (a_file: like file)
			-- Create a new AST printer, using `a_file' as output file.
		require
			a_file_not_void: a_file /= Void
			a_file_is_open_write: a_file.is_open_write
		do
			file := a_file
			bom_enabled := True
			create buffer.make (4)
		ensure
			file_set: file = a_file
			bom_enabled: bom_enabled
		end

	make_null
			-- Create a new AST printer, initialized with a null output stream.
		do
			make (null_output_stream)
		ensure then
			file_set: file = null_output_stream
			bom_enabled: bom_enabled
		end

feature -- Access

	file: KI_CHARACTER_OUTPUT_STREAM
			-- Output file

feature -- Setting

	set_file (a_file: like file)
			-- Set `file' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_is_open_write: a_file.is_open_write
		do
			file := a_file
		ensure
			file_set: file = a_file
		end

	set_null_file
			-- Set `file' to `null_output_stream'.
		do
			file := null_output_stream
		ensure
			file_set: file = null_output_stream
		end

feature -- BOM

	print_bom
			-- Byte order mark (BOM) for UTF-8 (0xEF,0xBB,0xBF)
			-- See http://en.wikipedia.org/wiki/Byte_order_mark
		do
			file.put_string ({UC_UTF8_ROUTINES}.utf8_bom)
		end

	bom_enabled: BOOLEAN
			-- Should the byte order mark (BOM) for UTF-8 be printed when
			-- it was found in the class file when parsing the class text?
			-- `print_bom' should be called explicitly otherwise.

	set_bom_enabled (b: BOOLEAN)
			-- Set `bom_enabled' to `b'.
		do
			bom_enabled := b
		ensure
			bom_enabled_set: bom_enabled = b
		end

feature {ET_AST_NODE} -- Processing

	process_binary_integer_constant (a_constant: ET_BINARY_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_break (a_break: detachable ET_BREAK)
			-- Process `a_break'.
		do
			if a_break /= Void then
				file.put_string (a_break.text)
			end
		end

	process_c1_character_constant (a_constant: ET_C1_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_character ('%'')
			buffer.wipe_out
			{UC_UTF8_ROUTINES}.append_natural_32_code_to_utf8 (buffer, a_constant.literal.natural_32_code)
			file.put_string (buffer)
			file.put_character ('%'')
			process_break (a_constant.break)
		end

	process_c2_character_constant (a_constant: ET_C2_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_character ('%'')
			file.put_character ('%%')
			file.put_character (a_constant.literal)
			file.put_character ('%'')
			process_break (a_constant.break)
		end

	process_c3_character_constant (a_constant: ET_C3_CHARACTER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_character ('%'')
			file.put_character ('%%')
			file.put_character ('/')
			file.put_string (a_constant.literal)
			file.put_character ('/')
			file.put_character ('%'')
			process_break (a_constant.break)
		end

	process_class (a_class: ET_CLASS)
			-- Process `a_class'.
		do
			if bom_enabled and then a_class.has_utf8_bom then
				print_bom
			end
			precursor (a_class)
		end
	process_hexadecimal_integer_constant (a_constant: ET_HEXADECIMAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_octal_integer_constant (a_constant: ET_OCTAL_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_regular_integer_constant (a_constant: ET_REGULAR_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_regular_manifest_string (a_string: ET_REGULAR_MANIFEST_STRING)
			-- Process `a_string'.
		do
			precursor (a_string)
			file.put_character ('%"')
			file.put_string (a_string.literal)
			file.put_character ('%"')
			process_break (a_string.break)
		end

	process_regular_real_constant (a_constant: ET_REGULAR_REAL_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_special_manifest_string (a_string: ET_SPECIAL_MANIFEST_STRING)
			-- Process `a_string'.
		do
			precursor (a_string)
			file.put_character ('%"')
			file.put_string (a_string.literal)
			file.put_character ('%"')
			process_break (a_string.break)
		end

	process_symbol (a_symbol: ET_SYMBOL)
			-- Process `a_symbol'.
		do
			file.put_string (a_symbol.text)
			process_break (a_symbol.break)
		end

	process_token (a_token: ET_TOKEN)
			-- Process `a_token'.
		do
			file.put_string (a_token.text)
			process_break (a_token.break)
		end

	process_underscored_integer_constant (a_constant: ET_UNDERSCORED_INTEGER_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_underscored_real_constant (a_constant: ET_UNDERSCORED_REAL_CONSTANT)
			-- Process `a_constant'.
		do
			precursor (a_constant)
			file.put_string (a_constant.literal)
			process_break (a_constant.break)
		end

	process_verbatim_string (a_string: ET_VERBATIM_STRING)
			-- Process `a_string'.
		do
			precursor (a_string)
			file.put_character ('%"')
			file.put_string (a_string.marker)
			if a_string.is_left_aligned then
				file.put_character ('[')
			else
				file.put_character ('{')
			end
			file.put_string (a_string.open_white_characters)
			file.put_string (a_string.literal)
			file.put_string (a_string.close_white_characters)
			if a_string.is_left_aligned then
				file.put_character (']')
			else
				file.put_character ('}')
			end
			file.put_string (a_string.marker)
			file.put_character ('%"')
			process_break (a_string.break)
		end

feature {NONE} -- Implementation

	buffer: STRING
			-- Buffer to print UTF-8 encoded strings

invariant

	file_not_void: file /= Void
	file_is_open_write: file.is_open_write
	buffer_not_void: buffer /= Void

end
