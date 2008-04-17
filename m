Message-ID: <a7575bba0804170410k6e05bf53v8b023065e22c1754@domain.hid>
Date: Thu, 17 Apr 2008 19:10:21 +0800
From: "Josh Zhao" <joshsystem@domain.hid>
In-Reply-To: <2ff1a98a0804170307v53ec52a6p553d2f93cd72e643@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8955_10291281.1208430621676"
References: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
	<a7575bba0804170215k2999fadcn8de7a4e0bf87c64e@domain.hid>
	<2ff1a98a0804170307v53ec52a6p553d2f93cd72e643@domain.hid>
Subject: Re: [Xenomai-core] About Xenomai questions
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
Cc: xenomai@xenomai.org

------=_Part_8955_10291281.1208430621676
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles, thanks a lot.
>This is the wrong list to ask them. This answer is the last I will
>make to you on this list for Xenomai questions.

 I m a beginner for Xenomai. Do you have any suggetions how to dig into the
xenomai code ?


2008/4/17, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Thu, Apr 17, 2008 at 11:15 AM, Josh Zhao <joshsystem@domain.hid> wrote:
> >
> >
> > Hi ,
> >   After reading Xenomai code, I have some questions:
>
>
> This is the wrong list to ask them. This answer is the last I will
> make to you on this list for Xenomai questions.
>
>
> >   1.    usespace-->
> rt_task_create  -->pthread_create-->__native_task_create
> >       So why xenomai use pthread  to invoke __native_task_create ?
>
>
> pthread_create creates a Linux thread, __native_task_create creates
> the Xenomai thread (sometimes called shadow thread) associated with
> Linux thread. The association happens in xnshadow_map.
>
>
> >
> >    2.   usespace-->rt_task_start(RT_TASK *task, void (*entry) (void
> > *cookie), void *cookie)-->
> >    kernel space --> __rt_task_start(struct task_struct *curr, struct
> pt_regs
> > *regs)-->
> > rt_task_start(task,
> >                   (void (*)(void *))__xn_reg_arg2(regs),
> >                  (void *)__xn_reg_arg3(regs));
> >
> >
> >      I can't understand that the entry paramter is address of function
> in
> > user space ,why it can be passed into kernel space by syscall?
>
>
> Well... why not ? It is not used in kernel-space, but passed again to
> user-space by xnshadow_wait_barrier.





>
> > 3.   the xnthread_t struct and  pod  sechedule algorithm looks very
> complex,
> > is there any papers taking about it?
>
>
> Every member of the xnthread_t structure is commented in
> include/nucleus/thread.h. The pod schedule algorithm is not that
> complicated: the scheduler priority queue is maintained by other
> functions (essentially xnpod_suspend and xnpod_resume), xnpod_schedule
> extracts the higher priority thread that is ready for the longest time
> and compares it with the current thread. If they are different, it
> switches to this new thread. That's all. I find xnpod_suspend for
> instance much more complicated.
>
> --
>
> Gilles
>

------=_Part_8955_10291281.1208430621676
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi <span class="gmail_quote">Gilles, thanks a lot.<br></span>&gt;This is the wrong list to ask them. This answer is the last I will<br> &gt;make to you on this list for Xenomai questions.<br> <br><span class="gmail_quote">&nbsp;I m a beginner for Xenomai. Do you have any suggetions how to dig into the xenomai code ?<br>
<br></span><br><div><span class="gmail_quote">2008/4/17, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

On Thu, Apr 17, 2008 at 11:15 AM, Josh Zhao &lt;<a href="mailto:joshsystem@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">joshsystem@domain.hid</a>&gt; wrote:<br> &gt;<br> &gt;<br> &gt; Hi ,<br>
 &gt;&nbsp;&nbsp; After reading Xenomai code, I have some questions:<br> <br>
 <br>This is the wrong list to ask them. This answer is the last I will<br> make to you on this list for Xenomai questions.<br> <br><br> &gt;&nbsp;&nbsp; 1.&nbsp;&nbsp;&nbsp;&nbsp;usespace--&gt; rt_task_create&nbsp;&nbsp;--&gt;pthread_create--&gt;__native_task_create<br>

 &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So why xenomai use pthread&nbsp;&nbsp;to invoke __native_task_create ?<br> <br> <br>pthread_create creates a Linux thread, __native_task_create creates<br> the Xenomai thread (sometimes called shadow thread) associated with<br>

 Linux thread. The association happens in xnshadow_map.<br> <br><br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp; usespace--&gt;rt_task_start(RT_TASK *task, void (*entry) (void<br> &gt; *cookie), void *cookie)--&gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;kernel space --&gt; __rt_task_start(struct task_struct *curr, struct pt_regs<br>

 &gt; *regs)--&gt;<br> &gt; rt_task_start(task,<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void (*)(void *))__xn_reg_arg2(regs),<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(void *)__xn_reg_arg3(regs));<br> &gt;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I can&#39;t understand that the entry paramter is address of function in<br>

 &gt; user space ,why it can be passed into kernel space by syscall?<br> <br> <br>Well... why not ? It is not used in kernel-space, but passed again to<br> user-space by xnshadow_wait_barrier.</blockquote><div><br><br>&nbsp;</div>

<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> &gt;<br> &gt; 3.&nbsp;&nbsp; the xnthread_t struct and&nbsp;&nbsp;pod&nbsp;&nbsp;sechedule algorithm looks very complex,<br>

 &gt; is there any papers taking about it?<br> <br> <br>Every member of the xnthread_t structure is commented in<br> include/nucleus/thread.h. The pod schedule algorithm is not that<br> complicated: the scheduler priority queue is maintained by other<br>

 functions (essentially xnpod_suspend and xnpod_resume), xnpod_schedule<br> extracts the higher priority thread that is ready for the longest time<br> and compares it with the current thread. If they are different, it<br>

 switches to this new thread. That&#39;s all. I find xnpod_suspend for<br> instance much more complicated.<br> <br> --<br> <br> Gilles<br> </blockquote></div><br>

------=_Part_8955_10291281.1208430621676--

