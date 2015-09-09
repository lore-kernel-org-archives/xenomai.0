References: <55ED7A9E.1080209@gmail.com> <55ED8875.10504@xenomai.org>
From: Konstantinos Chalas <konchalas@gmail.com>
Message-ID: <55F03436.5040202@gmail.com>
Date: Wed, 9 Sep 2015 15:29:26 +0200
MIME-Version: 1.0
In-Reply-To: <55ED8875.10504@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Xenomai <xenomai@xenomai.org>

For future reference, this is what a working POSIX timer in Xenomai 
looks like:

#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <pthread.h>
#include <sys/syscall.h>

void* print_time (void*);

timer_t timer1;
pthread_t thread;

int main (int argc, char **argv)
{
     pthread_create(&thread, NULL, print_time, NULL);

     pthread_join(thread, NULL);
     exit (EXIT_SUCCESS);
}

void* print_time (void* args)
{
     struct timespec tp;
     char buffer [80];
     struct itimerspec new_value, old_value;
     struct sigaction action;
     struct sigevent sevent;
     sigset_t set;
     int signum = SIGALRM;

     sevent.sigev_notify = SIGEV_THREAD_ID;
     sevent.sigev_notify_thread_id = syscall(__NR_gettid);
     sevent.sigev_signo = signum;

     sigemptyset(&set);
     sigaddset(&set, signum);
     sigprocmask(SIG_BLOCK, &set, NULL);

     if (timer_create (CLOCK_MONOTONIC, &sevent, &timer1) == -1)
             perror ("timer_create");

     new_value.it_interval.tv_sec = 1;
     new_value.it_interval.tv_nsec = 0;
     new_value.it_value.tv_sec = 1;
     new_value.it_value.tv_nsec = 0;

     if (timer_settime (timer1, 0, &new_value, &old_value) == -1)
         perror ("timer_settime");

     while(1){
         /* wait for signal (1 s) */
         if (sigwait (&set, &signum) == -1)
             perror ("sigwait");

         if (clock_gettime (CLOCK_MONOTONIC, &tp) == -1)
             perror ("clock_gettime");

         sprintf (buffer, "%ld s %ld ns overrun = %d\n", tp.tv_sec,
                 tp.tv_nsec, timer_getoverrun (timer1));
         write (STDOUT_FILENO, buffer, strlen (buffer));
     }
}

Thanks for the help!

On 09/07/2015 02:52 PM, Philippe Gerum wrote:
> On 09/07/2015 01:53 PM, Konstantinos Chalas wrote:
>> Hello everyone,
>>
>> Does any of you have a working implementation of timer_create( ) in
>> Xenomai-3?
>>
>> According to the documentation /only thread-directed notification is
>> supported (evp->sigev_notify set to//SIGEV_THREAD_ID//). The thing is
>> that the use of //SIG/EV_THREAD_ID is not common, therefore it is hard
>> to find any help.../
>>
> evp->sigev_notify_thread_id must be set with your recipient thread ID.
> There is nothing special otherwise.
>
>> /By the way, the example provided at the end of
>> http://www.softprayog.in/tutorials/alarm-sleep-and-high-resolution-timers,
>> crashes my system. I understand that it doesn't comply with Xenomai
>> documentation, but should it crash the whole system?
>>
> You've just proved Murphy's law article #27 is right, "If you perceive
> that there are four possible ways a procedure can go wrong, and you
> circumvent these, then a fifth way, unprepared for, will promptly develop".
>
> diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
> index e5551b3..8c4d2da 100644
> --- a/kernel/cobalt/posix/timer.c
> +++ b/kernel/cobalt/posix/timer.c
> @@ -67,8 +67,10 @@ timer_init(struct cobalt_timer *timer,
>   	    timer->clockid != CLOCK_REALTIME)
>   		return ERR_PTR(-EINVAL);
>
> -	if (evp == NULL || evp->sigev_notify == SIGEV_NONE)
> -		return owner;	/* Assume SIGEV_THREAD_ID. */
> +	if (evp == NULL || evp->sigev_notify == SIGEV_NONE) {
> +		target = owner;	/* Assume SIGEV_THREAD_ID. */
> +		goto init;
> +	}
>
>   	if (evp->sigev_notify != SIGEV_THREAD_ID)
>   		return ERR_PTR(-EINVAL);
> @@ -80,7 +82,7 @@ timer_init(struct cobalt_timer *timer,
>   	target = cobalt_thread_find_local(evp->sigev_notify_thread_id);
>   	if (target == NULL)
>   		return ERR_PTR(-EINVAL);
> -
> +init:
>   	/*
>   	 * All standard clocks are based on the core clock, and we
>   	 * want to deliver a signal when a timer elapses.


