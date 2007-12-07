Message-ID: <475952CD.3020003@domain.hid>
Date: Fri, 07 Dec 2007 15:03:57 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	
	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>	
	<4757F811.70905@domain.hid>	
	<2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>	
	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>	
	<475801AA.3060300@domain.hid>
	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>
In-Reply-To: <2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>
Content-Type: multipart/mixed; boundary="------------020504070406000903030001"
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
--------------020504070406000903030001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

Gilles Chanteperdrix wrote:
> On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
>>>>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
>>>>>>> used in secondary context. I tried pthread_cancel(), but it only works
>>>>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
>>>>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
>>>>>>> there a code snippet or even an example program showing how to cancel a
>>>>>>> pthread in primary context?
>>>>>> pthread_kill or pthread_cancel should result in sending a signal to
>>>>>> the target thread, so should cause this thread to switch to secondary
>>>>>> mode to handle it. If you want to wait for the target thread to be
>>>>>> canceled, you should use pthread_cancel and pthread_join.
>>>>> There is no way to cancel a pthread in primary mode from another pthread?
>>>> No. You always need secondary mode to effectively delete a thread. The
>>>> same goes for the native skin.
>>> Ok. I understand what you mean. You want pthread_cancel not to leave
>>> primary mode. This can easily be done by causing pthread_cancel to use
>>> the kernel-space real-time pthread_cancel service. This should work
>>> with no further modification.
>> I want to cancel/delete a task running in primary mode, e.g.
>>
>>   void* work_task(void* dummy)
>>   {
>>         int count = 0;
>>         while (1)
>>                 count++;
>>   }
>>
>> from the outside (= another higher priority task). How can I use the
>> kernel-space real-time pthread_cancel service? My POSIX app is runs in
>> user-land.
> 
> I was thinking about adding a pthread_cancel syscall that would have
> triggered the kernel-space pthread_cancel. But this will not work:
> user-space cleanup handlers would no longer get executed. However,
> this can work for pthread_kill. Here is a patch which adds the
> pthread_kill syscall.

Great, thanks a lot. This seems to work but I'm now fiddling with proper
cleanup and exit. I have attached my small test program. It behaves
somehow strange, at least to me:

- I see task period overruns when the low prio task is started. I
  suspect some switch to secondary mode in init_task().

- The program/system hangs after the listed messages:

  # ./kill_pthread
  Starting high_prio_task
  Killed low_prio task: count=3813129, overruns=0

Any idea what I'm doing wrong?

This is with Linux 2.4.25 and Xenomai 2.3.x on a MPC5200 board.

TIA.

Wolfgang.


--------------020504070406000903030001
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

static pthread_t id_low;
static pthread_t id_high;

#define LOW_PRIO 5
#define HIGH_PRIO 10

#undef WITH_PRINTF
#undef WITH_SIGXCPU

void init_task(int prio);

void* low_prio_task(void* dummy)
{

   while (1)
   {
#ifdef WITH_PRINTF
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

	printf("Starting %s\n", __FUNCTION__);

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
		else if (step == 1 && loop > 50) {
			loop = 0;
			step = 0;
			pthread_kill(id_low, SIGSTOP);
			printf("Killed low_prio task: count=%d, overruns=%lu\n",
			       count, overruns);
			return 0;
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

int main(int argc, char *argv[])
{
	mlockall(MCL_CURRENT|MCL_FUTURE);

	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
	signal(SIGHUP, catch_signal);
#ifdef WITH_SIGXCPU
	signal(SIGXCPU, catch_switch);
#endif
	init_task(HIGH_PRIO);

	pthread_join(id_high, NULL);

	printf("Exiting %s\n", __FUNCTION__);
	return 0;
}

--------------020504070406000903030001--

