Message-ID: <c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
Date: Fri, 15 Feb 2008 10:45:38 +0100
From: "Salvatore De Astis" <dev.rinux@domain.hid>
In-Reply-To: <c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4699_24124734.1203068738344"
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<2ff1a98a0802140142o538a956dva8f7d4f34bfbe415@domain.hid>
	<200802141053.02165.peter.soetens@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
Subject: Re: [Xenomai-help] Why Xenomai kill my process?
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
Cc: xenomai@xenomai.org

------=_Part_4699_24124734.1203068738344
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi at all,
I'am sure that the same code run fine with Xenomai-2.1.1, kernel
linux-2.6.15-ipipe-1.2-15.
Why there are problems now?
I want underline my purpose: my tasks should be exit in asyncronous way
executing costom exit routine.
How can I do this in Xenomai?
I've considered the use of rt_add_hook() but compiling the code the compiler
returns these errors:
warning: implicit declaration of function `rt_task_add_hook'
undefined reference to `rt_task_add_hook'
collect2: ld returned 1 exit status

Thanks for help!

Salvatore De Astis
>
>
>
> 2008/2/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> >
> > On Thu, Feb 14, 2008 at 10:53 AM, Peter Soetens <peter.soetens@domain.hid>
> > wrote:
> > > On Thursday 14 February 2008 10:42:23 Gilles Chanteperdrix wrote:
> > >  > On Wed, Feb 13, 2008 at 5:29 PM, Salvatore De Astis <
> > dev.rinux@domain.hid>
> > >  wrote:
> > >  > > Hi,
> > >  > > I need to implement a multitask application.
> > >  > > The most important point is to have a 'custom' exit procedure for
> > each
> > >  > > task. The calling of the exit procedure should happen in
> > asynchronous
> > >  > > mode. The exit procedure of each task, after the 'custom' code,
> > must call
> > >  > >  the rt_task_delete()   before leaving.
> > >  > >
> > >  > > The following code is a simple example:
> > >  > > There are two tasks, two semaphores and two other tasks (pending
> > on
> > >  > > semaphores) whose target is to execute the parent's exit
> > procedure.
> > >  > > In this case the exit procedure is the my_exit() routine for both
> > tasks,
> > >  > > but, of course, I'd like to have custom exit procedure for each
> > task.
> > >  > >  Please read the questions following the code section.
> > >  > >
> > >  > > Why the opaque2 is 0 in Pippo's rt_task_delete call? Dmesg shows
> > me
> > >  > > 3086322608 in __rt_task_create() of Pippo task.
> > >  > > What's wrong with my code?
> > >  > >  Does a better method exist to implemet  asyncronous
> > rt_task_delete in
> > >  > > Xenomai?
> > >  >
> > >  > The best way to do what you want to do is to call rt_task_delete
> > from
> > >  > the task to be deleted itself, because trying to delete a thread
> > from
> > >  > another thread entails problems which can only be solved by sending
> > a
> > >  > SIGKILL to the whole application.
> > >
> > >  or by using rt_task_join, naturally ! This requires that you create a
> > joinable
> > >  thread though, using T_JOINABLE in rt_task_spawn.
> >
> >
> > I am afraid this will not help. As far as I understand the code, the
> > SIGKILL signal is sent to the whole process if xnpod_delete_thread is
> > reached before the task answered the pthread_cancel request by
> > cleaning itself up properly.
> >
> > --
> >
> > Gilles Chanteperdrix
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>
>

------=_Part_4699_24124734.1203068738344
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><span class="gmail_quote"><br>
</span>Hi at all,<br>I&#39;am sure that the same code run fine with Xenomai-2.1.1, kernel linux-2.6.15-ipipe-1.2-15. <br>Why there are problems now?<br>I want underline my purpose: my tasks should be exit in asyncronous way executing costom exit routine. <br>

How can I do this in Xenomai?<br>I&#39;ve considered the use of rt_add_hook() but compiling the code the compiler returns these errors:<br>warning: implicit declaration of function `rt_task_add_hook&#39;<br>undefined reference to `rt_task_add_hook&#39;<br>

