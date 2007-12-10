Message-ID: <475DB3AA.3080306@domain.hid>
Date: Mon, 10 Dec 2007 22:46:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>		<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>		<475801AA.3060300@domain.hid>		<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>		<475952CD.3020003@domain.hid>		<18265.47545.897637.377869@domain.hid>		<18265.50385.343346.558000@domain.hid>		<475C6454.2090002@domain.hid>		<18268.29130.406826.933528@domain.hid>		<475D5923.2050701@domain.hid>	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>
	<475DB21C.8040800@domain.hid>
In-Reply-To: <475DB21C.8040800@domain.hid>
Content-Type: multipart/mixed; boundary="------------060203060401000909050409"
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060203060401000909050409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> On Dec 10, 2007 4:20 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Grandegger wrote:
>>>>  > Gilles Chanteperdrix wrote:
>>>>  > > Gilles Chanteperdrix wrote:
>>>>  > >  > Wolfgang Grandegger wrote:
>>>>  > >  >  > Hi Gilles,
>>>>  > >  >  >
>>>>  > >  >  > Gilles Chanteperdrix wrote:
>>>>  > >  >  > > On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>  > >  >  > >> Gilles Chanteperdrix wrote:
>>>>  > >  >  > >>> On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
>>>>  > >  >  > >>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>  > >  >  > >>>> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>  > >  >  > >>>>> Gilles Chanteperdrix wrote:
>>>>  > >  >  > >>>>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>  > >  >  > >>>>>>> Hello,
>>>>  > >  >  > >>>>>>>
>>>>  > >  >  > >>>>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
>>>>  > >  >  > >>>>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
>>>>  > >  >  > >>>>>>> used in secondary context. I tried pthread_cancel(), but it only works
>>>>  > >  >  > >>>>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
>>>>  > >  >  > >>>>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
>>>>  > >  >  > >>>>>>> there a code snippet or even an example program showing how to cancel a
>>>>  > >  >  > >>>>>>> pthread in primary context?
>>>>  > >  >  > >>>>>> pthread_kill or pthread_cancel should result in sending a signal to
>>>>  > >  >  > >>>>>> the target thread, so should cause this thread to switch to secondary
>>>>  > >  >  > >>>>>> mode to handle it. If you want to wait for the target thread to be
>>>>  > >  >  > >>>>>> canceled, you should use pthread_cancel and pthread_join.
>>>>  > >  >  > >>>>> There is no way to cancel a pthread in primary mode from another pthread?
>>>>  > >  >  > >>>> No. You always need secondary mode to effectively delete a thread. The
>>>>  > >  >  > >>>> same goes for the native skin.
>>>>  > >  >  > >>> Ok. I understand what you mean. You want pthread_cancel not to leave
>>>>  > >  >  > >>> primary mode. This can easily be done by causing pthread_cancel to use
>>>>  > >  >  > >>> the kernel-space real-time pthread_cancel service. This should work
>>>>  > >  >  > >>> with no further modification.
>>>>  > >  >  > >> I want to cancel/delete a task running in primary mode, e.g.
>>>>  > >  >  > >>
>>>>  > >  >  > >>   void* work_task(void* dummy)
>>>>  > >  >  > >>   {
>>>>  > >  >  > >>         int count = 0;
>>>>  > >  >  > >>         while (1)
>>>>  > >  >  > >>                 count++;
>>>>  > >  >  > >>   }
>>>>  > >  >  > >>
>>>>  > >  >  > >> from the outside (= another higher priority task). How can I use the
>>>>  > >  >  > >> kernel-space real-time pthread_cancel service? My POSIX app is runs in
>>>>  > >  >  > >> user-land.
>>>>  > >  >  > >
>>>>  > >  >  > > I was thinking about adding a pthread_cancel syscall that would have
>>>>  > >  >  > > triggered the kernel-space pthread_cancel. But this will not work:
>>>>  > >  >  > > user-space cleanup handlers would no longer get executed. However,
>>>>  > >  >  > > this can work for pthread_kill. Here is a patch which adds the
>>>>  > >  >  > > pthread_kill syscall.
>>>>  > >  >  >
>>>>  > >  >  > Great, thanks a lot. This seems to work but I'm now fiddling with proper
>>>>  > >  >  > cleanup and exit. I have attached my small test program. It behaves
>>>>  > >  >  > somehow strange, at least to me:
>>>>  > >  >  >
>>>>  > >  >  > - I see task period overruns when the low prio task is started. I
>>>>  > >  >  >   suspect some switch to secondary mode in init_task().
>>>>  > >  >  >
>>>>  > >  >  > - The program/system hangs after the listed messages:
>>>>  > >  >  >
>>>>  > >  >  >   # ./kill_pthread
>>>>  > >  >  >   Starting high_prio_task
>>>>  > >  >  >   Killed low_prio task: count=3813129, overruns=0
>>>>  > >  >  >
>>>>  > >  >  > Any idea what I'm doing wrong?
>>>>  > >  >  >
>>>>  > >  >  > This is with Linux 2.4.25 and Xenomai 2.3.x on a MPC5200 board.
>>>>  > >  >
>>>>  > >  > Your test runs fine with Xenomai trunk (on ARM). I will now try with
>>>>  > >  > current state of the v2.3.x branch.
>>>>  > >
>>>>  > > Works with v2.3.x too.
>>>>  >
>>>>  > I re-activated my test PC running Linux 2.6.20.21. with Xenomai 2.3.x.
>>>>  > There the program runs fine _without_ your pthread_kill patch. For some
>>>>  > reason the low_prio_task() is running in secondary mode (do you know
>>>>  > why? Is there a function to check the mode?). I added
>>>>  >
>>>>  >         struct sched_param  param = { .sched_priority = LOW_PRIO };
>>>>  >         pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>>> After adding pthread_getschedparam() I realized, that policy was 1 and
>>> prio 10 and not as expected 5. The corresponding attribute settings
>>> before calling pthread_create have been ignored somehow. Am I doing
>>> something wrong in task_init()?
>>>
>>>>  > to the head of that function and then I get:
>>>>  >
>>>>  >   ./kill_pthread
>>>>  >   Starting high_prio_task
>>>>  >   BUG: NMI Watchdog detected LOCKUP
>>>>  >   Killed low_prio task: count=1588495996, overruns=0
>>>>  >   Exiting main
>>>>  >
>>>>  > I have attached the corresponding oops in case it's of interest.
>>>>  > Unfortunately, with your patch and adding the function
>>>>  > __real_pthread_kill() to wrappers.c, the behavior is the same. I'm going
>>>>  > to repeat the tests with Xenomai trunk tomorrow.
>>>>
>>>> The oops is due to the NMI watchdog calling some linux domain functions
>>>> over Xenomai domain. You should probably use Xenomai watchdog instead.
>>>>
>>>> As for the reason why the watchdog triggers: are you sure you are
>>>> running the kernel recompiled after having applied the patch?
>>> Indeed, after a "make clean; make bzImage" of the kernel it behaves
>>> differently. Wired, may be some dependency issue.
>>>
>>>   # ./kill_pthread
>>>   Starting high_prio_task
>>>   low_prio_task: policy=1 prio=10
>>>   Killed low_prio task: count=172709970, overruns=0
>>>
>>>   [1]+  Stopped                 ./kill_pthread
>> What you are observing is probably a difference between linuxthreads
>> and NPTL: with linuxthreads, SIGSTOP can be sent to a particular
>> thread and will cause this thread only to stop. With NPTL, it seems
>> that the effect of SIGSTOP is global, it affects the entire process. I
>> will test tonight on my x86 box to see if I observe the same effect.
> 
> Ah, the man page says:
> 
>  Note  that  pthread_kill()  only causes the signal to be handled in the
>  context of the given thread; the signal action  (termination  or  stop-
>  ping) affects the process as a whole.

