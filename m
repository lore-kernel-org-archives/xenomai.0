Subject: Re: [Xenomai-core] [BUG] normal pthreads broken
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <449AC16F.3020708@domain.hid>
References: <449AC16F.3020708@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:50:47 +0200
Message-Id: <1151052647.4438.20.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-06-22 at 18:12 +0200, Jan Kiszka wrote:
> Hi Gilles,
> 
> I think some regression slipped into the rt-pthread lib. This example no
> longer works on my box (thread is not executed):

The issue is in src/skins/posix/thread.c. The trampoline does not even
attempt to fire the thread body for policy == SCHED_OTHER. Will fix.
This said, I still wonder why cyclic is affected, since it should only
create SCHED_FIFO threads, but tracing it a bit, the issue is indeed the
same one.

> 
> #include <pthread.h>
> #include <stdio.h>
> #include <sys/mman.h>
> 
> void *thread(void *arg)
> {
>         printf("thread\n");
>         return 0;
> }
> 
> main()
> {
>         pthread_t thr;
> 
>         mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>         printf("create = %d\n",
>                pthread_create(&thr, NULL, thread, NULL));
>         pause();
> }
> 
> 
> This also explains why the cyclic test is broken.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



