Message-ID: <ea7e69bd0811161759i3aecc0c0v8b490216df539533@domain.hid>
Date: Sun, 16 Nov 2008 19:59:15 -0600
From: "Jefferson Noxon" <jeff@domain.hid>
In-Reply-To: <49206D48.4010106@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21693_27647990.1226887155609"
References: <ea7e69bd0811161026q4481e280l7dcf664fee50eeec@domain.hid>
	<49206D48.4010106@domain.hid>
Subject: Re: [Xenomai-help] Maximum number of kernel tasks?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_21693_27647990.1226887155609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Nov 16, 2008 at 12:58 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jefferson Noxon wrote:
> > Hello,
> >
> > This is my first project using Xenomai. I have a Diamond Systems Athena
> II
> > board with an 800 MHz VIA Mark (Corefusion) chip. I built Xenomai 2.4.5
> with
> > Linux kernel 2.6.26.5 and I-pipe 2.0-09.
> >
> > For some reason I can create 7 kernel tasks just fine, but the 8th task
> > fails with -ENOMEM in rt_task_create(). I increased the heap size from
> 128Kb
> > to 256Kb, but the problem persists. If I remove my kernel module and
> re-load
> > it after a task creation fails, I get an oops in __xntimer_init after
> > starting my first task (which is periodic).
>
> This should be fix in xenomai 2.4.6.
>

Confirmed, thank you.


> >
> > If I build the same code to run in user-space (I have ifdefs allowing me
> to
> > build it either way), I can create as many tasks as I want and my code
> > behaves exactly as I would expect it to.
> >
> > I imagine I am probably doing something stupid, but since it works in
> user
> > mode I'm not sure what to check. Is there a limit of RT kernel tasks? If
> > not, any pointers on how to debug this would be appreciated.
>
> Did you try to change the stack pool setting in kernel configuration?
>
>
That fixed it. Thank you very much. Xenomai is incredible. I was worried
about a big learning curve, but I got up and running in almost no time.

------=_Part_21693_27647990.1226887155609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Nov 16, 2008 at 12:58 PM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Jefferson Noxon wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; This is my first project using Xenomai. I have a Diamond Systems Athena II<br>
&gt; board with an 800 MHz VIA Mark (Corefusion) chip. I built Xenomai 2.4.5 with<br>
&gt; Linux kernel <a href="http://2.6.26.5" target="_blank">2.6.26.5</a> and I-pipe 2.0-09.<br>
&gt;<br>
&gt; For some reason I can create 7 kernel tasks just fine, but the 8th task<br>
&gt; fails with -ENOMEM in rt_task_create(). I increased the heap size from 128Kb<br>
&gt; to 256Kb, but the problem persists. If I remove my kernel module and re-load<br>
&gt; it after a task creation fails, I get an oops in __xntimer_init after<br>
&gt; starting my first task (which is periodic).<br>
<br>
</div>This should be fix in xenomai <a href="http://2.4.6." target="_blank">2.4.6.</a><br>
<div class="Ih2E3d"></div></blockquote><div><br>Confirmed, thank you.<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">
<br>
&gt;<br>
&gt; If I build the same code to run in user-space (I have ifdefs allowing me to<br>
&gt; build it either way), I can create as many tasks as I want and my code<br>
&gt; behaves exactly as I would expect it to.<br>
&gt;<br>
&gt; I imagine I am probably doing something stupid, but since it works in user<br>
&gt; mode I&#39;m not sure what to check. Is there a limit of RT kernel tasks? If<br>
&gt; not, any pointers on how to debug this would be appreciated.<br>
<br>
</div>Did you try to change the stack pool setting in kernel configuration?<br>
<br>
</blockquote><div><br>That fixed it. Thank you very much. Xenomai is incredible. I was worried about a big learning curve, but I got up and running in almost no time. <br></div></div>

------=_Part_21693_27647990.1226887155609--

