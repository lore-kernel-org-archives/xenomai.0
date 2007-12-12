Message-ID: <47604BF1.5040102@domain.hid>
Date: Wed, 12 Dec 2007 22:00:33 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	<18265.47545.897637.377869@domain.hid>	<18265.50385.343346.558000@domain.hid>	<475C6454.2090002@domain.hid>	<18268.29130.406826.933528@domain.hid>	<475D5923.2050701@domain.hid>	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>	<475DB21C.8040800@domain.hid>	<475DB3AA.3080306@domain.hid>	<475E8EA6.1040702@domain.hid>	<2ff1a98a0712110523tb0d23f0tdfa8b3778ae634fc@domain.hid>	<475EA121.2020809@domain.hid>	<18270.60447.548134.462197@domain.hid>	<475F9446.6070802@domain.hid>	<18271.42204.932617.524890@domain.hid>	<475FB0EA.10104@domain.hid>
	<18272.16326.1660.17610@domain.hid>
In-Reply-To: <18272.16326.1660.17610@domain.hid>
Content-Type: multipart/mixed; boundary="------------020502070701050101020700"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020502070701050101020700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Wolfgang Grandegger wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Wolfgang Grandegger wrote:
>  > >  > >  > Gilles Chanteperdrix wrote:
>  > >  > >  > > On Dec 11, 2007 2:20 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  > >  > >  > >> Wolfgang Grandegger wrote:
>  > >  > >  > >>> The attached test application using a more sophisticated signal handling
>  > >  > >  > >>> works fine on my MPC5200-board running Linux 2.6.23 and Xenomai trunk.
>  > >  > >  > >>> Going to try it tomorrow on my PC.
>  > >  > >  > >> It works fine as well on my PC with Linux 2.6.23 and Xenomai trunk and
>  > >  > >  > >> now also with Linux 2.4.25 and Xenomai 2.3.x :-). Just to understand it
>  > >  > >  > >> right: The task signaled with pthread_kill() will be suspended and
>  > >  > >  > >> switches to secondary mode if it was running in primary mode. The signal
>  > >  > >  > >> will then be handled by Linux as usual. When the task resumes, does it
>  > >  > >  > >> get switched back to primary mode automatically?
>  > >  > >  > > 
>  > >  > >  > > No, it will get swtiched back to primary mode only if it calls a
>  > >  > >  > > service needing primary mode.
>  > >  > >  > 
>  > >  > >  > OK.
>  > >  > >  > 
>  > >  > >  > >> Great, the only open issue is why executing init_task() switches to
>  > >  > >  > >> secondary mode resulting in period overruns in high_prio_task(). Is that
>  > >  > >  > >> obvious to you?
>  > >  > >  > > 
>  > >  > >  > > init_task calls pthread_create, which needs running in secondary mode
>  > >  > >  > > to create a thread. We can not create a task without help from
>  > >  > >  > > secondary mode.
>  > >  > >  > 
>  > >  > >  > OK.
>  > >  > >  > 
>  > >  > >  > I was a bit quick with my assumption that it works with 2.4. It actually
>  > >  > >  > only works, if I have a pthread_set_mode_np() in the while loop of the
>  > >  > >  > primary task:
>  > >  > >  > 
>  > >  > >  >         while (1) {
>  > >  > >  > 		pthread_set_mode_np(0, PTHREAD_PRIMARY);
>  > >  > >  >                 count++;
>  > >  > >  >         }
>  > >  > >  > 
>  > >  > >  > Without pthread_set_mode_np(), the system hangs after the following
>  > >  > >  > output lines:
>  > >  > >  > 
>  > >  > >  >   bash-2.05b# ./kill_pthread2
>  > >  > >  >   Starting high_prio_task
>  > >  > >  >   low_prio_task: policy=1 prio=5
>  > >  > >  >   SIGUSER1 to id_low: count=17497245, overruns=0
>  > >  > >  > 
>  > >  > >  > It seems to hang when the low_prio_task() calls pthread_wait_np()
>  > >  > >  > thereafter. Any quick idea where the problem is?
>  > >  > > 
>  > >  > > I am clueless. Are you sure you recompiled the kernel after applying the
>  > >  > > patch adding the pthread_kill syscall ?
>  > >  > 
>  > >  > Well, I tried with v2.3.2, v2.3.x and also trunk, which does not require
>  > >  > the patch. Unfortunately, all versions show the same behavior.
>  > > 
>  > > Did you check all the system call return values to see if one of them is
>  > > not failing ?
>  > 
>  > pthread_kill() returns always 0, or what do you exactly mean. I also
>  > checked with printk() that ksrc/skins/posix/signal.c:pthread_kill() gets
>  > called. I realized the following behaviour if I call a printf after a
>  > certain count value:
>  > 
>  >   void* low_prio_task(void* dummy)
>  >   {
>  >      while (1) {
>  > 		count++;
>  > 		if (count == 100000000)
>  > 			printf("Wakeup\n");
>  >         }
>  >      return 0;
>  >   }
>  > 
>  > Then the program goes on when the above count value is reached:
>  > 
>  >   Starting high_prio_task
>  >   low_prio_task: policy=1 prio=5
>  >   SIGUSER1 to id_low: count=13819079, overruns=0
>  >   ... blocks for a while ...
>  >   SIGUSER2 to id_low: count=27681649, overruns=0
>  >   suspend signal handler
>  >   resume signal handler
>  >   SIGUSER1 to id_low: count=100000000, overruns=0
>  >   SIGUSER2 to id_low: count=100000000, overruns=0
>  >   resume signal handler
>  >   suspend signal handler
>  >   SIGUSER1 to id_low: count=100000000, overruns=0
>  >   SIGUSER2 to id_low: count=100000000, overruns=0
>  >   ...
>  > 
>  > This shows that the task did not get suspended before the printf is
>  > executed. And thereafter it never really resumes.
> 
> I tested the last program you posted, and it works on ARM (where I am
> using linuxthreads, not NPTL), as far as I can tell. Could you send the
> one that does not work ?