The attached test application using a more sophisticated signal handling
works fine on my MPC5200-board running Linux 2.6.23 and Xenomai trunk.
Going to try it tomorrow on my PC.

Wolfgang.

--------------060203060401000909050409
Content-Type: text/x-csrc;
 name="kill_pthread.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill_pthread.c"

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <sys/mman.h>

static int count;
static int goon = 1;

static pthread_t id_low;
static pthread_t id_high;

#define LOW_PRIO 5
#define HIGH_PRIO 10

#undef WITH_PRINTF
#undef WITH_SIGXCPU

void init_task(int prio);

void* low_prio_task(void* dummy)
{
        struct sched_param  param;
        int policy;

        pthread_getschedparam(pthread_self(), &policy, &param);
        printf("%s: policy=%d prio=%d\n",
               __FUNCTION__, policy, param.sched_priority);

        param.sched_priority = LOW_PRIO;
        pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

        while (goon) {
#ifdef WITH_PRINTF
		pthread_set_mode_np(0, PTHREAD_PRIMARY);
                printf("%s %d\n", __FUNCTION__, count);
#endif
                count++;
        }
        printf("Exiting %s, count=%d\n", __FUNCTION__, count);
        return 0;
}

void* high_prio_task(void* dummy)
{
        struct timespec tstart = { .tv_sec = 0, .tv_nsec = 0};
#ifdef WITH_PRINTF
        struct timespec tperiod = { .tv_sec = 0, .tv_nsec = 10000000 };
#else
        struct timespec tperiod = { .tv_sec = 0, .tv_nsec = 1000000 };
#endif
        unsigned long overruns = 0;
        int tick = 0, step = 0, loop = 0, err;
        struct sched_param  param = { .sched_priority = HIGH_PRIO };

        printf("Starting %s\n", __FUNCTION__);

        pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

#ifdef WITH_SIGXCPU
        pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
        err = pthread_make_periodic_np(pthread_self(), &tstart, &tperiod);
        if (err)
                return (void *)err;

        while (1) {
                err = pthread_wait_np(&overruns);
#if 0
                if (err) {
                        pthread_kill(id_low, SIGSTOP);
                        printf("%s overruns=%lu, tick=%d, count=%d, err=%d\n",
                               __FUNCTION__, overruns, tick, count, err);
                        return 0;
                }
#endif
                if  (step == 0 && loop > 100) {
                        loop = 0;
                        step = 1;
                        init_task(LOW_PRIO);
                }
                else if (step == 1 && loop > 500) {
                        loop = 0;
                        step = 2;
                        //goon = 0;
                        pthread_kill(id_low, SIGUSR1);
                        printf("SIGUSER1 to id_low: count=%d, overruns=%lu\n",
                               count, overruns);
                }
                else if (step == 2 && loop > 500) {
			loop = 0;
			step = 1;
			pthread_kill(id_low, SIGUSR2);
                        printf("SIGUSER2 to id_low: count=%d, overruns=%lu\n",
                               count, overruns);
		}
                tick++;
                loop++;
        }
        printf("Exiting %s\n", __FUNCTION__);
        return 0;
}

