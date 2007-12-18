Date: Tue, 18 Dec 2007 13:48:05 -0800 (PST)
From: Jonathan Day <imipak@domain.hid>
In-Reply-To: <47680FC4.1030505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <503431.90416.qm@domain.hid>
Subject: Re: [Adeos-main] Using ADEOS to run multiple Linux kernels
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

I think I can get away without strict memory
protection, because of quirks in the way the project
has been defined. (One kernel will be controlling the
hardware, the other kernel will be running management
applications.)

This means that I can get away with far less than what
would be needed in the general case. There is no risk
of one kernel interfering with hardware operations of
the other. The risk being tackled is that of a driver
failure paralyzing the kernel running the
applications.

Xen would, unfortunately, not work for this. Hardware
is controlled entirely by the host OS, so if a driver
crashes, it'll take out the whole system. On the other
hand, two full kernels running in parallel with no
other protection or isolation should be adequate.

Cooperative multitasking the two kernels is more of an
issue. Even so, the level of protection needed to
handle a hard lockup placing hardware in an unknown or
unrecoverable state is outside what can be done for
this project, and soft lockups can be handled with
kexec or the software watchdog.

This reduces the problem to three parts:

a) Getting two Linux kernels to load over ADEOS
b) Getting ADEOS to multitask or task switch them
c) Convincing Linux' recovery to be ADEOS-friendly

Everything else drops out of the equation because of
the project definition, which is a Good Thing. The
third part should also be relatively easy - it's just
a matter of getting ADEOS to reload that kernel.
Provided moderately heavy tasks can be defined during
normal operation and not just at initialization time,
that should not pose a problem, and I see nothing in
ADEOS that precludes that.

Given RTAI supports the Linux kernel and realtime
threads, the task switching should be a non-issue as
well, so long as more than one task can be a kernel.
Since passing interrupts along a chain would not be
that useful if there can be only one target, this
would seem to answer the question of can it be done.
The remaining problem there is that I can't find an
example of it actually being done.

That just leaves loading two Linux kernels in the
first place. Again, without an example of this being
done, it's not altogether obvious what steps are
needed to do this. Two kernels run side-by-side is
quite a different proposition from one kernel inside
another a-la usermode Linux.

Personally, I'd have no problems hacking kernel code
to get this working. I'm probably going to have to
make some changes to both ADEOS and Linux to do what I
want, the way that I want it. The worst-case is that
nobody has got an example close enough to what I want
to do for me to reuse code/ideas. That's only going to
be a problem, though, if I don't know that I'm working
from the worst case.

Hopefully, there's some project - however incomplete -
that does do at least some of what I want. That would
be sufficient. I can do the rest from there. Finding
that example, though, is proving tough and that's
where I'm hoping for help at this point.

Jonathan

--- Jan Kiszka <jan.kiszka@domain.hid> wrote:
> I guess you are rather looking for para-virtualized
> Linux over something
> like the Xen hypervisor. This comes with some
> overhead, but it is fairly
> low. The point is that you need memory protection
> for crash recovery -
> otherwise you risk that the crash corrupts memory of
> the backup kernel.
> And with memory protection comes the
> (para-)virtualization overhead.
> 
> In contrast, Adeos, also in its broader original
> design, is intended to
> run multiple kernel _cooperatively_, and that
> conflicts with your
> requirement of crash isolation.



      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

