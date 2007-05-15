From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 15 May 2007 17:18:29 +0200
Message-Id: <1179242309.11297.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-05-15 at 14:40 +0000, Daniel Schnell wrote:
> This was not the culprit. Same results.
>=20
> Does Xenomai replace the memcpy() call with an own implementation ? (I do=
n't think so.)

No.

>=20
> What about trashing of cash lines through context switches ?=20

Interrupts also participate in cache trashing.

> But then if we run it on Linux alone we should also have trashed cache li=
nes. There should not be any difference.

It depends. You are running 2.4.25/ppc kernel IIRC, which means that
your system endures much fewer preemptions on a vanilla kernel (100 hz
timer, no kernel preemption). Depending on the Xenomai timer freq, and
the number of RT thread switches in your app, your cache may be under
permanent pressure.

> Is maybe the presence of a Xenomai POSIX thread cause a lot of ctx switch=
es,
> even if only a memcpy is executed inside the thread ? Shouldn't Xenomai t=
hreads
>  run totally uninterrupted if they have the highest prio ?

I don't get what you mean actually. If your thread needs no switching,
then Xenomai does no switches, period. However, if your RT thread is
continuously moving from primary to secondary mode and back for
instance, then switches would occur at a high rate;
see /proc/xenomai/stats to check this.

2.4/ppc kernels could possibly cause secondary mode switches to Xenomai
threads, due to on-demand mapping and COW management issues when copying
data, especially to/from large buffers. So, memcpy in primary mode ->
page_fault -> mode_transition -> internal context_switch -> back to
memcpy in secondary mode for the same thread.

High prio threads can also be preempted by interrupts.

>=20
> Please could somebody actually run this test on his hardware and see if t=
hese differences between Xenomai POSIX skin and Linux native are happening =
there as well ?
>=20

FWIW, you have all the needed tools to check this yourself.

First, sampling /proc/xenomai/stats would tell you the average number of
ctx switches, and the number of mode transitions, on a per-thread
basis.=20
Then, you could move to a 2.6.x kernel for the purpose of testing and
without having to change anything else runtime-wise, this would enable
the latency tracer facility (Kernel hacking -> I-pipe debugging). A
simple log showing how/by whom a given user-space memcpy has been
preempted would definitely shed some light on this issue.

>=20
> Best regards,
>=20
> Daniel Schnell
>=20
>=20
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
> Sent: 15. ma=ED 2007 12:16
> To: Daniel Schnell
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] memcpy performance on Xenomai
>=20
>=20
> Improving clock_gettime overhead by reading directly the tsc is my very n=
ext task. If you want to check if the effect you measure is the result of c=
lock_gettime overhead, you can measure the duration of memcpy with the nati=
ve api service rt_timer_tsc, and convert the tsc difference with rt_timer_t=
sc2ns.
>=20
--=20
Philippe.



