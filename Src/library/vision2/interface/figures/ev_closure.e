--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision closure. Closure of a figure."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLOSURE

create
	make

feature -- Initialization

	make is
			-- Create a closure
		do
			create up_left.make
			create down_right.make
			empty := True
			infinite := False
		end 
	
feature -- Access 

	up_left: EV_POINT
			-- Upper left corner

	down_right: EV_POINT
			-- Bottom right corner

feature -- Comparison

	includes (other: like Current): BOOLEAN is
			-- Does the rectangle surround `other'?
		require
			rectangle_exists: other /= Void
			rectangle_not_empty: not other.empty
		do
			if not infinite  and not other.infinite then
				if not empty then
					Result := other.up_left >= up_left and then
							other.down_right <= down_right
				end
			else
				Result := True
			end
		end

	contains (point: EV_POINT): BOOLEAN is
		-- Does the rectangle contain 'point'
		require
			not_void: point /= Void
		do
			if not infinite then
				if not empty then
					Result := point >= up_left and point<= down_right
				end
			else
				Result := True
			end
		end

	override (clip: EV_RECTANGLE): BOOLEAN is
			-- Does rectangle override clip zone ?
		require
			clip /= Void and then down_right /= Void 
			and up_left /= Void  and clip.upper_left /= Void
		do
			if not infinite then
				Result := not empty
					and then segment_override (clip.upper_left.x,
								clip.upper_left.x + clip.width,
								up_left.x, down_right.x)
					and then segment_override (clip.upper_left.y,
								clip.upper_left.y + clip.height,
								up_left.y, down_right.y)
			else
				Result := True
			end
		end

	segment_override (a1, b1, a2, b2 : INTEGER): BOOLEAN is
		require
			b1 >= a1 and b2 >= a2
		do
				if not infinite then
					Result := ((a1 >= a2) and then (a1 <= b2))
						or else ((a1 <= a2) and then (a2 <= b1))
				else
					Result := True
				end
		end


feature -- Conversion

	as_clip: EV_RECTANGLE is
			-- `clip` equivallent of `Current`
		do
			create Result.make
			Result.set (up_left, down_right.x-up_left.x, down_right.y-up_left.y)
		end

feature -- Element change

	set (x, y, width, height: INTEGER) is
			-- Set coordinates and size of closure.
		require
			width >= 0
			height >= 0
		do
			wipe_out
			if width+height > 0 then
				up_left.set (x, y)
				down_right.set (x+width, y+height)
				empty := False
			else
				empty := True
			end
		end

	set_bound (p1, p2: EV_POINT) is
			-- Set coordinates
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			wipe_out
			enlarge (p1)
			enlarge (p2)
		end 

	enlarge (p: EV_POINT) is
			-- Enlarge the rectangle in order to include `p'
		require
			point_exists: p /= Void
		do
			if not infinite then
				if empty then
					up_left.set (p.x, p.y)
					down_right.set (p.x, p.y)
					empty := False
				else
					up_left.set_min (p)
					down_right.set_max (p)
				end
			end
		ensure
			not empty
		end

	merge (other: like Current) is
			-- Enlarge the rectangle in order to include `other'.
		require
			rectangle_exists: other /= Void
		do
			if not infinite and not other.infinite then
				if not other.empty then
					if empty then
						up_left.set (other.up_left.x, other.up_left.y)
						down_right.set (other.down_right.x, other.down_right.y)
						empty := False
					else
						up_left.set_min (other.up_left)
						down_right.set_max (other.down_right)
					end
				end
			else
				set_infinite
			end
		end

	merge_clip (clip: EV_RECTANGLE) is
			-- Enlarge the rectangle in order to include `clip'.
		require
			clip_exists: clip /= Void
		local
			clip_up_left, clip_down_right: EV_POINT
		do
			if not infinite then
				create clip_up_left.set (clip.upper_left.x, clip.upper_left.y)
				create clip_down_right.set (clip.upper_left.x+clip.width,
											clip.upper_left.y+clip.height)
				if empty then
					up_left.set (clip_up_left.x, clip_up_left.y)
					down_right.set (clip_down_right.x, clip_down_right.y)
					empty := False
				else
					up_left.set_min (clip_up_left)
					down_right.set_max (clip_down_right)
				end
			end
		ensure
			not empty
		end

	set_infinite is
			-- Set current infinite.
		do
			infinite := True
			empty := False
		ensure
			not_empty: not empty
		end

	set_finite is
			-- Set current finite.
		do
			infinite := False
		end

feature -- Removal

	wipe_out is
			-- Wipe out the closure.
		do
			empty := True
			infinite := False
		ensure
			empty
		end 


feature -- Status report

	empty: BOOLEAN
			-- Is the closure empty ?

	infinite: BOOLEAN
			-- Infinite closure ?

invariant
	empty_implies_not_infinite: empty implies not infinite
	infinite_implies_not_empty: infinite implies not empty


end -- class EV_CLOSURE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/29 18:09:07  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.6  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:46  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.4.2.2.3  2000/01/27 19:30:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.4.2.2.2  2000/01/24 23:54:21  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.3.4.2.2.1  1999/11/24 17:30:37  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
