Message-ID: <475DB186.7060706@domain.hid>
Date: Mon, 10 Dec 2007 22:37:10 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>	<4757F811.70905@domain.hid>	<2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>	<475801AA.3060300@domain.hid>	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>	<475952CD.3020003@domain.hid>	<18265.47545.897637.377869@domain.hid>	<18265.50385.343346.558000@domain.hid>	<475C6454.2090002@domain.hid>	<18268.29130.406826.933528@domain.hid>	<475D5923.2050701@domain.hid>
	<18269.44492.753877.217708@domain.hid>
In-Reply-To: <18269.44492.753877.217708@domain.hid>
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
> Wolfgang Grandegger wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Wolfgang Grandegger wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Gilles Chanteperdrix wrote:
>  > >  > >  > Wolfgang Grandegger wrote:
>  > >  > >  >  > Hi Gilles,
>  > >  > >  >  > 
>  > >  > >  >  > Gilles Chanteperdrix wrote:
>  > >  > >  >  > > On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  > >  > >  >  > >> Gilles Chanteperdrix wrote:
>  > >  > >  >  > >>> On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
>  > >  > >  >  > >>> <gilles.chanteperdrix@xenomai.org> wrote:
>  > >  > >  >  > >>>> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  > >  > >  >  > >>>>> Gilles Chanteperdrix wrote:
>  > >  > >  >  > >>>>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  > >  > >  >  > >>>>>>> Hello,
>  > >  > >  >  > >>>>>>>
>  > >  > >  >  > >>>>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
>  > >  > >  >  > >>>>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
>  > >  > >  >  > >>>>>>> used in secondary context. I tried pthread_cancel(), but it only works
>  > >  > >  >  > >>>>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
>  > >  > >  >  > >>>>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
>  > >  > >  >  > >>>>>>> there a code snippet or even an example program showing how to cancel a
>  > >  > >  >  > >>>>>>> pthread in primary context?
>  > >  > >  >  > >>>>>> pthread_kill or pthread_cancel should result in sending a signal to
>  > >  > >  >  > >>>>>> the target thread, so should cause this thread to switch to secondary
>  > >  > >  >  > >>>>>> mode to handle it. If you want to wait for the target thread to be
>  > >  > >  >  > >>>>>> canceled, you should use pthread_cancel and pthread_join.
>  > >  > >  >  > >>>>> There is no way to cancel a pthread in primary mode from another pthread?
>  > >  > >  >  > >>>> No. You always need secondary mode to effectively delete a thread. The
>  > >  > >  >  > >>>> same goes for the native skin.
>  > >  > >  >  > >>> Ok. I understand what you mean. You want pthread_cancel not to leave
>  > >  > >  >  > >>> primary mode. This can easily be done by causing pthread_cancel to use
>  > >  > >  >  > >>> the kernel-space real-time pthread_cancel service. This should work
>  > >  > >  >  > >>> with no further modification.
>  > >  > >  >  > >> I want to cancel/delete a task running in primary mode, e.g.
>  > >  > >  >  > >>
>  > >  > >  >  > >>   void* work_task(void* dummy)
>  > >  > >  >  > >>   {
>  > >  > >  >  > >>         int count = 0;
>  > >  > >  >  > >>         while (1)
>  > >  > >  >  > >>                 count++;
>  > >  > >  >  > >>   }
>  > >  > >  >  > >>
>  > >  > >  >  > >> from the outside (= another higher priority task). How can I use the
>  > >  > >  >  > >> kernel-space real-time pthread_cancel service? My POSIX app is runs in
>  > >  > >  >  > >> user-land.
>  > >  > >  >  > > 
>  > >  > >  >  > > I was thinking about adding a pthread_cancel syscall that would have
>  > >  > >  >  > > triggered the kernel-space pthread_cancel. But this will not work:
>  > >  > >  >  > > user-space cleanup handlers would no longer get executed. However,
>  > >  > >  >  > > this can work for pthread_kill. Here is a patch which adds the
>  > >  > >  >  > > pthread_kill syscall.
>  > >  > >  >  > 
>  > >  > >  >  > Great, thanks a lot. This seems to work but I'm now fiddling with proper
>  > >  > >  >  > cleanup and exit. I have attached my small test program. It behaves
>  > >  > >  >  > somehow strange, at least to me:
>  > >  > >  >  > 
>  > >  > >  >  > - I see task period overruns when the low prio task is started. I
>  > >  > >  >  >   suspect some switch to secondary mode in init_task().
>  > >  > >  >  > 
>  > >  > >  >  > - The program/system hangs after the listed messages:
>  > >  > >  >  > 
>  > >  > >  >  >   # ./kill_pthread
>  > >  > >  >  >   Starting high_prio_task
>  > >  > >  >  >   Killed low_prio task: count=3813129, overruns=0
>  > >  > >  >  > 
>  > >  > >  >  > Any idea what I'm doing wrong?
>  > >  > >  >  > 
>  > >  > >  >  > This is with Linux 2.4.25 and Xenomai 2.3.x on a MPC5200 board.
>  > >  > >  > 
>  > >  > >  > Your test runs fine with Xenomai trunk (on ARM). I will now try with
>  > >  > >  > current state of the v2.3.x branch.
>  > >  > > 
>  > >  > > Works with v2.3.x too.
>  > >  > 
>  > >  > I re-activated my test PC running Linux 2.6.20.21. with Xenomai 2.3.x.
>  > >  > There the program runs fine _without_ your pthread_kill patch. For some
>  > >  > reason the low_prio_task() is running in secondary mode (do you know
>  > >  > why? Is there a function to check the mode?). I added
>  > >  > 
>  > >  >         struct sched_param  param = { .sched_priority = LOW_PRIO };
>  > >  >         pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>  > 
>  > After adding pthread_getschedparam() I realized, that policy was 1 and
>  > prio 10 and not as expected 5. The corresponding attribute settings
>  > before calling pthread_create have been ignored somehow. Am I doing
>  > something wrong in task_init()?
> 
> No, I think there is rather something wrong in Xenomai user-space
> library. __pthread_trampoline should call __wrap_pthread_setschedparam
> instead of __real_pthread_setschedparam.

OK, I have realized that it's correct with Linux 2.4 but wrong with 2.6.

Wolfgang.

