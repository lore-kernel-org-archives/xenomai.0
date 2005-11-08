Message-ID: <43707092.1060509@domain.hid>
Date: Tue, 08 Nov 2005 10:32:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] scheduling order of dying shadow threads
References: <4370641D.7010906@domain.hid>
In-Reply-To: <4370641D.7010906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> I think this one is for you: ;)
> 
> Sebastian got almost mad with his CAN driver while tracing a strange
> scheduling behaviour during shadow thread deletion for several days(!) -
> and I was right on the way to follow him yesterday evening. Attached is
> a simplified demonstration of the effect, consisting of a RTDM driver
> and both a kernel and user space application to trigger it.
> 
> Assume two or more user space RT-threads blocking on the same RTDM
> semaphore inside a driver (I was not yet able to reproduce this with a
> simply native user space application :/). All get then woken up on
> rtdm_sem_destroy during device closure. They increment a global counter,
> save the current value in a per-thread variable, and then terminate.
> They had also passed another per-thread variable to the RTDM driver
> which was updated in the kernel using the same(!) counter.
> 
> /* application */
> void demo(void *arg)
> {
>     rt_dev_read(dev, &value_k[(int)arg], 0);
>     value_u[(int)arg] = ++counter;
> }
> 
> /* driver */
> int demo_read_rt(struct rtdm_dev_context    *context,
>                  rtdm_user_info_t           *user_info,
>                  void                       *buf,
>                  size_t                     nbyte)
> {
>     struct demodrv_context  *my_context;
>     int                     ret;
> 
> 
>     my_context = (struct demodrv_context *)context->dev_private;
> 
>     ret = rtdm_sem_down(&my_context->read_sem);
>     *(int *)buf = ++(*counter);
> 
>     return ret;
> }
> 
> 
> That global counter is also incremented during closure to visualise the
> call order:
> 
> 
> int demo_close_rt(struct rtdm_dev_context   *context,
>                   rtdm_user_info_t          *user_info)
> {
>     struct demodrv_context  *my_context;
> 
> 
>     my_context = (struct demodrv_context *)context->dev_private;
> 
>     printk("close 1: %d\n", xnpod_current_thread()->cprio);
>     rtdm_sem_destroy(&my_context->read_sem);
>     printk("close 2: %d\n", xnpod_current_thread()->cprio);
>     (*counter)++;
> 
>     return 0;
> }
> 
> 
> Now one would expect the following content of the involved variables
> when running 3 threads e.g.:
> 
>            thread 1      (prio 99)
>          /   thread 2    (prio 98)
>          |  /   thread 3 (prio 97)
>          |  |  /
> value_k: 1, 3, 5
> value_u: 2, 4, 6
> counter: 7
> 
> This is indeed what we get when the application locates in kernel space,
> i.e. does not use shadow threads. But when it is a user space
> application, the result looks like this:
> 
>            thread 1
>          /   thread 2
>          |  /   thread 3
>          |  |  /
> value_k: 1, 4, 6
> value_u: 2, 5, 7
> counter: 7
> 
> Which means that first thread returns from kernel to user space and
> terminates, then the close handler gets executed again, and only
> afterwards the remaining threads!
> 
> The reason is also displayed by demodrv:
> close 1: 0	- prio of root thread before rtdm_sem_destroy
> close 2: 99	- ... and after rtdm_sem_destroy
> 
> Which means that the non-RT thread calling rt_dev_close gets lifted to
> prio 99 on calling rtdm_sem_destroy, the prio of the thread first woken
> up. It seems to loose this prio quite soon again, but not soon enough to
> avoid the inversion - very strange.
> 
> Any ideas?

Not yet, but your analysis looks right, the main thread seems to spuriously 
recycle the priority level of task1 as the latter enters the secondary mode. The 
good news is that it's likely that such issue only impacts the deletion process 
which involves some specific transitions. I'll try to reproduce this bug asap 
and let you know. Thanks.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

