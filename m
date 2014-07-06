Message-ID: <53B964DC.1020004@xenomai.org>
Date: Sun, 06 Jul 2014 17:01:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 11:48 AM, Matthias Schneider wrote:
> Hi all,
> 
> commit 
> 
> 2014-06-02 c20fceb147e337e2379b29ecd81b943318c7fbc7 
> (patch) cobalt/timer: avoid periodic timer drift
> 
> seems to cause an endless kernel loop in one of my
> freertos demos. The issue does not occur when 
> reverting this commit.
> 
> Investigating the issue, can see the following:
> 
> #0  0xc00ba45c in mach_arm_nodiv_llimd (rhs_integ=<optimized out>, frac=<optimized out>, op=<optimized out>)
>     at arch/arm/xenomai/include/asm/xenomai/uapi/arith.h:120
> #1  xnclock_core_ns_to_ticks (ns=0) at kernel/xenomai/clock.c:52
> #2  0xc00baf34 in xnclock_ns_to_ticks (clock=<optimized out>, ns=<optimized out>)
>     at include/xenomai/cobalt/kernel/clock.h:204
> #3  xntimer_update_date (timer=0xde706518) at include/xenomai/cobalt/kernel/timer.h:268
> #4  xnclock_tick (clock=0xc06b1138 <nkclock>) at kernel/xenomai/clock.c:644
> #5  0xc00bcbcc in xnintr_core_clock_handler () at kernel/xenomai/intr.c:121
> #6  0xc0095a98 in dispatch_irq_head (irq=<optimized out>) at kernel/ipipe/core.c:1179
> 
> This seems to be the endless loop:
> 642                     do {
> 643      timer->periodic_ticks += interval_ticks;
> 644      xntimer_update_date(timer);
> 645                     } while (xntimerh_date(&timer->aplink) < now + clock->gravity);
> 
> gdb) info locals
> timerq = 0xdebdae98
> now = 4257712977
> interval_ticks = 0
> timer = 0xde706518
> delta = <optimized out>
> h = 0xde706518
> 
> (gdb) print *timer
> $1 = {
>   aplink = {
>     link = {
>       next = 0x100100, 
>       prev = 0x200200
>     }, 
>     key = 0, 
>     prio = 999999999
>   }, 
>   adjlink = {
>     next = 0x0 <__vectors_start>, 
>     prev = 0x0 <__vectors_start>
>   }, 
>   status = 1, 
>   interval = 0, 
>   interval_ns = 0, 
>   periodic_ticks = 0, 
>   start_date = 0, 
>   pexpect_ticks = 0, 
>   sched = 0xc06b1610 <nksched>, 
>   handler = 0xc00c7dc4 <timeout_handler>, 
>   name = "CREATOR", '\000' <repeats 24 times>, 
>   handler_name = 0xc05ad429 "timeout_handler", 
>   next_stat = {
>     next = 0xde706624, 
>     prev = 0xde705c24
>   }, 
>   scheduled = {
>     counter = 3
>   }, 
>   fired = {
>     counter = 1
>   }
> }
> (gdb) print *clock
> $2 = {
>   wallclock_offset = 200209, 
>   resolution = 1, 
>   gravity = 140, 
>   name = 0xc05ac815 "coreclk", 
>   timerdata = 0xdebdae98, 
>   id = -1, 
>   vfile = {
>     entry = {
>       pde = 0xde1b8700, 
>       file = 0x0 <__vectors_start>, 
>       lockops = 0xc06b2c20 <xnvfile_nucleus_lock>, 
>       refcnt = 0, 
>       private = 0xc06b1138 <nkclock>
>     }, 
>     privsz = 4, 
>     datasz = 104, 
>     tag = 0xc06b117c <nkclock+68>, 
>     ops = 0xc06b1120 <vfile_clock_ops>
>   }, 
>   revtag = {
>     rev = 36
>   }, 
>   statq = {
>     next = 0xc06b18d4 <nksched+708>, 
>     prev = 0xde706e24
>   }, 
>   nrtimers = 24
> }
> 
> Does anyone see right away what is going on wrong 
> or shall I continue investigating the issue?

You seem to have created a periodic timer with a null period. Could you
post a sample code allowing to reproduce this issue?

-- 
                                                                Gilles.

