Message-ID: <8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
Date: Sun, 30 Dec 2007 21:17:26 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18472_13927465.1199045846617"
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_18472_13927465.1199045846617
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've done some works, and searched in xenomai's native function.

To replace SysClkConnect I've created a periodic task with priority=90 that
wait 5ms.
The last operation in a task's cycle is semGive(gServiceSem);
A second task, non periodic, have as first operation of the cycle
semTake(gServiceSem,WAIT_FOREVER);
the second task has priority=50

when the total time for one cycle of task1 and task2 everything seems run
properly , when task2 take more then 5ms for do it's cycle
rt_task_wait_period(NULL) return me 146 and not 0, and the time for task1 is
not respected.

This sound strange for me, why the scheduler don't switch the task in
execution?


A second question is, if can I change (TaskIdSelf() == IdTask) with
(rt_task_self() == &IdTask)?

thanks for all, Racconico

2007/12/28, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Dec 28, 2007 2:56 AM, Racconico Lambrati
> <racconico.lambrati@domain.hid> wrote:
> >
> >
> > 2007/12/27, Philippe Gerum <rpm@xenomai.org>:
> > > Racconico Lambrati wrote:
> > > >
> > > > How can I run it in kernel space?
> > > > The application is designed to be little and stable, and with fusion
> > > > 0.9.1 run without problem
> > > >
> > >
> > > If your application based on 0.9.1 used to run in user-space, then it
> > > must have been based on the UVM support. This support has been
> dismissed
> > > since Xenomai v2.3-rc1, because it was a temporary hack allowing
> > > user-space development until all skins have a real user-space
> interface,
> > > which is now the case.
> >
> > murphy's law  could be applied here! I use uvm
> >
> > > The services you mention are now only available from the kernel-based
> > > interface, provided by the xeno_vxworks.ko module, because they do not
> > > make sense from a userland perspective.
> >
> > then is it possible to create a kernel-based application with vxworks
> skins?
> > How can i do it?
> > I use "$(xeno-config --uvm-ldflags) -lvxworks -lrtai -lm" as LDFLAGS
> option.
> >
> > > Userland applications based on the VxWorks API
> > > (/usr/xenomai/lib/libvxworks.so) should not need them at all. If for
> > > some reason they do, then you should consider splitting the
> application
> > > in two parts, one kernel-based, the other one running in userland. The
> > > point is that dealing with interrupts should most often remain a
> kernel
> > > business, and this obviously also applies to interposing on the tick
> > timer.
> >
> > I've alredy done, using rt_pipe to make a communication line to a non-RT
> > application and my RT application.
> >
> > > If your application was not based on the UVM, then it must have been
> > > running embodied into a kernel module, in which case the issue is
> > > already solved.
> >
> > This is not my case
> >
> > > Rehashing what Gilles already told you: until you actually explain
> _why_
> > > you need such services, nobody will be able to suggest any solution to
> > > your problem, I'm afraid.
> >
> > The application use intLock and intUnlock first of all to handle a CAN
> > device.
>
> This would better be done in a driver, in kernel-space. Or if you want
> to continue to handle the CAN device in user-space, you will have to
> replace intLock/intUnlock with a mutex.
>
> > I use it also to handle a timers array. when I delete a timers from an
> array
> > I disable the interrupt to avoid some race condition's problem (maybe a
> > timer that is going to be delete wake up during it's deleting routine).
>
> I am not sure I understand what you mean. If you are doing your own
> timer handling, you should probably use vxworks watchdogs instead.
> Xenomai timers are handled in a linked list by default, but you can
> choose other data structures if you have to handle a lot of timers.
> If by timers array, you mean an array of vxworks watchdogs, you do not
> have to worry about locking, this is already done by xenomai vxworks
> services. If what you want to protect is concurrent access to the
> array, then you can use a mutex.
>
> >
> > I use SysClkConnect to hang the clock to a function that send the Give
> > signal to a semaphore every 'n' cycle.
>
> You can use a watchdog for that too.
>
> >
> > the semaphore is used to give the start to a function that handle the
> most
> > important duty of the system, then when it term it cycle, it send the
> Give
> > signal to a second semaphore that will launch a second task that manage
> the
> > lesser important things.
> >
> > This is an overview of my software. there aren't many other thing, only
> the
> > processing of the data received from CAN device, that is a lot of code
> but
> > it don't need the realtime services. this code is executed in the first
> task
> >
> > I hope you understand my needs (my English is not so good).
>
> Do not worry, english is not my mother tongue, so, even if you make
> mistakes, I do not see them.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_18472_13927465.1199045846617
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve done some works, and searched in xenomai&#39;s native function.<br><br>To replace SysClkConnect I&#39;ve created a periodic task with priority=90 that wait 5ms.<br>The last operation in a task&#39;s cycle is semGive(gServiceSem);
<br>A second task, non periodic, have as first operation of the cycle semTake(gServiceSem,WAIT_FOREVER);<br>the second task has priority=50<br><br>when the total time for one cycle of task1 and task2 everything seems run properly , when task2 take more then 5ms for do it&#39;s cycle rt_task_wait_period(NULL) return me 146 and not 0, and the time for task1 is not respected.
<br><br>This sound strange for me, why the scheduler don&#39;t switch the task in execution?<br><br><br>A second question is, if can I change (TaskIdSelf() == IdTask) with (rt_task_self() == &amp;IdTask)?<br><br>thanks for all, Racconico
<br><br><div><span class="gmail_quote">2007/12/28, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Dec 28, 2007 2:56 AM, Racconico Lambrati<br>&lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt; 2007/12/27, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">
rpm@xenomai.org</a>&gt;:<br>&gt; &gt; Racconico Lambrati wrote:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; How can I run it in kernel space?<br>&gt; &gt; &gt; The application is designed to be little and stable, and with fusion<br>
&gt; &gt; &gt; 0.9.1 run without problem<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt; If your application based on 0.9.1 used to run in user-space, then it<br>&gt; &gt; must have been based on the UVM support. This support has been dismissed
<br>&gt; &gt; since Xenomai v2.3-rc1, because it was a temporary hack allowing<br>&gt; &gt; user-space development until all skins have a real user-space interface,<br>&gt; &gt; which is now the case.<br>&gt;<br>&gt; murphy&#39;s law&nbsp;&nbsp;could be applied here! I use uvm
<br>&gt;<br>&gt; &gt; The services you mention are now only available from the kernel-based<br>&gt; &gt; interface, provided by the xeno_vxworks.ko module, because they do not<br>&gt; &gt; make sense from a userland perspective.
<br>&gt;<br>&gt; then is it possible to create a kernel-based application with vxworks skins?<br>&gt; How can i do it?<br>&gt; I use &quot;$(xeno-config --uvm-ldflags) -lvxworks -lrtai -lm&quot; as LDFLAGS option.<br>&gt;
<br>&gt; &gt; Userland applications based on the VxWorks API<br>&gt; &gt; (/usr/xenomai/lib/libvxworks.so) should not need them at all. If for<br>&gt; &gt; some reason they do, then you should consider splitting the application
<br>&gt; &gt; in two parts, one kernel-based, the other one running in userland. The<br>&gt; &gt; point is that dealing with interrupts should most often remain a kernel<br>&gt; &gt; business, and this obviously also applies to interposing on the tick
<br>&gt; timer.<br>&gt;<br>&gt; I&#39;ve alredy done, using rt_pipe to make a communication line to a non-RT<br>&gt; application and my RT application.<br>&gt;<br>&gt; &gt; If your application was not based on the UVM, then it must have been
<br>&gt; &gt; running embodied into a kernel module, in which case the issue is<br>&gt; &gt; already solved.<br>&gt;<br>&gt; This is not my case<br>&gt;<br>&gt; &gt; Rehashing what Gilles already told you: until you actually explain _why_
<br>&gt; &gt; you need such services, nobody will be able to suggest any solution to<br>&gt; &gt; your problem, I&#39;m afraid.<br>&gt;<br>&gt; The application use intLock and intUnlock first of all to handle a CAN<br>&gt; device.
<br><br>This would better be done in a driver, in kernel-space. Or if you want<br>to continue to handle the CAN device in user-space, you will have to<br>replace intLock/intUnlock with a mutex.<br><br>&gt; I use it also to handle a timers array. when I delete a timers from an array
<br>&gt; I disable the interrupt to avoid some race condition&#39;s problem (maybe a<br>&gt; timer that is going to be delete wake up during it&#39;s deleting routine).<br><br>I am not sure I understand what you mean. If you are doing your own
<br>timer handling, you should probably use vxworks watchdogs instead.<br>Xenomai timers are handled in a linked list by default, but you can<br>choose other data structures if you have to handle a lot of timers.<br>If by timers array, you mean an array of vxworks watchdogs, you do not
<br>have to worry about locking, this is already done by xenomai vxworks<br>services. If what you want to protect is concurrent access to the<br>array, then you can use a mutex.<br><br>&gt;<br>&gt; I use SysClkConnect to hang the clock to a function that send the Give
<br>&gt; signal to a semaphore every &#39;n&#39; cycle.<br><br>You can use a watchdog for that too.<br><br>&gt;<br>&gt; the semaphore is used to give the start to a function that handle the most<br>&gt; important duty of the system, then when it term it cycle, it send the Give
<br>&gt; signal to a second semaphore that will launch a second task that manage the<br>&gt; lesser important things.<br>&gt;<br>&gt; This is an overview of my software. there aren&#39;t many other thing, only the<br>&gt; processing of the data received from CAN device, that is a lot of code but
<br>&gt; it don&#39;t need the realtime services. this code is executed in the first task<br>&gt;<br>&gt; I hope you understand my needs (my English is not so good).<br><br>Do not worry, english is not my mother tongue, so, even if you make
<br>mistakes, I do not see them.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_18472_13927465.1199045846617--

