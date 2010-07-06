Message-ID: <4C3378E2.2050401@domain.hid>
Date: Tue, 06 Jul 2010 20:41:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> Is it in general valid to mix calls from different skins?  In
> particular, can I expect the native skin calls to work as POSIX
> cancellation points?  For example, if I have a POSIX thread with a
> pthread_t identifier which I know calls rt_cond_wait somewhere, will it
> work as a cancellation point when I call pthread_cancel?
> 
> The example program attached will not cancel if I have CANCEL_DEFERRED
> defined as 1 at the top, which sets the cancel type to deferred.  This
> is on a PowerPC with Xenomai 2.5.3.  I think this worked with Xenomai
> 2.4.10.
> 
> 
> --------
> 
> 
> #include <stdio.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <native/task.h>
> #include <native/cond.h>
> 
> #define CANCEL_DEFERRED 1
> 
> RT_MUTEX mutex;
> RT_COND cond;
> pthread_t thread;
> 
> void *entry(void *cookie)
> {
>    fprintf(stderr, "Starting thread\n");
> 
> #if CANCEL_DEFERRED
>    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
> #else
>    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> #endif
> 
>    rt_mutex_acquire(&mutex, TM_INFINITE);
>    rt_cond_wait(&cond, &mutex, TM_INFINITE);
>    rt_mutex_release(&mutex);
> 
>    return NULL;
> }

This program would also deadlock with plain POSIX: you are missing a
cleanup handler which releases the mutex.

-- 
					    Gilles.

