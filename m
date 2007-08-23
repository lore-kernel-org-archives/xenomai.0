From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46C984DC.6090203@domain.hid>
References: <46C984DC.6090203@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 22:45:33 +0200
Message-Id: <1187901933.6009.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai degrades syscall time on PPC405
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
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Mon, 2007-08-20 at 14:11 +0200, Dirk Eibach wrote:
> Hello,
> 
> I am trying to understand some performance problems I ran into on my 
> xenomai system.
> 
> The testcode I attached performs a syscall(gettimeofday). Measuring time on 
> a vanilla Kernel gives the following output:
> 
> ticks for ppc_getccounter: 116, for gettimeofday: 1479
> 
> The same kernel with xenomai patched in gives this:
> 
> ticks for ppc_getccounter: 116, for gettimeofday: 4278
> 
> Is this the expected behaviour? Why is the time for a system call nearly 3 
> times as much?
> 

When reporting figures, please report all of them. Here is your test ran
on a 405GPr, linux-2.6.14, I-pipe 1.5-03, with full output:

bash-3.00# ./ppc405_rt 
ticks for ppc_getccounter: 122, for gettimeofday: 7337
ticks for ppc_getccounter: 208, for gettimeofday: 2816
ticks for ppc_getccounter: 210, for gettimeofday: 2512
ticks for ppc_getccounter: 174, for gettimeofday: 2622
ticks for ppc_getccounter: 174, for gettimeofday: 2320
ticks for ppc_getccounter: 208, for gettimeofday: 2634
ticks for ppc_getccounter: 174, for gettimeofday: 2344
ticks for ppc_getccounter: 208, for gettimeofday: 2660
ticks for ppc_getccounter: 174, for gettimeofday: 2320
ticks for ppc_getccounter: 208, for gettimeofday: 2816
ticks for ppc_getccounter: 208, for gettimeofday: 2734
ticks for ppc_getccounter: 208, for gettimeofday: 2802
...

Only the first shot exhibits a pathological latency, and switching on
CONFIG_XENO_OPT_DEBUG_NUCLEUS explains why:

# dmesg

...
Looking up port of RPC 100003/2 on 192.168.0.7
Looking up port of RPC 100005/1 on 192.168.0.7
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 128k init
Xenomai: Switching ppc405_rt to secondary mode after exception #1025 from user-space at 0xfe54f40 (pid 248)

This is confirmed by the task stats:

# cat /proc/xenomai/stat

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          2          0     00400080   99.9  ROOT
  0  248    1          1          1*    00300380    0.0  ppc405_rt
  0  0      0          48031      0     00000000    0.1  IRQ32: [timer]

(*) 1 page fault caught in primary mode, causing a Xenomai mode switch.

The test program hits a minor fault, due to a virtual memory management
artefact, which in turn forces a Xenomai switch for your task from
primary to secondary mode, in order to process the fault gracefully
(basically mapping a missing page table entry). 7 us is the time needed
to yield the control of the task to the regular kernel, then handle the
fault in Linux context, then eventually perform the syscall. This is a
known issue, and a solution may be available at some point, but not yet.

This mailing list contains other reports of the same issue, and detailed
explanations.

Regarding the other figures in the 2-3 us range, it is absolutely true
that Xenomai adds some overhead to the system call path which may get
noticeable on low-end boards. This is due to the pipelining of system
calls to the Xenomai domain: there is more code to execute than the
regular Linux has to run for the same task. This value may improve too
over time, since we do have a few opportunities for optimization here.

Last point: your measure do not take into account the possibility for
the syscall path to be preempted by a real-time interrupt, or even by a
plain Linux one after the task has switched to secondary mode, so you
should always read such data with a grain of salt. In any case, you
should never rely on a single sample.

> #include <stdio.h>
> #include <sys/time.h>
> #include <time.h>
> 
> static void
> ppc_getcounter(unsigned long long *v)
> {
> 	register unsigned long tbu, tb, tbu2;
> 
>      loop:
> 	asm volatile ("mftbu %0" : "=r" (tbu) );
> 	asm volatile ("mftb  %0" : "=r" (tb)  );
> 	asm volatile ("mftbu %0" : "=r" (tbu2));
> 	if (__builtin_expect(tbu != tbu2, 0)) goto loop;
> 
> 	/* The slightly peculiar way of writing the next lines is
> 	compiled better by GCC than any other way I tried. */
> 	((long*)(v))[0] = tbu;
> 	((long*)(v))[1] = tb;
> }
> 
> int main(int argc, char* argv[])
> {
> 	while(1) {
> 		struct timeval tv;
> 		unsigned long long count0, count1, count2;
> 		ppc_getcounter(&count0);
> 		ppc_getcounter(&count1);
> 		gettimeofday(&tv, NULL);
> 		ppc_getcounter(&count2);
> 		printf("ticks for ppc_getccounter: %lld, for gettimeofday: %lld\n",
> 			count1 - count0, count2- count1);
> 		sleep(1);
> 	}
> }
> 
> 
> Cheers
-- 
Philippe.



