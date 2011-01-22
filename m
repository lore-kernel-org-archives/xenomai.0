MIME-Version: 1.0
Sender: mau.salvi@domain.hid
In-Reply-To: <1295629895.1828.59.camel@domain.hid>
References: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
	<1295629895.1828.59.camel@domain.hid>
Date: Sat, 22 Jan 2011 15:26:19 +0100
Message-ID: <AANLkTikJtku4wq6mm_983Xc2e1PzTr=C=2+HKArO=KXa@domain.hid>
From: Mauro <mau.salvi@domain.hid>
Content-Type: multipart/alternative; boundary=0015175cde7479a7af049a7026ac
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Michel Rinaldi <automation.03@domain.hid>

--0015175cde7479a7af049a7026ac
Content-Type: text/plain; charset=ISO-8859-1

2011/1/21 Philippe Gerum <rpm@xenomai.org>

> On Fri, 2011-01-21 at 18:01 +0100, Michel Rinaldi wrote:
> > Hi to all,
> >
> > I'm running an application on a Linux system with kernel 2.6.35.7
> > patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04.
> > My application uses native skin and creates some realtime tasks, each
> > with rt_task_shadow(), each other with rt_task_create().
>
> Sorry, -ENOPARSE. rt_task_shadow() is usually invoked from the main
> thread to make it a Xenomai thread, rt_task_create is normally used to
> create more tasks. Who is doing what in your code exactly? How many
> times is rt_task_shadow() invoked?
>

I apologize for "tar.gzipped" :-) explanation.
I have one main thread that calls rt_task_shadow() to become a real-time
task.
This task creates a pthread that makes itself a real-time thread with
rt_task_shadow() call.
Then, latter task creates a new real-time task with rt_task_create().
First rt_task_create() call spends more time, next calls are immediate ( <
1millisecond ).


> >  When I call for first time rt_task_create(), this function is very
> > slow (700-800 ms) to execute, also if rt_task_shadow() calls come
> > first. Subsequent calls of rt_task_create() are quick as expected. I
> > read on manual that at first call rt_task_create() creates a signal
> > handler for SIGWINCH signal: could be this operation that wastes time,
> > maybe on waiting some resources from Linx kernel?
>
> No, can't be that long. Something looks wrong in your application init.
>

I'll do additional checks on my code monday.


>
> > Another problem that I've encountered is that if I call a
> > rt_int_delete() and then a rt_task_join() on userspace task that
> > handles destroyed IRQ,  rt_task_join() never returns (obviously this
> > task was created with joinable flag). If I create this task without
> > joinable flag and then I call rt_task_delete() instead rt_task_join()
> > I obtain two different behaviours: sometimes rt_task_delete() returns
> > but I still view task on /proc/xenomai/sched (with X status),
> > sometimes system freezes on this call.
>
> Make sure to test the return values of ALL Xenomai syscalls in your app,
> particularly what rt_intr_wait() sends you back, and make sure to break
> out from your work loop whenever it signals any error.
>

I'll also add additional checks on all Xenomai calls.
Thank you very much.
Regards
Mauro Salvini


>
> > Thanks to all in advance.
> > Regards
> >
> > Mauro Salvini
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--0015175cde7479a7af049a7026ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/1/21 Philippe Gerum <span dir=3D"lt=
r">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Fri, 2011-01-21 at 18:01 +0100, Michel Rinaldi wrote:<=
br>
&gt; Hi to all,<br>
&gt;<br>
&gt; I&#39;m running an application on a Linux system with kernel 2.6.35.7<=
br>
&gt; patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04.<br>
&gt; My application uses native skin and creates some realtime tasks, each<=
br>
&gt; with rt_task_shadow(), each other with rt_task_create().<br>
<br>
</div>Sorry, -ENOPARSE. rt_task_shadow() is usually invoked from the main<b=
r>
thread to make it a Xenomai thread, rt_task_create is normally used to<br>
create more tasks. Who is doing what in your code exactly? How many<br>
times is rt_task_shadow() invoked?<br></blockquote><div><br></div><div>I ap=
ologize for &quot;tar.gzipped&quot; :-) explanation.</div><div>I have one m=
ain thread that calls=A0rt_task_shadow() to become a real-time task.</div>
<div>This task creates a pthread that makes itself a real-time thread with =
rt_task_shadow() call.</div><div>Then, latter task creates a new real-time =
task with rt_task_create().</div><div>First=A0rt_task_create() call spends =
more time, next calls are immediate ( &lt; 1millisecond ).</div>
<div><br></div><meta http-equiv=3D"content-type" content=3D"text/html; char=
set=3Dutf-8"><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dutf-8"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im"><br>
&gt; =A0When I call for first time rt_task_create(), this function is very<=
br>
&gt; slow (700-800 ms) to execute, also if rt_task_shadow() calls come<br>
&gt; first. Subsequent calls of rt_task_create() are quick as expected. I<b=
r>
&gt; read on manual that at first call rt_task_create() creates a signal<br=
>
&gt; handler for SIGWINCH signal: could be this operation that wastes time,=
<br>
&gt; maybe on waiting some resources from Linx kernel?<br>
<br>
</div>No, can&#39;t be that long. Something looks wrong in your application=
 init.<br></blockquote><div><br></div><div>I&#39;ll do additional checks on=
 my code monday.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im"><br>
&gt; Another problem that I&#39;ve encountered is that if I call a<br>
&gt; rt_int_delete() and then a rt_task_join() on userspace task that<br>
&gt; handles destroyed IRQ, =A0rt_task_join() never returns (obviously this=
<br>
&gt; task was created with joinable flag). If I create this task without<br=
>
&gt; joinable flag and then I call rt_task_delete() instead rt_task_join()<=
br>
&gt; I obtain two different behaviours: sometimes rt_task_delete() returns<=
br>
&gt; but I still view task on /proc/xenomai/sched (with X status),<br>
&gt; sometimes system freezes on this call.<br>
<br>
</div>Make sure to test the return values of ALL Xenomai syscalls in your a=
pp,<br>
particularly what rt_intr_wait() sends you back, and make sure to break<br>
out from your work loop whenever it signals any error.<br></blockquote><div=
><br></div><div>I&#39;ll also add additional checks on all Xenomai calls.</=
div><div>Thank you very much.</div><div>Regards</div><div>Mauro Salvini</di=
v>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; Thanks to all in advance.<br>
&gt; Regards<br>
&gt;<br>
&gt; Mauro Salvini<br>
&gt;<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
--<br>
Philippe.<br>
<br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</blockquote></div><br>

--0015175cde7479a7af049a7026ac--

