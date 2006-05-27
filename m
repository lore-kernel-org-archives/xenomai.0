MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o29282lF/f"
Content-Transfer-Encoding: 7bit
Message-ID: <17528.29962.534628.683176@domain.hid>
Date: Sat, 27 May 2006 17:49:30 +0200
Subject: Re: [Xenomai-core] [sim] ... doesn't build
In-Reply-To: <4478718E.1010704@domain.hid>
References: <44786C8F.9070201@domain.hid>
	<17528.28463.599578.54637@domain.hid>
	<4478718E.1010704@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--o29282lF/f
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Hi,
 > >  > 
 > >  > I just tried to get the simulator from trunk built but failed here:
 > >  > 
 > >  > In file included from ../../../../xenomai/sim/../include/posix/posix.h:29,
 > >  >                  from
 > >  > ../../../../xenomai/sim/../ksrc/skins/posix/internal.h:24,
 > >  >                  from
 > >  > ../../../../xenomai/sim/../ksrc/skins/posix/thread.h:23,
 > >  >                  from
 > >  > ../../../../xenomai/sim/../ksrc/skins/posix/sched.c:48:
 > >  > ../../../../xenomai/sim/../include/posix/pthread.h:246: conflicting
 > >  > types for `pthread_attr_getaffinity_np'
 > >  > /usr/include/pthread.h:383: previous declaration of
 > >  > `pthread_attr_getaffinity_np'
 > >  > ../../../../xenomai/sim/../include/posix/pthread.h:249: conflicting
 > >  > types for `pthread_attr_setaffinity_np'
 > >  > /usr/include/pthread.h:377: previous declaration of
 > >  > `pthread_attr_setaffinity_np'
 > >  > 
 > >  > Looks like glibc-2.4 (that one comes with my opensuse 10.1) now also
 > >  > knows get/setaffinity. Prototypes of glibc:
 > >  > 
 > >  > extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
 > >  >                                         size_t __cpusetsize,
 > >  >                                         __const cpu_set_t *__cpuset)
 > >  > __THROW;
 > >  > extern int pthread_attr_getaffinity_np (__const pthread_attr_t *__attr,
 > >  >                                         size_t __cpusetsize,
 > >  >                                         cpu_set_t *__cpuset) __THROW;
 > >  > 
 > > 
 > > Could you try the attached patch ?
 > > 
 > 
 > Takes me further, now stops like this:
 > 
 > if ../../gcic/gcic -DHAVE_CONFIG_H -I.
 > -I../../../../xenomai/sim/skins/posix -I../../include  -D_GNU_SOURCE
 > -D__IN_XENO__ --gcic-backend=/usr/src/xenomai/inst//libexec/gcic
 > --skin-code  -I../../../../xenomai/sim/../ksrc/skins
 > -I../../../../xenomai/sim/../include
 > -I../../../../xenomai/sim/skins/posix/..   -g -MT timer.o -MD -MP -MF
 > ".deps/timer.Tpo" -c -o timer.o
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c; \
 > then mv -f ".deps/timer.Tpo" ".deps/timer.Po"; else rm -f
 > ".deps/timer.Tpo"; exit 1; fi
 > In file included from /usr/include/sys/types.h:270,
 >                  from ../../../../xenomai/sim/../include/nucleus/types.h:32,
 >                  from ../../../../xenomai/sim/../include/nucleus/queue.h:24,
 >                  from ../../../../xenomai/sim/../include/nucleus/timer.h:23,
 >                  from
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:24:
 > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
 > defines no instances
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
 > `pse51_timer_create':
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:186: warning:
 > assignment makes pointer from integer without a cast
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
 > `pse51_timer_delete':
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:223: array subscript
 > is not an integer
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
 > `pse51_timer_settime':
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:344: array subscript
 > is not an integer
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
 > `pse51_timer_gettime':
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:437: array subscript
 > is not an integer
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
 > `pse51_timer_getoverrun':
 > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:485: array subscript
 > is not an integer

Looks like timer_t is no longer an integer type, try the attached patch.

 > 
 > >  > Moreover, I get tons of this warning:
 > >  > 
 > >  > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
 > >  > defines no instances
 > >  > 
 > >  > But this is an "imported" issue, isn't it? Likely due to some picky gcc
 > >  > switch during the simulator build.
 > > 
 > > It depends on what is defined at line 69 of pthreadtypes.h...
 > > 
 > 
 > typedef union
 > {
 >   struct __pthread_mutex_s
 >   {
 >     int __lock;
 >     unsigned int __count;
 >     int __owner;
 >     /* KIND must stay at this position in the structure to maintain
 >        binary compatibility.  */
 >     int __kind;
 >     unsigned int __nusers;
 >     __extension__ union
 >     {
 >       int __spins;
 >       __pthread_slist_t __list;
 >     };				/* >>> line 69 <<< */
 >   } __data;
 >   char __size[__SIZEOF_PTHREAD_MUTEX_T];
 >   long int __align;
 > } pthread_mutex_t;

Looking at gcc 2.95 documentation, it seems that unname unions are not
supported.

-- 


					    Gilles Chanteperdrix.

--o29282lF/f
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-timer-c.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/posix/timer.c
===================================================================
--- ksrc/skins/posix/timer.c	(revision 1141)
+++ ksrc/skins/posix/timer.c	(working copy)
@@ -183,7 +183,7 @@
     timer->clockid = clockid;
     xnlock_put_irqrestore(&nklock, s);
 
-    *timerid = timer - timer_pool;
+    *timerid = (timer_t) (timer - timer_pool);
 
     return 0;
 
@@ -220,7 +220,7 @@
 
     xnlock_get_irqsave(&nklock, s);
 
-    timer = &timer_pool[timerid];
+    timer = &timer_pool[(unsigned long) timerid];
 
     if (!xntimer_active_p(&timer->timerbase))
         goto unlock_and_einval;
@@ -341,7 +341,7 @@
 
     xnlock_get_irqsave(&nklock, s);
 
-    timer = &timer_pool[timerid];
+    timer = &timer_pool[(unsigned long) timerid];
 
     if (!xntimer_active_p(&timer->timerbase))
         goto unlock_and_einval;
@@ -434,7 +434,7 @@
 
     xnlock_get_irqsave(&nklock, s);
 
-    timer = &timer_pool[timerid];
+    timer = &timer_pool[(unsigned long) timerid];
 
     if (!xntimer_active_p(&timer->timerbase))
         goto unlock_and_einval;
@@ -482,7 +482,7 @@
 
     xnlock_get_irqsave(&nklock, s);
 
-    timer = &timer_pool[timerid];
+    timer = &timer_pool[(unsigned long) timerid];
 
     if (!xntimer_active_p(&timer->timerbase))
         goto unlock_and_einval;

--o29282lF/f--

