MIME-Version: 1.0
In-Reply-To: <BE293433-495B-4C50-999A-298131FA6D94@domain.hid>
References: <BE293433-495B-4C50-999A-298131FA6D94@domain.hid>
Date: Fri, 8 Jul 2011 12:28:27 +0200
Message-ID: <CAPASGLqUz4ppyCkoUbvNGefmesOiLANVegrOP8_cwh6+4joPNw@domain.hid>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Anti-memory-fragmentation tricks for my Xenomai
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
To: Jeremy Friesner <jaf@domain.hid>
Cc: xenomai@xenomai.org

2011/7/8 Jeremy Friesner <jaf@domain.hid>:
> Hi all,
>
> I've got a Xenomai-based program that consists of a Xenomai real-time thr=
ead, plus a number of non-realtime/regular Linux threads.
>
> As the program runs, the regular Linux threads allocate and deallocate a =
fairly large number of 128kB buffers at various times, as well as doing var=
ious smaller allocations and deallocations of various sizes. =A0Pointers to=
 these buffers are passed to the Xenomai real-time thread when appropriate,=
 so that it can read data from the buffers as necessary. =A0(Steps are take=
n, of course, to make sure that the real-time thread stops reading from a b=
uffer before it gets deallocated by a non-real-time thread).
>
> This all works well, but there is one minor issue where I'd like to impro=
ve things: =A0after running for a while, the allocation and deallocation of=
 128kB buffers, interspersed with smaller allocations/deallocations, causes=
 fragmentation in the process's heap, with the end result that the process =
appears to be using a lot more memory than it actually has allocated. =A0Th=
is doesn't cause real problems (AFAICT), but because the GUI for the system=
 has a RAM Usage Indicator (that gets its info from /proc/meminfo, and disp=
lays total memory-usage as a percentage of physical RAM), users are prone t=
o wonder why so much RAM is being used even when the program is idle. =A0Th=
e heap fragmentation makes it look like there is a memory leak, even when t=
here technically isn't.
>
> So my question is, is there some Xenomai-friendly way for me to allocate,=
 say, 2GB of virtual address space, and manually control (from a non-realti=
me thread) when and how the underlying physical memory gets paged in and ou=
t of RAM? =A0That way I could do that at startup, and then allocate physica=
l 128kB buffers as needed from that dedicated address space, without worryi=
ng about fragmentation caused by mixing the 128kB allocations with smaller =
ones in a single heap.
>
> Note that I don't want to actually allocate 2GB of physical RAM at startu=
p, since that would defeat the purpose of minimizing the program's RAM foot=
print =A0(User: =A0"why is it using 2GB already? =A0I haven't even done any=
thing yet!"). =A0So it seems like the required mlockall(MCL_CURRENT | MCL_F=
UTURE) command might cause me some headaches here.
>
> I apologize if this is a newbiew/obvious question... any advice, or point=
ers to the web page(s) I should have read before posting will be welcomed. =
=A0:^)

If you know that the buffers you need have fixed size like 128kB then
you could write your own fixed-size buffer allocator.

Initially you create a memory zone whose size is say N*128kB + Management S=
pace
(N of your blocks plus space for managing the blocks) and then you
maintain the list of used
block using your own void* get_block(), release_block(void*).
The "only" problem here is to chose N, which should be the maximum
number of 128kB memory block you need
at any time.

For the varying size part of the allocation, may be you can have a look at =
TLSF:
http://rtportal.upv.es/rtmalloc/

may be TLSF can handle the fixed sized block for you in a separate
memory pool as well.


--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

