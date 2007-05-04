Message-ID: <463AF4F3.2080205@domain.hid>
Date: Fri, 04 May 2007 10:55:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705040108s7ecc6092u5332cb40796a8dd6@domain.hid>
In-Reply-To: <7289437c0705040108s7ecc6092u5332cb40796a8dd6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with API Posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> void cleanup_upon_sig(int sig __attribute__((unused)))
> 
> {
> 
>             pthread_mutex_destroy(&mutex);
> 
>             pthread_exit(&task1);
> 
>             pthread_exit(&task2);
> 
>             exit(0);
> 
> }

This will not work:
- pthread_exit, can not be used to terminate another thread than the
current thread, what you are looking for is pthread_cancel and pthread_join
- pthread_mutex_destroy will not work if a thread has currently locked
the mutex, so you can call pthread_mutex_destroy only after having
canceled and joined task1 and task2
- doing the cleanups in the signal handler leads to a risk of deadlock,
especially if the signal handler is able to run on any thread.

>             sigemptyset(&mask);
> 
>             sigaddset(&mask, SIGINT);
> 
>             signal(SIGINT, cleanup_upon_sig);
> 
>             sigaddset(&mask, SIGTERM);
> 
>             signal(SIGTERM, cleanup_upon_sig);
> 
>             sigaddset(&mask, SIGHUP);
> 
>             signal(SIGHUP, cleanup_upon_sig);

What is this mask for ? You set it up but do not use it. If you want to
ensure that the newly created threads are created with these signals
masked, you should call pthread_sigmask before any call to
pthread_create to mask these signals, and unmask them after having
created the new threads. That is because when calling pthread_create,
the newly created thread signal masked is copied from the parent thread.

> 
>            
> 
>             pthread_attr_init(&attr1);
> 
>             pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_JOINABLE);
> 
>             pthread_attr_setinheritsched(&attr1, PTHREAD_EXPLICIT_SCHED);
> 
>             pthread_attr_setschedpolicy(&attr1, SCHED_FIFO);
> 
>             pthread_attr_setschedparam(&attr1, &param1);

This is incorrect. param1 is not initialized and you are using it, but
since you do not check the return value, you do not know if this call
works or fails.

> 
>             param1.sched_priority =20;
> (...)
>             pthread_create (&task1,&attr1,(void *)routine1,NULL);

How do you know if task1 is running ? You do not check pthread_create
return value.

Why your example does not work is not obvious at first sight, but the
general advice we can give you is:
- please read the documentation at :
http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__posix.html
and
http://www.unix.org/single_unix_specification
- please check the return value of the services you use, when they have one;
- please have a look at the programs included in xenomai distribution.

-- 
                                                 Gilles Chanteperdrix

