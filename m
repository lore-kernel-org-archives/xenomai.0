Message-ID: <c73373920802150252t4b22000ct2dd5f291f2478a71@domain.hid>
Date: Fri, 15 Feb 2008 11:52:11 +0100
From: "Salvatore De Astis" <dev.rinux@domain.hid>
In-Reply-To: <2ff1a98a0802150218j572f2a2bk6167deb1eb742096@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4828_24023347.1203072731992"
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<2ff1a98a0802140142o538a956dva8f7d4f34bfbe415@domain.hid>
	<200802141053.02165.peter.soetens@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
	<c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
	<2ff1a98a0802150148g6c7f7e78k19a9a2a2b878ef2b@domain.hid>
	<c73373920802150215i7c63f77awe0dca6d8f9a0614e@domain.hid>
	<2ff1a98a0802150218j572f2a2bk6167deb1eb742096@domain.hid>
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

------=_Part_4828_24023347.1203072731992
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The loop which waits for a flag has a collateral effect: if my thread block
itself in its main routine how can I kill it in asyncronous mode?

2008/2/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Fri, Feb 15, 2008 at 11:15 AM, Salvatore De Astis
>
> <dev.rinux@domain.hid> wrote:
> >
> >
> > 2008/2/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > > On Fri, Feb 15, 2008 at 10:45 AM, Salvatore De Astis
> > >
> > > <dev.rinux@domain.hid> wrote:
> > > >
> > > >
> > > >
> > > >
> > >
> > > >  Hi at all,
> > > > I'am sure that the same code run fine with Xenomai-2.1.1, kernel
> > > > linux-2.6.15-ipipe-1.2-15.
> > > > Why there are problems now?
> > >
> > >
> > > Because now, xnpod_delete_thread sends a SIGKILL to the whole process
> > > when not killing the current task.
> > >
> > >
> > > > I want underline my purpose: my tasks should be exit in asyncronous
> way
> > > > executing costom exit routine.
> > > >  How can I do this in Xenomai?
> > >
> > >
> > > run the custom cleanup routine from the deleted thread itself and call
> > > rt_task_delete for the current task only.
> >
> > I can't run the custom cleanup routine from the delete thread itself
> > because, in my application, the main procedures of all threads run in an
> > infinite loop. Each tread suspend itsef after or before a cycle, another
> > thread (called Scheduler) resumes the threads accordig to a custom
> > scheduling policy. The cleanup routine of a thread is out of its
> infinite
> > cycle, of course.
> >  So, how can I do to preserve my thread's organization with xenomai?
>
>
> Replace the infinite loop with a loop which waits for a flag, use
> rt_task_unblock to unblock the task when it is suspended, test if the
> suspending call returns -EINTR, and break the loop in this case.
>
> --
>
> Gilles Chanteperdrix
>

------=_Part_4828_24023347.1203072731992
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The loop which waits for a flag has a collateral effect: if my thread block itself in its main routine how can I kill it in asyncronous mode?  <br><br><div><span class="gmail_quote">2008/2/15, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Feb 15, 2008 at 11:15 AM, Salvatore De Astis<br> <br>&lt;<a href="mailto:dev.rinux@domain.hid">dev.rinux@domain.hid</a>&gt; wrote:<br> &gt;<br> &gt;<br> &gt; 2008/2/15, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br>
 &gt; &gt; On Fri, Feb 15, 2008 at 10:45 AM, Salvatore De Astis<br> &gt; &gt;<br> &gt; &gt; &lt;<a href="mailto:dev.rinux@domain.hid">dev.rinux@domain.hid</a>&gt; wrote:<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br>
 &gt; &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;Hi at all,<br> &gt; &gt; &gt; I&#39;am sure that the same code run fine with Xenomai-2.1.1, kernel<br> &gt; &gt; &gt; linux-2.6.15-ipipe-1.2-15.<br> &gt; &gt; &gt; Why there are problems now?<br>
 &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; Because now, xnpod_delete_thread sends a SIGKILL to the whole process<br> &gt; &gt; when not killing the current task.<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; &gt; I want underline my purpose: my tasks should be exit in asyncronous way<br>
 &gt; &gt; &gt; executing costom exit routine.<br> &gt; &gt; &gt;&nbsp;&nbsp;How can I do this in Xenomai?<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; run the custom cleanup routine from the deleted thread itself and call<br> &gt; &gt; rt_task_delete for the current task only.<br>
 &gt;<br> &gt; I can&#39;t run the custom cleanup routine from the delete thread itself<br> &gt; because, in my application, the main procedures of all threads run in an<br> &gt; infinite loop. Each tread suspend itsef after or before a cycle, another<br>
 &gt; thread (called Scheduler) resumes the threads accordig to a custom<br> &gt; scheduling policy. The cleanup routine of a thread is out of its infinite<br> &gt; cycle, of course.<br> &gt;&nbsp;&nbsp;So, how can I do to preserve my thread&#39;s organization with xenomai?<br>
 <br> <br>Replace the infinite loop with a loop which waits for a flag, use<br> rt_task_unblock to unblock the task when it is suspended, test if the<br> suspending call returns -EINTR, and break the loop in this case.<br>
 <br> --<br> <br> Gilles Chanteperdrix<br> </blockquote></div><br>

------=_Part_4828_24023347.1203072731992--

