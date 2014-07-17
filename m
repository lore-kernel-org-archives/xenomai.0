MIME-Version: 1.0
In-Reply-To: <53C82ABD.6060901@xenomai.org>
References: <CAPD=XXg6e79f5-ew6pO9Wp4NN3EamKcmv7pxAPT234q2XS7Ljw@mail.gmail.com>
 <53C82ABD.6060901@xenomai.org>
From: Matteo Sommariva <msommariva@gmail.com>
Date: Thu, 17 Jul 2014 22:45:37 +0200
Message-ID: <CAPD=XXh-pek-pKJS3xb0EWBXvFW3gwK5ze0aXeYEkLcZCqJwiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Strange switches to secondary mode with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

Hi Gilles,
thanks for your quick reply.

I've modified the main() in this way:

int main()
{
    mlockall(MCL_CURRENT | MCL_FUTURE);

    struct sched_param myparam;

    signal(SIGXCPU, warn_upon_switch);

    pthread_t t;
    pthread_attr_t myattr;

    pthread_attr_init(&myattr);
    pthread_attr_setinheritsched(&myattr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
    myparam.sched_priority = 99;
    pthread_attr_setschedparam(&myattr, &myparam);

    pthread_create(&t, &myattr, thread, NULL);

    pthread_join(t, NULL);

    return 0;
}

In the first version I also forgot the mlockall() call. Now if I use the
__real_printf the signal is trapped, and using the normal printf the MSW
doesn't increment every second.
However I can still see two switches.

root@ubuntu:/home/selex# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1641       0     00500080  100.0  ROOT/0
  1  0      0          0          0     00500080  100.0  ROOT/1
  0  2485   1          1          0     00b00380    0.0  prova
  0  2487   1          6          0     00340184    0.0  prova
  0  0      0          84424      0     00000000    0.0  IRQ16640: [timer]
  1  0      0          71065      0     00000000    0.0  IRQ16640: [timer]

1 for the main thread and 1 for the created thread. Is still something
wrong?
Thanks for you help and excuse me if mine are obvious questions, I'm moving
my first steps with Xenomai.

Matteo



On Thu, Jul 17, 2014 at 9:57 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/17/2014 09:33 PM, Matteo Sommariva wrote:
> > Hi,
> > I'm using xenomai-2.6.3, over vanilla kernel 3.8.13. I wrote a little
> > program using the POSIX skin.
> > The program creates a periodic thread, that every seconds wakes up and
> > print "Test" to stdout. Following the instructions on
> > http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai,
> > I've also enabled PTHREAD_WARNSW signal in order to be notified of
> unwanted
> > switches to secondary mode.
> > This is the source code of the program:
> >
> > #include <pthread.h>
> > #include <signal.h>
> > #include <getopt.h>
> > #include <execinfo.h>
> > #include <stdio.h>
> >
> > void *thread()
> > {
> >     pthread_set_mode_np(0,PTHREAD_WARNSW);
> >
> >     struct timespec start;
> >
> >        while(1)
> >        {
> >         clock_gettime(CLOCK_REALTIME, &start);
> >         start.tv_sec = start.tv_sec + 1;
> >
> >         printf("Test\n");
> >
> >         clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &start, NULL);
> >        }
> > }
> >
> > void warn_upon_switch(int sig __attribute__((unused)))
> > {
> >     void *bt[32];
> >     int nentries;
> >     /* Dump a backtrace of the frame which caused the switch to
> >     secondary mode: */
> >     nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
> >     backtrace_symbols_fd(bt,nentries,fileno(stdout));
> > }
> >
> > int main()
> > {
> >     signal(SIGXCPU, warn_upon_switch);
> >
> >     pthread_t t;
> >
> >     pthread_create(&t, NULL, thread, NULL);
> >
> >     pthread_join(t, NULL);
> >
> >     return 0;
> > }
> >
> > If I launch the program it prints to string, but under
> /proc/xenomai/stat I
> > can see that the MSW column of the children thread increases every
> second,
> > and the column of the main thread indicates 1 MSW. The involved call of
> the
> > children thread seems to be clock_nanosleep.
> > However, I don't receive the backtraces from SIGXCPU handling, and more
> > strangely the signal doesn't seem to be thrown even if I replace "printf"
> > with "__real_printf".
> > What I'm doing wrong? What does cause the switches? And why I'm unable to
> > receive any trace?
>
> By not using the SCHED_FIFO policy for the created thread, you asked for
> the thread to be switched to secondary mode as soon as it returns from
> clock_nanosleep. Thus when printf or __real_printf is executed, the task
> is already in secondary mode, no mode switch is needed. Since this mode
> switch is the implicit consequence of the scheduling policy you chose,
> it does not trigger the SIGDEBUG signal.
>
> --
>                                                                 Gilles.
>
