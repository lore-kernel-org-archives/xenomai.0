Message-ID: <475DB21C.8040800@domain.hid>
Date: Mon, 10 Dec 2007 22:39:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	
	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>	
	<475801AA.3060300@domain.hid>	
	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>	
	<475952CD.3020003@domain.hid>	
	<18265.47545.897637.377869@domain.hid>	
	<18265.50385.343346.558000@domain.hid>	
	<475C6454.2090002@domain.hid>	
	<18268.29130.406826.933528@domain.hid>	
	<475D5923.2050701@domain.hid>
	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>
In-Reply-To: <2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Gilles Chanteperdrix wrote:
> On Dec 10, 2007 4:20 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Grandegger wrote:
>>>  > Gilles Chanteperdrix wrote:
>>>  > > Gilles Chanteperdrix wrote:
>>>  > >  > Wolfgang Grandegger wrote:
>>>  > >  >  > Hi Gilles,
>>>  > >  >  >
>>>  > >  >  > Gilles Chanteperdrix wrote:
>>>  > >  >  > > On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>  > >  >  > >> Gilles Chanteperdrix wrote:
>>>  > >  >  > >>> On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
>>>  > >  >  > >>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>  > >  >  > >>>> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>  > >  >  > >>>>> Gilles Chanteperdrix wrote:
>>>  > >  >  > >>>>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>>>  > >  >  > >>>>>>> Hello,
>>>  > >  >  > >>>>>>>
>>>  > >  >  > >>>>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
>>>  > >  >  > >>>>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
>>>  > >  >  > >>>>>>> used in secondary context. I tried pthread_cancel(), but it only works
>>>  > >  >  > >>>>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
>>>  > >  >  > >>>>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
>>>  > >  >  > >>>>>>> there a code snippet or even an example program showing how to cancel a
>>>  > >  >  > >>>>>>> pthread in primary context?
>>>  > >  >  > >>>>>> pthread_kill or pthread_cancel should result in sending a signal to
>>>  > >  >  > >>>>>> the target thread, so should cause this thread to switch to secondary
>>>  > >  >  > >>>>>> mode to handle it. If you want to wait for the target thread to be
>>>  > >  >  > >>>>>> canceled, you should use pthread_cancel and pthread_join.
>>>  > >  >  > >>>>> There is no way to cancel a pthread in primary mode from another pthread?
>>>  > >  >  > >>>> No. You always need secondary mode to effectively delete a thread. The
>>>  > >  >  > >>>> same goes for the native skin.
>>>  > >  >  > >>> Ok. I understand what you mean. You want pthread_cancel not to leave
>>>  > >  >  > >>> primary mode. This can easily be done by causing pthread_cancel to use
>>>  > >  >  > >>> the kernel-space real-time pthread_cancel service. This should work
>>>  > >  >  > >>> with no further modification.
>>>  > >  >  > >> I want to cancel/delete a task running in primary mode, e.g.
>>>  > >  >  > >>
>>>  > >  >  > >>   void* work_task(void* dummy)
>>>  > >  >  > >>   {
>>>  > >  >  > >>         int count = 0;
>>>  > >  >  > >>         while (1)
>>>  > >  >  > >>                 count++;
>>>  > >  >  > >>   }
>>>  > >  >  > >>
>>>  > >  >  > >> from the outside (= another higher priority task). How can I use the
>>>  > >  >  > >> kernel-space real-time pthread_cancel service? My POSIX app is runs in
>>>  > >  >  > >> user-land.
>>>  > >  >  > >
>>>  > >  >  > > I was thinking about adding a pthread_cancel syscall that would have
>>>  > >  >  > > triggered the kernel-space pthread_cancel. But this will not work:
>>>  > >  >  > > user-space cleanup handlers would no longer get executed. However,
>>>  > >  >  > > this can work for pthread_kill. Here is a patch which adds the
>>>  > >  >  > > pthread_kill syscall.
>>>  > >  >  >
>>>  > >  >  > Great, thanks a lot. This seems to work but I'm now fiddling with proper
>>>  > >  >  > cleanup and exit. I have attached my small test program. It behaves
>>>  > >  >  > somehow strange, at least to me:
>>>  > >  >  >
>>>  > >  >  > - I see task period overruns when the low prio task is started. I
>>>  > >  >  >   suspect some switch to secondary mode in init_task().
>>>  > >  >  >
>>>  > >  >  > - The program/system hangs after the listed messages:
>>>  > >  >  >
>>>  > >  >  >   # ./kill_pthread
>>>  > >  >  >   Starting high_prio_task
>>>  > >  >  >   Killed low_prio task: count=3813129, overruns=0
>>>  > >  >  >
>>>  > >  >  > Any idea what I'm doing wrong?
>>>  > >  >  >
>>>  > >  >  > This is with Linux 2.4.25 and Xenomai 2.3.x on a MPC5200 board.
>>>  > >  >
>>>  > >  > Your test runs fine with Xenomai trunk (on ARM). I will now try with
>>>  > >  > current state of the v2.3.x branch.
>>>  > >
>>>  > > Works with v2.3.x too.
>>>  >
>>>  > I re-activated my test PC running Linux 2.6.20.21. with Xenomai 2.3.x.
>>>  > There the program runs fine _without_ your pthread_kill patch. For some
>>>  > reason the low_prio_task() is running in secondary mode (do you know
>>>  > why? Is there a function to check the mode?). I added
>>>  >
>>>  >         struct sched_param  param = { .sched_priority = LOW_PRIO };
>>>  >         pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>> After adding pthread_getschedparam() I realized, that policy was 1 and
>> prio 10 and not as expected 5. The corresponding attribute settings
>> before calling pthread_create have been ignored somehow. Am I doing
>> something wrong in task_init()?
>>
>>>  > to the head of that function and then I get:
>>>  >
>>>  >   ./kill_pthread
>>>  >   Starting high_prio_task
>>>  >   BUG: NMI Watchdog detected LOCKUP
>>>  >   Killed low_prio task: count=1588495996, overruns=0
>>>  >   Exiting main
>>>  >
>>>  > I have attached the corresponding oops in case it's of interest.
>>>  > Unfortunately, with your patch and adding the function
>>>  > __real_pthread_kill() to wrappers.c, the behavior is the same. I'm going
>>>  > to repeat the tests with Xenomai trunk tomorrow.
>>>
>>> The oops is due to the NMI watchdog calling some linux domain functions
>>> over Xenomai domain. You should probably use Xenomai watchdog instead.
>>>
>>> As for the reason why the watchdog triggers: are you sure you are
>>> running the kernel recompiled after having applied the patch?
>> Indeed, after a "make clean; make bzImage" of the kernel it behaves
>> differently. Wired, may be some dependency issue.
>>
>>   # ./kill_pthread
>>   Starting high_prio_task
>>   low_prio_task: policy=1 prio=10
>>   Killed low_prio task: count=172709970, overruns=0
>>
>>   [1]+  Stopped                 ./kill_pthread
> 
> What you are observing is probably a difference between linuxthreads
> and NPTL: with linuxthreads, SIGSTOP can be sent to a particular
> thread and will cause this thread only to stop. With NPTL, it seems
> that the effect of SIGSTOP is global, it affects the entire process. I
> will test tonight on my x86 box to see if I observe the same effect.

Ah, the man page says:

 Note  that  pthread_kill()  only causes the signal to be handled in the
 context of the given thread; the signal action  (termination  or  stop-
 ping) affects the process as a whole.

Wolfgang.


