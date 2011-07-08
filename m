From: Jeremy Friesner <jaf@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Thu, 7 Jul 2011 22:48:32 -0700
Message-Id: <BE293433-495B-4C50-999A-298131FA6D94@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Xenomai-help] Anti-memory-fragmentation tricks for my Xenomai
	process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I've got a Xenomai-based program that consists of a Xenomai real-time =
thread, plus a number of non-realtime/regular Linux threads.

As the program runs, the regular Linux threads allocate and deallocate a =
fairly large number of 128kB buffers at various times, as well as doing =
various smaller allocations and deallocations of various sizes.  =
Pointers to these buffers are passed to the Xenomai real-time thread =
when appropriate, so that it can read data from the buffers as =
necessary.  (Steps are taken, of course, to make sure that the real-time =
thread stops reading from a buffer before it gets deallocated by a =
non-real-time thread).

This all works well, but there is one minor issue where I'd like to =
improve things:  after running for a while, the allocation and =
deallocation of 128kB buffers, interspersed with smaller =
allocations/deallocations, causes fragmentation in the process's heap, =
with the end result that the process appears to be using a lot more =
memory than it actually has allocated.  This doesn't cause real problems =
(AFAICT), but because the GUI for the system has a RAM Usage Indicator =
(that gets its info from /proc/meminfo, and displays total memory-usage =
as a percentage of physical RAM), users are prone to wonder why so much =
RAM is being used even when the program is idle.  The heap fragmentation =
makes it look like there is a memory leak, even when there technically =
isn't.

So my question is, is there some Xenomai-friendly way for me to =
allocate, say, 2GB of virtual address space, and manually control (from =
a non-realtime thread) when and how the underlying physical memory gets =
paged in and out of RAM?  That way I could do that at startup, and then =
allocate physical 128kB buffers as needed from that dedicated address =
space, without worrying about fragmentation caused by mixing the 128kB =
allocations with smaller ones in a single heap.

Note that I don't want to actually allocate 2GB of physical RAM at =
startup, since that would defeat the purpose of minimizing the program's =
RAM footprint  (User:  "why is it using 2GB already?  I haven't even =
done anything yet!").  So it seems like the required =
mlockall(MCL_CURRENT | MCL_FUTURE) command might cause me some headaches =
here.

I apologize if this is a newbiew/obvious question... any advice, or =
pointers to the web page(s) I should have read before posting will be =
welcomed.  :^)

Jeremy=

