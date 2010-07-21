MIME-Version: 1.0
Date: Wed, 21 Jul 2010 11:54:03 +0100
Message-ID: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=00163692009dc1c25e048be39e7b
Subject: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00163692009dc1c25e048be39e7b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have some code (simplified example below) which uses
'pthread_wait_np(&Overrun)' within a while loop, using a period of
1,000,000ns (1ms) which has been set using 'pthread_make_periodic_np()'.
This wakes the thread up less than 2,000ns late in general, sometimes
20,000ns late, and at most less than 45,000ns late. To ensure that I perform
the tasks within the thread from a consistent 'millisecond tick' I set an
expected time value 45,000ns later than the earliest wake time each period,
and then use a busy loop until the current time equals this expected time.
This busy loop takes < 600ns per cycle, and so the latency from my expected
time should be a maximum of 600ns. The latencies I am actually seeing are as
high as 13,000ns, and these occur during this busy loop (I have timed it),
implying that this loop is being preempted.

while(1)
{
   pthread_wait_np(&Overrun);

   WakeTime = GetTime();
   while(WakeTime < ExpectedTime)
   { WakeTime = GetTime(); } // Preempted here

   DoWork();

   ExpectedTime += Period;
}

This is a Xenomai POSIX thread with a priority of 99, and is the only thread
within my program with a priority of 99 or higher. There are no context
switches occuring within this thread (confirmed using pthread_set_mode_np(0,
PTHREAD_WARNSW)).

I have had a brief experimentation with kernel settings, for example
applying the SMI workaround, but this produces no difference to the
preemption that I measure. I have also re-read all the documentation I could
find about Xenomai and preemption and I cannot see any way of fixing this
without trial and error with the kernel settings.

Do you have any other ideas for avenues that I could explore, or could you
recommend documentation about parts of the kernel that are more likely to
have an effect on preemption to speed up this process?

I am running Ubuntu on:
Kernel: 2.6.32.8
Xenomai: 2.5.3

Steve

--00163692009dc1c25e048be39e7b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have some code (simplified example below) which uses &#39;pthr=
ead_wait_np(&amp;Overrun)&#39; within a while loop, using a period of 1,000=
,000ns (1ms) which has been set using &#39;pthread_make_periodic_np()&#39;.=
 This wakes the thread up less than 2,000ns late in general, sometimes 20,0=
00ns late, and at most less than 45,000ns late. To ensure that I perform th=
e tasks within the thread from a consistent &#39;millisecond tick&#39; I se=
t an expected time value 45,000ns later than the earliest wake time each pe=
riod, and then use a busy loop until the current time equals this expected =
time. This busy loop takes &lt; 600ns per cycle, and so the latency from my=
 expected time should be a maximum of 600ns. The latencies I am actually se=
eing are as high as 13,000ns, and these occur during this busy loop (I have=
 timed it), implying that this loop is being preempted.<br>
<br>while(1)<br>{<br>=A0=A0 pthread_wait_np(&amp;Overrun);<br><br>=A0=A0 Wa=
keTime =3D GetTime();<br>=A0=A0 while(WakeTime &lt; ExpectedTime)<br>=A0=A0=
 { WakeTime =3D GetTime(); } // Preempted here<br><br>=A0=A0 DoWork();<br><=
br>=A0=A0 ExpectedTime +=3D Period;<br>
}<br><br>This is a Xenomai POSIX thread with a priority of 99, and is the o=
nly thread within my program with a priority of 99 or higher. There are no =
context switches occuring within this thread (confirmed using pthread_set_m=
ode_np(0, PTHREAD_WARNSW)).<br>
<br>I have had a brief experimentation with kernel settings, for example ap=
plying the SMI workaround, but this produces no difference to the preemptio=
n that I measure. I have also re-read all the documentation I could find ab=
out Xenomai and preemption and I cannot see any way of fixing this without =
trial and error with the kernel settings.<br>
<br>Do you have any other ideas for avenues that I could explore, or could =
you recommend documentation about parts of the kernel that are more likely =
to have an effect on preemption to speed up this process?<br><br>I am runni=
ng Ubuntu on:<br>
Kernel: 2.6.32.8<br>Xenomai: 2.5.3<br><br>Steve<br>

--00163692009dc1c25e048be39e7b--

