Message-ID: <4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
Date: Mon, 10 Jul 2006 16:48:42 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B1FDBD.4060600@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_94672_5517473.1152521322215"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_94672_5517473.1152521322215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan.

You mentioned:
"Depends on what you have to protect. The easiest way for short code
passages are still spinlocks with hard IRQ protection (under RTDM:
rtdm_lock_xxx). "

I read the code of rtdm_lock_xxx and find it mapped to spin_lock. If I
understand correctly,

a RTDM driver using:
rtdm_lock_get(&my_lock);

a normal linux driver using
spin_lock(&my_lock);

Can be used to protect some shared data structure between RTDM real-time
driver in Xenomai Domain
and a normal Linux driver, right?

I just started to write a RTDM driver, and I am not sure what existing linux
kernel services
I can use in the RTDM driver, e.g, wait queue, semaphores, request_dma(),
free_dma(), etc.
I have concern that the RTDM driver may not synchronize with linux kernel,
since it will
preempt Linux kernel whenever the HW interrupt is not masked.
Is there any guideline there?

Thanks for your advices.

-Yi



On 7/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Hi,
> >
> > Xenomai provides synchronize objects like semaphore and mutex and
> related
> > APIs, e.g: rt_sem_p(), rt_sem_v().
> > I think they can only synchonze between Xenomai tasks (e.g, tasks
> created
> > with rt_task_create()).
> >
> > Is there any way to synchonize between a "normal" Linux task and a
> Xenomai
> > task?
>
> Either by simply calling a standard sync-mechanism from the RT task so
> that it switches over to secondary mode, or by mapping the Linux task to
> a Xenomai task as well. The latter is simple too, and you can even leave
> its Linux scheduling policy at SCHED_OTHER with latest Xenomai (upcoming
> 2.2).
>
> > Is there way to synchronize between Linux and Xenomai domain in Kernel
> > space? (e.g, a Linux driver and a Xenomai driver)?
>
> Depends on what you have to protect. The easiest way for short code
> passages are still spinlocks with hard IRQ protection (under RTDM:
> rtdm_lock_xxx). If it's a more complex scenario, please describe it.
> There are several patterns available that may fit. They reach from
> polling in the non-RT context over virtual IRQs to Linux
> (rtdm_nrtsig_xxx) up to RT helper tasks.
>
> Jan
>
>
>
>

------=_Part_94672_5517473.1152521322215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan.<br><br>You mentioned:<br>&quot;Depends on what you have to protect. The easiest way for short code<br>passages are still spinlocks with hard IRQ protection (under RTDM:<br>rtdm_lock_xxx). &quot;<br><br>I read the code of rtdm_lock_xxx and find it mapped to spin_lock. If I understand correctly,
<br><br>a RTDM driver using:<br>rtdm_lock_get(&amp;my_lock);<br><br>a normal linux driver using<br>spin_lock(&amp;my_lock);<br><br>Can be used to protect some shared data structure between RTDM real-time driver in Xenomai Domain
<br>and a normal Linux driver, right?<br><br>I just started to write a RTDM driver, and I am not sure what existing linux kernel services <br>I can use in the RTDM driver, e.g, wait queue, semaphores, request_dma(), free_dma(), etc.
<br>I have concern that the RTDM driver may not synchronize with linux kernel, since it will<br>preempt Linux kernel whenever the HW interrupt is not masked. <br>Is there any guideline there?<br><br>Thanks for your advices.
<br><br>-Yi<br><br><br><br><div><span class="gmail_quote">On 7/10/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Li Yi (Adam) wrote:<br>&gt; Hi,<br>&gt;<br>&gt; Xenomai provides synchronize objects like semaphore and mutex and related<br>&gt; APIs, e.g: rt_sem_p(), rt_sem_v().<br>&gt; I think they can only synchonze between Xenomai tasks (
e.g, tasks created<br>&gt; with rt_task_create()).<br>&gt;<br>&gt; Is there any way to synchonize between a &quot;normal&quot; Linux task and a Xenomai<br>&gt; task?<br><br>Either by simply calling a standard sync-mechanism from the RT task so
<br>that it switches over to secondary mode, or by mapping the Linux task to<br>a Xenomai task as well. The latter is simple too, and you can even leave<br>its Linux scheduling policy at SCHED_OTHER with latest Xenomai (upcoming
<br>2.2).<br><br>&gt; Is there way to synchronize between Linux and Xenomai domain in Kernel<br>&gt; space? (e.g, a Linux driver and a Xenomai driver)?<br><br>Depends on what you have to protect. The easiest way for short code
<br>passages are still spinlocks with hard IRQ protection (under RTDM:<br>rtdm_lock_xxx). If it's a more complex scenario, please describe it.<br>There are several patterns available that may fit. They reach from<br>polling in the non-RT context over virtual IRQs to Linux
<br>(rtdm_nrtsig_xxx) up to RT helper tasks.<br><br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_94672_5517473.1152521322215--