void init_task(int prio)
{
   struct sched_param parm;
   pthread_attr_t attr;

   pthread_attr_init(&attr);
   if (prio == HIGH_PRIO)
           pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
   else
           pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
   pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
   parm.sched_priority = prio;
   pthread_attr_setschedparam(&attr, &parm);

   if (prio == HIGH_PRIO) {
           pthread_create(&id_high, &attr, high_prio_task, NULL);
           pthread_set_name_np(id_high,"high_prio");
   } else {
           pthread_create(&id_low, &attr, low_prio_task, NULL);
           pthread_set_name_np(id_low,"low_prio");
   }
}

void catch_signal(int sig)
{
        printf("Signal %d catched\n", sig);
}

#ifdef WITH_SIGXCPU
void catch_switch(int sig)
{
        void *bt[32];
        int nentries;

        printf("Signal %d catched\n", sig);

        /* Dump a backtrace of the frame which caused the switch to
           secondary mode: */
        nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
        backtrace_symbols_fd(bt,nentries,fileno(stdout));
}
#endif

static void suspend_signal_handler(int sig)
{
   sigset_t signal_set;

   printf("suspend signal handler\n");
   sigfillset (&signal_set);
   sigdelset (&signal_set, SIGUSR2);
   sigsuspend(&signal_set);

   return;
}

static void resume_signal_handler(int sig)
{
   printf("resume signal handler\n");
   return;
}


void init_signals(sigset_t *mask)
{
   struct sigaction sigusr1, sigusr2;

   sigemptyset(mask);
   sigaddset(mask, SIGINT);
   sigaddset(mask, SIGTERM);
   sigaddset(mask, SIGHUP);
   sigaddset(mask, SIGALRM);

   pthread_sigmask(SIG_BLOCK, mask, NULL);

   /*
    * Install the signal handlers for suspend/resume.
    */

   sigemptyset (&sigusr1.sa_mask);
   sigusr1.sa_flags = 0;
   sigusr1.sa_handler = suspend_signal_handler;
   sigaction(SIGUSR1, &sigusr1, NULL);

   sigemptyset (&sigusr2.sa_mask);
   sigusr2.sa_flags = 0;
   sigusr2.sa_handler = resume_signal_handler;
   sigaction(SIGUSR2, &sigusr2, NULL);

}

int main(int argc, char *argv[])
{
	sigset_t mask;
	int sig;

        mlockall(MCL_CURRENT|MCL_FUTURE);

#ifdef WITH_SIGXCPU
        signal(SIGXCPU, catch_switch);
#endif
#if 0
        signal(SIGTERM, catch_signal);
        signal(SIGINT, catch_signal);
        signal(SIGHUP, catch_signal);
#else
	init_signals(&mask);
#endif

        init_task(HIGH_PRIO);


#if 0
        pthread_join(id_high, NULL);
#else
	sigwait(&mask, &sig);
#endif

        printf("Exiting %s\n", __FUNCTION__);
        return 0;
}

--------------060203060401000909050409--

