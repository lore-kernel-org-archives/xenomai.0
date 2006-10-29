Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200610292202.49810.niklaus.giger@domain.hid>
References: <200610252346.34150.niklaus.giger@domain.hid>
	<200610281940.10654.niklaus.giger@domain.hid>
	<4543A31B.1000500@domain.hid>
	<200610292202.49810.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 22:15:26 +0100
Message-Id: <1162156526.4966.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Sun, 2006-10-29 at 22:02 +0100, Niklaus Giger wrote:

[...]

> The trap 0 in  /proc/xenomai/fault seems to count on each invocation of simple
>   0:           51    (Data or instruction access)

This means that we do encounter minor or major faults which end up being
gracefully handled. This could also happen upon request to expand the
process stack (conversely, does raising the size of the process stack at
init changes anything?). You may want to instrument
arch/ppc/mm/fault.c:do_page_fault, in order to identify which faults are
processed on behalf of the test thread.

> gdb however no does not show anything abnormal, as it says now
> > This GDB was configured as "ppc-linux"...Using host libthread_db library
> > "/lib/tls/libthread_db.so.1".
> >
> > (gdb) run
> > Starting program: /bin/simple
> > [Thread debugging using libthread_db enabled]
> > [New Thread 805422032 (LWP 639)]
> > root_thread_init 4[New Thread 805455088 (LWP 642)]
> >
> > Program exited normally.
> > (gdb) quit
> 
> Though I am still puzzled.
> 
> Best regards
> 
-- 
Philippe.



