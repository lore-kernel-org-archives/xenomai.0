References: <55ED7A9E.1080209@gmail.com> <55ED8875.10504@xenomai.org>
 <55F03436.5040202@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55F039EE.2010502@xenomai.org>
Date: Wed, 9 Sep 2015 15:53:50 +0200
MIME-Version: 1.0
In-Reply-To: <55F03436.5040202@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timer_create( ) example in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantinos Chalas <konchalas@gmail.com>, Xenomai <xenomai@xenomai.org>

On 09/09/2015 03:29 PM, Konstantinos Chalas wrote:
> For future reference, this is what a working POSIX timer in Xenomai
> looks like:
> 

Good you got it working. A few additional hints:

> void* print_time (void* args)
> {
>     struct timespec tp;
>     char buffer [80];
>     struct itimerspec new_value, old_value;
>     struct sigaction action;
>     struct sigevent sevent;
>     sigset_t set;
>     int signum = SIGALRM;
> 
>     sevent.sigev_notify = SIGEV_THREAD_ID;
>     sevent.sigev_notify_thread_id = syscall(__NR_gettid);
>     sevent.sigev_signo = signum;
>

Passing a NULL sigevent will get you the exact same behavior, i.e.:
signum=SIGALRM, SIGEV_THREAD_ID to the calling thread. With the proper
fix mentioned earlier, that is.

>     sigemptyset(&set);
>     sigaddset(&set, signum);
>     sigprocmask(SIG_BLOCK, &set, NULL);

This masking is useless, and do not apply to Xenomai/cobalt signals but
to regular ones. Cobalt signals are synchronous only, so you won't
receive any async notification via some handler. sigwait*() is required
to pull the pending signals explicitly. You can see this as all signals
managed by Cobalt being implicitly blocked for any rt thread - of
course, this does not apply to regular Linux signals which behave as usual.

>     while(1){
>         /* wait for signal (1 s) */
>         if (sigwait (&set, &signum) == -1)
>             perror ("sigwait");

sigwait() does not return -1, but a positive error number if  something
went wrong.

> 
>         if (clock_gettime (CLOCK_MONOTONIC, &tp) == -1)
>             perror ("clock_gettime");
> 
>         sprintf (buffer, "%ld s %ld ns overrun = %d\n", tp.tv_sec,
>                 tp.tv_nsec, timer_getoverrun (timer1));

Another way to retrieve the count of overruns for a timer without the
extra call is to invoke sigwaitinfo(&set, &siginfo), fetching that value
from siginfo.si_overrun.

-- 
Philippe.

