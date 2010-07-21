MIME-Version: 1.0
In-Reply-To: <AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
	<4C46D49F.6030102@domain.hid>
	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
Date: Wed, 21 Jul 2010 14:04:04 +0100
Message-ID: <AANLkTikDcX_jugkSkTl14HJEvbj3RytssRtIYyXozOyW@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=001636417da3b92ec5048be56fac
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

--001636417da3b92ec5048be56fac
Content-Type: text/plain; charset=ISO-8859-1

On 21 July 2010 13:05, Stephen Bryant <sbxenomai@domain.hid> wrote:

> On 21 July 2010 12:06, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> Stephen Bryant wrote:
>> > Hi,
>> >
>> > I have some code (simplified example below) which uses
>> > 'pthread_wait_np(&Overrun)' within a while loop, using a period of
>> > 1,000,000ns (1ms) which has been set using 'pthread_make_periodic_np()'.
>> > This wakes the thread up less than 2,000ns late in general, sometimes
>> > 20,000ns late, and at most less than 45,000ns late.
>>
>> Since you do not tell us, I guess you are running on x86. Depending on
>> the x86 you are running, 45 us may be high.
>>
>>
> Yes, it is x86, sorry for the omission. What sort of latencies would you
> expect me to see?
>

Sorry, I should have given more info. It is an Intel Core 2 Duo, running a
kernel with SMP disabled.


>
>>  To ensure that I perform
>> > the tasks within the thread from a consistent 'millisecond tick' I set
>> an
>> > expected time value 45,000ns later than the earliest wake time each
>> period,
>> > and then use a busy loop until the current time equals this expected
>> time.
>> > This busy loop takes < 600ns per cycle, and so the latency from my
>> expected
>> > time should be a maximum of 600ns.
>>
>> This reasoning is flawed: you may be preempted by interrupts any time.
>> Including just about at the time where you were going to exit the busy
>> loop. Unless you spin irqs off, and only reenable irqs when the job the
>> thread is supposed to be doing is done. And if you have an SMI issue,
>> even turning off the interrupts will not help.
>>
>>
> I was under the (apparently flawed) impression that Adeos was used to
> prevent interrupts preempting a running high priority task in primary mode,
> only forwarding the interrupts to Linux once the task was waiting /
> finished. I guess that it only prevents a subset of all interrupts, and the
> rest must be specifically disabled then re-enabled by the program, or maybe
> it does not intercept any interrupts?
>
>
>>
>>  The latencies I am actually seeing are as
>> > high as 13,000ns, and these occur during this busy loop (I have timed
>> it),
>> > implying that this loop is being preempted.
>> >
>> > while(1)
>> > {
>> >    pthread_wait_np(&Overrun);
>> >
>> >    WakeTime = GetTime();
>> >    while(WakeTime < ExpectedTime)
>> >    { WakeTime = GetTime(); } // Preempted here
>> >
>> >    DoWork();
>> >
>> >    ExpectedTime += Period;
>> > }
>> >
>> > This is a Xenomai POSIX thread with a priority of 99, and is the only
>> thread
>> > within my program with a priority of 99 or higher. There are no context
>> > switches occuring within this thread (confirmed using
>> pthread_set_mode_np(0,
>> > PTHREAD_WARNSW)).
>> >
>> > I have had a brief experimentation with kernel settings, for example
>> > applying the SMI workaround, but this produces no difference to the
>> > preemption that I measure.
>>
>> The question is: is the SMI workaround working for your chipset? If that
>> is the case, you should get messages in the kernel logs.
>>
>>
> I've had a look at dmesg, but cannot find any references to SMI - what
> should I be looking for?
>
>
>> --
>>                                             Gilles.
>>
>
> Steve
>
Steve

--001636417da3b92ec5048be56fac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 21 July 2010 13:05, Stephen Bryant <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sbxenomai@domain.hid">sbxenomai@domain.hid=
il.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<div class=3D"gmail_quote"><div class=3D"im">On 21 July 2010 12:06, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Stephen Bryant wrote:<br>
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
<div><br></div></blockquote></div><div><br>Yes, it is x86, sorry for the om=
ission. What sort of latencies would you expect me to see?<br></div></div><=
/blockquote><div>=A0</div><div>Sorry, I should have given more info. It is =
an Intel Core 2 Duo, running a kernel with SMP disabled.<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div cl=
ass=3D"gmail_quote"><div><br></div><div class=3D"im"><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>
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
<div><br></div></blockquote></div><div><br>I was under the (apparently flaw=
ed) impression that Adeos was used to prevent interrupts preempting a runni=
ng high priority task in primary mode, only forwarding the interrupts to Li=
nux once the task was waiting / finished. I guess that it only prevents a s=
ubset of all interrupts, and the rest must be specifically disabled then re=
-enabled by the program, or maybe it does not intercept any interrupts?<br>

=A0</div><div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;"><div>
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
<br></blockquote></div><div><br>I&#39;ve had a look at dmesg, but cannot fi=
nd any references to SMI - what should I be looking for?<br>=A0</div><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>Steve<br>
</blockquote></div>Steve<br>

--001636417da3b92ec5048be56fac--