Attached. On my MPC5200 it works with pthread_set_mode_np() in the
counter loop of low_prio_thread(), but fails without.

Thanks.

Wolfgang.



--------------020502070701050101020700
Content-Type: text/x-csrc;
 name="kill_pthread.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill_pthread.c"

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <sys/mman.h>

static unsigned long count;

static pthread_t id_low;
static pthread_t id_high;

#define LOW_PRIO 5
#define HIGH_PRIO 10

void init_task(int prio);

void* low_prio_task(void* dummy)
{
        struct sched_param  param;
        int policy;

        pthread_getschedparam(pthread_self(), &policy, &param);
        printf("Starting %s: policy=%d prio=%d\n",
               __FUNCTION__, policy, param.sched_priority);

	/* Switch back to primary mode */
        pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

        while (1) {
#if 0
		pthread_set_mode_np(0, PTHREAD_PRIMARY);
#endif
		count++;
        }
        printf("Exiting %s, count=%lu\n", __FUNCTION__, count);
        return 0;
}

void* high_prio_task(void* dummy)
{
        struct timespec tstart = { .tv_sec = 0, .tv_nsec = 0};
#if 0
        struct timespec tperiod = { .tv_sec = 0, .tv_nsec = 10000000 };
#else
        struct timespec tperiod = { .tv_sec = 0, .tv_nsec = 1000000 };
#endif
        unsigned long overruns = 0;
        int tick = 0, step = 0, loop = 0, err;
        struct sched_param  param = { .sched_priority = HIGH_PRIO };
        int policy;

        pthread_getschedparam(pthread_self(), &policy, &param);
        printf("Starting %s: policy=%d prio=%d\n",
               __FUNCTION__, policy, param.sched_priority);

        err = pthread_make_periodic_np(pthread_self(), &tstart, &tperiod);
        if (err) {
		perror("pthread_make_periodic_np");
		return (void *)err;
	}

        while (1) {
                err = pthread_wait_np(&overruns);
#if 0
                if (err) {
                        err = pthread_kill(id_low, SIGUSR1);
			if (err) {
				perror("pthread_kill");
				break;
			}
                        printf("%s overruns=%lu, tick=%d, count=%lu, err=%d\n",
                               __FUNCTION__, overruns, tick, count, err);
                        loop = 0;
                        step = 2;
                }
#endif
                if  (step == 0 && loop >= 100) {
                        loop = 0;
                        step = 1;
                        init_task(LOW_PRIO);
                }
                else if (step == 1 && loop >= 500) {
                        loop = 0;
                        step = 2;
                        err = pthread_kill(id_low, SIGUSR1);
			if (err) {
				perror("pthread_kill");
				break;
			}
                        printf("SIGUSER1 to id_low: count=%lu, overruns=%lu\n",
                               count, overruns);
                }
                else if (step == 2 && loop >= 500) {
			loop = 0;
			step = 1;
                        printf("SIGUSER2 to id_low: count=%lu, overruns=%lu\n",
                               count, overruns);
			err = pthread_kill(id_low, SIGUSR2);
			if (err) {
				perror("pthread_kill");
				break;
			}
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
	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
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

	init_signals(&mask);

        init_task(HIGH_PRIO);

	sigwait(&mask, &sig);

        printf("Exiting %s\n", __FUNCTION__);
        return 0;
}

--------------020502070701050101020700--

