class MT_TIME_STREAM_EXTERNAL 

feature {NONE} -- Implementation MT_TIME_STREAM

    c_time_enum_start : POINTER is
        -- Use MtTimeEnumStart
    external
        "C"
    end -- c_time_enum_start

    c_next_time(sid:POINTER) : POINTER is
        -- Use MtNextTime
    external
        "C"
    end -- c_next_time

    c_time_enum_end(sid:POINTER) is
        -- Use MtTimeEnumEnd
    external
        "C"
    end -- c_time_enum_end


end -- class MT_TIME_STREAM_EXTERNAL

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

