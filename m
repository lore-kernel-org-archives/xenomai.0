MIME-Version: 1.0
In-Reply-To: <CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
Date: Tue, 4 Oct 2011 10:40:06 -0300
Message-ID: <CAMwkeZxdDx1KhALR961JLqycaG6DMP8-4HoV_b+ROKRVDH1rzw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec52e5d93ba196904ae793a9f
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec52e5d93ba196904ae793a9f
Content-Type: text/plain; charset=UTF-8

2011/10/4 Julien Delange <julien.delange@domain.hid>

> On Tue, Oct 4, 2011 at 7:16 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > I am sorry, I do not really understand what you are doing, what has
> > CONFIG_HZ to do with your issue?
>
> I was wondering if this configuration item may have an impact on the
> kernel scheduling speed.
>
>
> > Could you post a self-contained example allowing to reproduce the issue
> > you observe?
>
> So, basically, I just create a start a native xenomai thread :
>   rt_task_create(&task, "Read IO Card", 0, 99, T_FPU);
>   rt_task_start (&task, &polling_task, 0);
>
>
> And then, the task itself performs a loop that acquires data on a
> periodic basis of 1ms (see code below).
> The problem is that when I run the code, the value of missed in either
> 1 or 2, meaning that the deadline expired and the task does not meet
> its timing requirements.
>
> So, if you have any suggestion/comments to improve this code or how
> kernel configuration may impact the performance of such piece of code,
> it would be very interesting.
>
>
Dear Julien,

In my opinion, instruction lists are definitely not the way to go for high
speed acquisitions. The cost of setting up an instruction (from a
kernel/board perspective, not from the user perspective) is very high and it
is linear with the number of channels. At this point you want to consider
using the "command" infrastructure, which will provide DMA transferred
acquisitions.

In your case, you can take advantage of your DAQ board's clock and set it up
to provide you with precisely timed data. Then you have to decide whether
you care more about throughput or lattency. In the first case you can
achieve higher transfer rates using larger transfer blocks. In the second
case, you will have to use smaller transfer blocks, either with
"a4l_set_wake_size()" (or similar, I don't recall right now) or configuring
your board with the TRIG_WAKE_EOS flag.

Finally, you won't strictly need to program a periodic task. Using blocking
xenomai-syscalls you will be able to acquire the DAQ-timed data properly.

I hope this helps.

Good luck,
Fernando

--bcaec52e5d93ba196904ae793a9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/10/4 Julien Delange <span dir=3D"ltr">&lt;<=
a href=3D"mailto:julien.delange@domain.hid">julien.delange@domain.hid</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Tue, Oct 4, 2011 at 7:16 AM, Gilles Chanteperdrix<br>
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdri=
x@domain.hid</a>&gt; wrote:<br>
&gt; I am sorry, I do not really understand what you are doing, what has<br=
>
&gt; CONFIG_HZ to do with your issue?<br>
<br>
</div>I was wondering if this configuration item may have an impact on the<=
br>
kernel scheduling speed.<br>
<div class=3D"im"><br>
<br>
&gt; Could you post a self-contained example allowing to reproduce the issu=
e<br>
&gt; you observe?<br>
<br>
</div>So, basically, I just create a start a native xenomai thread :<br>
 =C2=A0 rt_task_create(&amp;task, &quot;Read IO Card&quot;, 0, 99, T_FPU);<=
br>
 =C2=A0 rt_task_start (&amp;task, &amp;polling_task, 0);<br>
<br>
<br>
And then, the task itself performs a loop that acquires data on a<br>
periodic basis of 1ms (see code below).<br>
The problem is that when I run the code, the value of missed in either<br>
1 or 2, meaning that the deadline expired and the task does not meet<br>
its timing requirements.<br>
<br>
So, if you have any suggestion/comments to improve this code or how<br>
kernel configuration may impact the performance of such piece of code,<br>
it would be very interesting.<br>
<br></blockquote></div><br>Dear Julien,<br><br>In my opinion, instruction l=
ists are definitely not the way to go for high speed acquisitions. The cost=
 of setting up an instruction (from a kernel/board perspective, not from th=
e user perspective) is very high and it is linear with the number of channe=
ls. At this point you want to consider using the &quot;command&quot; infras=
tructure, which will provide DMA transferred acquisitions.<br>
<br>In your case, you can take advantage of your DAQ board&#39;s clock and =
set it up to provide you with precisely timed data. Then you have to decide=
 whether you care more about throughput or lattency. In the first case you =
can achieve higher transfer rates using larger transfer blocks. In the seco=
nd case, you will have to use smaller transfer blocks, either with &quot;a4=
l_set_wake_size()&quot; (or similar, I don&#39;t recall right now) or confi=
guring your board with the TRIG_WAKE_EOS flag.<br>
<br>Finally, you won&#39;t strictly need to program a periodic task. Using =
blocking xenomai-syscalls you will be able to acquire the DAQ-timed data pr=
operly.<br><br>I hope this helps.<br><br>Good luck,<br>Fernando<br>

--bcaec52e5d93ba196904ae793a9f--

