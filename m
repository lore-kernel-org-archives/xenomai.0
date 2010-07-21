MIME-Version: 1.0
In-Reply-To: <4C46D49F.6030102@domain.hid>
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
	<4C46D49F.6030102@domain.hid>
Date: Wed, 21 Jul 2010 13:05:29 +0100
Message-ID: <AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=0016364c440a2ab692048be49ea0
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
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

--0016364c440a2ab692048be49ea0
Content-Type: text/plain; charset=ISO-8859-1

On 21 July 2010 12:06, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Stephen Bryant wrote:
> > Hi,
> >
> > I have some code (simplified example below) which uses
> > 'pthread_wait_np(&Overrun)' within a while loop, using a period of
> > 1,000,000ns (1ms) which has been set using 'pthread_make_periodic_np()'.
> > This wakes the thread up less than 2,000ns late in general, sometimes
> > 20,000ns late, and at most less than 45,000ns late.
>
> Since you do not tell us, I guess you are running on x86. Depending on
> the x86 you are running, 45 us may be high.
>
>
Yes, it is x86, sorry for the omission. What sort of latencies would you
expect me to see?


>  To ensure that I perform
> > the tasks within the thread from a consistent 'millisecond tick' I set an
> > expected time value 45,000ns later than the earliest wake time each
> period,
> > and then use a busy loop until the current time equals this expected
> time.
> > This busy loop takes < 600ns per cycle, and so the latency from my
> expected
> > time should be a maximum of 600ns.
>
> This reasoning is flawed: you may be preempted by interrupts any time.
> Including just about at the time where you were going to exit the busy
> loop. Unless you spin irqs off, and only reenable irqs when the job the
> thread is supposed to be doing is done. And if you have an SMI issue,
> even turning off the interrupts will not help.
>
>
I was under the (apparently flawed) impression that Adeos was used to
prevent interrupts preempting a running high priority task in primary mode,
only forwarding the interrupts to Linux once the task was waiting /
finished. I guess that it only prevents a subset of all interrupts, and the
rest must be specifically disabled then re-enabled by the program, or maybe
it does not intercept any interrupts?


>
>  The latencies I am actually seeing are as
> > high as 13,000ns, and these occur during this busy loop (I have timed
> it),
> > implying that this loop is being preempted.
> >
> > while(1)
> > {
> >    pthread_wait_np(&Overrun);
> >
> >    WakeTime = GetTime();
> >    while(WakeTime < ExpectedTime)
> >    { WakeTime = GetTime(); } // Preempted here
> >
> >    DoWork();
> >
> >    ExpectedTime += Period;
> > }
> >
> > This is a Xenomai POSIX thread with a priority of 99, and is the only
> thread
> > within my program with a priority of 99 or higher. There are no context
> > switches occuring within this thread (confirmed using
> pthread_set_mode_np(0,
> > PTHREAD_WARNSW)).
> >
> > I have had a brief experimentation with kernel settings, for example
> > applying the SMI workaround, but this produces no difference to the
> > preemption that I measure.
>
> The question is: is the SMI workaround working for your chipset? If that
> is the case, you should get messages in the kernel logs.
>
>
I've had a look at dmesg, but cannot find any references to SMI - what
should I be looking for?


> --
>                                             Gilles.
>

Steve

--0016364c440a2ab692048be49ea0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 21 July 2010 12:06, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Stephen Bryant wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have some code (simplified example below) which uses<br>
&gt; &#39;pthread_wait_np(&amp;Overrun)&#39; within a while loop, using a p=
eriod of<br>
&gt; 1,000,000ns (1ms) which has been set using &#39;pthread_make_periodic_=
np()&#39;.<br>
&gt; This wakes the thread up less than 2,000ns late in general, sometimes<=
br>
&gt; 20,000ns late, and at most less than 45,000ns late.<br>
<br>
</div>Since you do not tell us, I guess you are running on x86. Depending o=
n<br>
the x86 you are running, 45 us may be high.<br>
<div class=3D"im"><br></div></blockquote><div><br>Yes, it is x86, sorry for=
 the omission. What sort of latencies would you expect me to see?<br><br></=
div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">
<br>
=A0To ensure that I perform<br>
&gt; the tasks within the thread from a consistent &#39;millisecond tick&#3=
9; I set an<br>
&gt; expected time value 45,000ns later than the earliest wake time each pe=
riod,<br>
&gt; and then use a busy loop until the current time equals this expected t=
ime.<br>
&gt; This busy loop takes &lt; 600ns per cycle, and so the latency from my =
expected<br>
&gt; time should be a maximum of 600ns.<br>
<br>
</div>This reasoning is flawed: you may be preempted by interrupts any time=
.<br>
Including just about at the time where you were going to exit the busy<br>
loop. Unless you spin irqs off, and only reenable irqs when the job the<br>
thread is supposed to be doing is done. And if you have an SMI issue,<br>
even turning off the interrupts will not help.<br>
<div class=3D"im"><br></div></blockquote><div><br>I was under the (apparent=
ly flawed) impression that Adeos was used to prevent interrupts preempting =
a running high priority task in primary mode, only forwarding the interrupt=
s to Linux once the task was waiting / finished. I guess that it only preve=
nts a subset of all interrupts, and the rest must be specifically disabled =
then re-enabled by the program, or maybe it does not intercept any interrup=
ts?<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div cla=
ss=3D"im">
<br>
=A0The latencies I am actually seeing are as<br>
&gt; high as 13,000ns, and these occur during this busy loop (I have timed =
it),<br>
&gt; implying that this loop is being preempted.<br>
&gt;<br>
&gt; while(1)<br>
&gt; {<br>
&gt; =A0 =A0pthread_wait_np(&amp;Overrun);<br>
&gt;<br>
&gt; =A0 =A0WakeTime =3D GetTime();<br>
&gt; =A0 =A0while(WakeTime &lt; ExpectedTime)<br>
&gt; =A0 =A0{ WakeTime =3D GetTime(); } // Preempted here<br>
&gt;<br>
&gt; =A0 =A0DoWork();<br>
&gt;<br>
&gt; =A0 =A0ExpectedTime +=3D Period;<br>
&gt; }<br>
&gt;<br>
&gt; This is a Xenomai POSIX thread with a priority of 99, and is the only =
thread<br>
&gt; within my program with a priority of 99 or higher. There are no contex=
t<br>
&gt; switches occuring within this thread (confirmed using pthread_set_mode=
_np(0,<br>
&gt; PTHREAD_WARNSW)).<br>
&gt;<br>
&gt; I have had a brief experimentation with kernel settings, for example<b=
r>
&gt; applying the SMI workaround, but this produces no difference to the<br=
>
&gt; preemption that I measure.<br>
<br>
</div>The question is: is the SMI workaround working for your chipset? If t=
hat<br>
is the case, you should get messages in the kernel logs.<br>
<br></blockquote><div><br>I&#39;ve had a look at dmesg, but cannot find any=
 references to SMI - what should I be looking for?<br>=A0</div><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>Steve<br>

--0016364c440a2ab692048be49ea0--

