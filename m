MIME-Version: 1.0
Date: Mon, 6 Feb 2012 19:01:57 -0500
Message-ID: <CAMak2D-YfDCvjbZiLFYGntYdDCJVPiYtwt5z8k=PPT-9yj3S5A@mail.gmail.com>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: multipart/alternative; boundary=f46d04447efdc83ce504b8547c8d
Subject: [Xenomai-help] in-kernel periodic task latencies caused by dohell
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--f46d04447efdc83ce504b8547c8d
Content-Type: text/plain; charset=ISO-8859-1

Hello, I've been doing some more Xenomai benchmarking lately and have come
across what seems to be strange behavior.  I'm running Xenomai 2.6.0 on a
Beagleboard XM with kernel 2.6.37.  Just running the in-kernel periodic
task benchmark (./latency -t1) alone results in an average of 2.7uS
latency.  What is interesting is the effect of various parts of dohell:

1) If I just run unmodified dohell with only the seconds argument, the
latency goes to about 17uS.

2) If I comment out all tests in dohell except for "dd if=/dev/zero
of=/dev/null &", average latency goes to 3.3uS (with top indicating about
98% CPU usage by dd).

3) If I comment out all tests in dohell except for "while :; do cat
/proc/interrupts; done > /dev/null 2>&1 &", average latency goes to about
24uS.

So it seems that trapping into the Linux kernel can have a drastic effect
on Xenomai real-time kernel latencies.  Why is this?  Shouldn't a
timer-driven runnable real-time Xenomai kernel task require the same
preemption latency regardless of whether Linux is busy or not?  And it's
not just that Linux processes are loading the CPU (this happens in case 2
with relatively little effect on latency), but that it's the act of
trapping into the kernel that causes the latency.  Any ideas why this is
the case?

Thank you very much.

- Eric

--f46d04447efdc83ce504b8547c8d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello, I&#39;ve been doing some more Xenomai benchmarking lately and have c=
ome across what seems to be strange behavior.=A0 I&#39;m running Xenomai 2.=
6.0 on a Beagleboard XM with kernel 2.6.37.=A0 Just running the in-kernel p=
eriodic task benchmark (./latency -t1) alone results in an average of 2.7uS=
 latency.=A0 What is interesting is the effect of various parts of dohell:<=
br>
<br>1) If I just run unmodified dohell with only the seconds argument, the =
latency goes to about 17uS.<br><br>2) If I comment out all tests in dohell =
except for &quot;dd if=3D/dev/zero of=3D/dev/null &amp;&quot;, average late=
ncy goes to 3.3uS (with top indicating about 98% CPU usage by dd).<br>
<br>3) If I comment out all tests in dohell except for &quot;while :; do ca=
t /proc/interrupts; done &gt; /dev/null 2&gt;&amp;1 &amp;&quot;, average la=
tency goes to about 24uS.<br><br>So it seems that trapping into the Linux k=
ernel can have a drastic effect on Xenomai real-time kernel latencies.=A0 W=
hy is this?=A0 Shouldn&#39;t a timer-driven runnable real-time Xenomai kern=
el task require the same preemption latency regardless of whether Linux is =
busy or not?=A0 And it&#39;s not just that Linux processes are loading the =
CPU (this happens in case 2 with relatively little effect on latency), but =
that it&#39;s the act of trapping into the kernel that causes the latency.=
=A0 Any ideas why this is the case?<br>
<br>Thank you very much.<br><br>- Eric<br><br>

--f46d04447efdc83ce504b8547c8d--

