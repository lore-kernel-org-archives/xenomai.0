From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012221944080.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
	<alpine.DEB.1.10.1012221612360.11502@domain.hid>
	<1293031751.22129.21.camel@domain.hid>
	<alpine.DEB.1.10.1012221805260.11502@domain.hid>
	<alpine.DEB.1.10.1012221912220.11502@domain.hid>
	<1293042519.22129.91.camel@domain.hid>
	<alpine.DEB.1.10.1012221944080.11502@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Dec 2010 09:53:32 +0100
Message-ID: <1293094412.22129.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

On Wed, 2010-12-22 at 20:00 +0100, Kolja Waschk wrote:
> >> In my actual application however I never get past the rt_task_create, even if
> >> I set a breakpoint at some line somewhen later.
> 
> > What if you don't single step but (c)ontinue?
> 
> It "hangs".
> 
> But wait, just in this moment I discovered that I can get further if I
> set all priorities, i.e. priority of the main task (with rt_task_shadow) and the
> tasks where I couldn't get past rt_task_create, to 0 instead of 49 as before. Then at
> least "cont" works to the next breakpoint (stepping over with "next" still doesn't).
> 

This is typically a linuxthreads issue. Because there is a hidden
manager in the loop which wants to get involved into the process of
starting other threads, you can end up with priority issues breaking the
internal protocol. The manager thread is not known from Xenomai, so in
your case, it looks like starved from CPU albeit other threads expect it
to kick in at some point. This can only happen if some of the protocol
is based on busy waiting, which seems to be the case there.

> Debugging with gdb at the moment feels unnecessarily complicated. Very often
> the "next" doesn't bring me to the next line in my current source, but to some unexpected
> place (e.g. to a rt_mutex_acquire_inner() which was called in a subroutine four
> levels deeper..). I don't remember me becoming that confused with my previous
> setup (Blackfin 2.6.28 kernel with Xenomai 2.4.7) or in other C++ apps ;)

This is likely not related to the runtime environment at all. GDB has
not a great track record when it comes to multi-thread debugging even if
the situation improved over time, and things tend to get worse when
linuxthreads are in the loop because of the number of magic interactions
with the manager thread, and use of signals internally. What does have
an impact is your toolchain and how aggressive it is when optimizing the
code. What you see is not what you get in that case.

> 
> Kolja
> 

-- 
Philippe.