collect2: ld returned 1 exit status<span class="q"><br><br>Thanks for help!<br><br>Salvatore De Astis</span><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<span class="q"><br><br></span><div><span class="gmail_quote">2008/2/14, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><div>
<span class="e" id="q_1181c7113bdc4af2_3"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Thu, Feb 14, 2008 at 10:53 AM, Peter Soetens &lt;<a href="mailto:peter.soetens@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">peter.soetens@domain.hid</a>&gt; wrote:<br> &gt; On Thursday 14 February 2008 10:42:23 Gilles Chanteperdrix wrote:<br>
 &gt;&nbsp;&nbsp;&gt; On Wed, Feb 13, 2008 at 5:29 PM, Salvatore De Astis &lt;<a href="mailto:dev.rinux@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">dev.rinux@domain.hid</a>&gt;<br>
 &gt;&nbsp;&nbsp;wrote:<br> &gt;&nbsp;&nbsp;&gt; &gt; Hi,<br> &gt;&nbsp;&nbsp;&gt; &gt; I need to implement a multitask application.<br> &gt;&nbsp;&nbsp;&gt; &gt; The most important point is to have a &#39;custom&#39; exit procedure for each<br> &gt;&nbsp;&nbsp;&gt; &gt; task. The calling of the exit procedure should happen in asynchronous<br>

 &gt;&nbsp;&nbsp;&gt; &gt; mode. The exit procedure of each task, after the &#39;custom&#39; code, must call<br> &gt;&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp;the rt_task_delete()&nbsp;&nbsp; before leaving.<br> &gt;&nbsp;&nbsp;&gt; &gt;<br> &gt;&nbsp;&nbsp;&gt; &gt; The following code is a simple example:<br>

 &gt;&nbsp;&nbsp;&gt; &gt; There are two tasks, two semaphores and two other tasks (pending on<br> &gt;&nbsp;&nbsp;&gt; &gt; semaphores) whose target is to execute the parent&#39;s exit procedure.<br> &gt;&nbsp;&nbsp;&gt; &gt; In this case the exit procedure is the my_exit() routine for both tasks,<br>

 &gt;&nbsp;&nbsp;&gt; &gt; but, of course, I&#39;d like to have custom exit procedure for each task.<br> &gt;&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp;Please read the questions following the code section.<br> &gt;&nbsp;&nbsp;&gt; &gt;<br> &gt;&nbsp;&nbsp;&gt; &gt; Why the opaque2 is 0 in Pippo&#39;s rt_task_delete call? Dmesg shows me<br>

 &gt;&nbsp;&nbsp;&gt; &gt; 3086322608 in __rt_task_create() of Pippo task.<br> &gt;&nbsp;&nbsp;&gt; &gt; What&#39;s wrong with my code?<br> &gt;&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp;Does a better method exist to implemet&nbsp;&nbsp;asyncronous rt_task_delete in<br> &gt;&nbsp;&nbsp;&gt; &gt; Xenomai?<br>

 &gt;&nbsp;&nbsp;&gt;<br> &gt;&nbsp;&nbsp;&gt; The best way to do what you want to do is to call rt_task_delete from<br> &gt;&nbsp;&nbsp;&gt; the task to be deleted itself, because trying to delete a thread from<br> &gt;&nbsp;&nbsp;&gt; another thread entails problems which can only be solved by sending a<br>

 &gt;&nbsp;&nbsp;&gt; SIGKILL to the whole application.<br> &gt;<br> &gt;&nbsp;&nbsp;or by using rt_task_join, naturally ! This requires that you create a joinable<br> &gt;&nbsp;&nbsp;thread though, using T_JOINABLE in rt_task_spawn.<br> <br> <br>I am afraid this will not help. As far as I understand the code, the<br>

 SIGKILL signal is sent to the whole process if xnpod_delete_thread is<br> reached before the task answered the pthread_cancel request by<br> cleaning itself up properly.<br> <br> --<br> <br> Gilles Chanteperdrix<br> <br>

<br> _______________________________________________<br> Xenomai-help mailing list<br> <a href="mailto:Xenomai-help@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Xenomai-help@domain.hid</a><br>
 <a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://mail.gna.org/listinfo/xenomai-help</a><br>
 </blockquote></span></div></div><br>
</blockquote></div><br>

------=_Part_4699_24124734.1203068738344--

