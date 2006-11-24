Subject: Re: [Xenomai-help] Debugging in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4566CC51.20400@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
	<200611241020.45706.peter.soetens@domain.hid>  <4566CC51.20400@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 12:09:02 +0100
Message-Id: <1164366542.4973.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-24 at 11:41 +0100, Jan Kiszka wrote:
> Peter Soetens wrote:
> > On Thursday 23 November 2006 16:25, Daniel Schnell wrote:
> >> One of the next steps would be finding out which actual function back
> >> trace the suspicious thread has. So I execute gdb and try to attach to
> >> the appropriate process, which works. Problem: sending Ctrl-C doesn't
> >> work, independant of if gdb is executed via ssh or serial console. So I
> >> cannot stop the actual program beeing debugged, rendering the gdb
> >> approach useless. Also sending SIGINT to the GDB process doesn't work.
> >> It seems to be simply ignored. As I understand CTRL-C is effectively
> >> sending SIGINT and is sent to GDB itself and not to the underlying appl.
> > 
> > We had a similar issue while debugging an RTNET app (main thread + 1 xenomai 
> > posix skin thread) under xenomai. I don't recall exactly the circumstances, 
> > but the app was blocked on a socket, and a Ctrl-C did not work. A 'killall 
> > gdb' (SIGTERM) did come through and killed gdb. If you (the Xeno/RTNet 
> > developers)'re interested in this case, I'll see if I can get more info.
> 
> You're welcome.
> 
> I just checked the behaviour of examples/xenomai/posix/eth_p_all over
> gdb. I can interrupt the blocking recv - so far so good - but the
> syscall is unfortunately not replayed when continuing. Instead, the
> program just terminates because some error (EINTR) is reported to the
> application.
> 
> [Too lazy to dig:] Philippe, isn't syscall restarting after an
> interruption the job of the Xenomai nucleus?

Yes, it is, and normally, it does so.

syscall():
	return -EINTR
do_hi/lo_syscall_event():
	request_syscall_restart():
		if (syscall_return == -EINTR) pass back -ERESTARTSYS
Linux ret_from_syscall:
	do_notify_resume upon sig, which eventually checks for
	-ERESTARTSYS then fixes $pc to restart the interrupted call.
	This is regular Linux code, Xenomai relies on it, but does not
	change it.

Issue #1: a blocking Xenomai syscall does not detect the XNBREAK
condition properly upon return from xnpod_suspend_thread() or
xnsynch_sleep_on(), therefore does not pass back -EINTR to the nucleus
when this bit is raised for the current thread, which causes the signal
to be left over. Usually, the consequence of this is "please find the
reset button, and exercise your firmware once more". This said, weird
behaviour instead of total freeze has been experienced in this context,
too.

Issue #2: user-space switches signal handling to SysV behaviour instead
of the BSDish one, thus preventing syscall restart in favour of getting
a failure return code with errno == -EINTR. Usually not the case, but,
this deserves a verification.

Issue #3: Oops. We have a bug.

> 
> Jan
> 
-- 
Philippe.



