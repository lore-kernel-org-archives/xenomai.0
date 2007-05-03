From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
References: <4639D724.5010702@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 03 May 2007 16:54:48 +0200
Message-Id: <1178204088.29605.85.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
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
Cc: Xenomai-help@domain.hid

On Thu, 2007-05-03 at 13:42 +0000, Daniel Schnell wrote:

> Philip:
> Also for our MPC5200B based board we get bogus latency measurements.
>  How can we find out the right value of /proc/xenomai/latency ?

$ echo 0 > /proc/xenomai/latency
(run the native calibration test)

If the minimum latency value is positive, then:
$ echo abs(min-latency-value) > /proc/xenomai/latency

Fine tuning could be made from that point afterwise.

Sidenote: It obviously makes no sense to stuff gigantic values
into /proc/xenomai/latency; large core latencies are likely the sign of
1) a bug in the arch-dep section (probably Adeos), 2) inadequation of
the hw for real-time usage (e.g. some ARM platforms with MMU, mmm...
issues).

>  Wouldn't an auto calibration be more useful when starting up (similar to=
 the Linux Bogo Mips value),

I tried and failed to have an accurate auto-calibration (circa fusion
0.6.x IIRC); the cost of random cache effects taking place during
auto-calibration was too high compared to the calibrated value itself.
Additionally, the calibration process monitored a kernel space thread,
which was not that relevant latency-wise to user-space apps (i.e. cost
of mm switching).

>  because actually one can configure the boards to have different bus spee=
d settings,
> so the CPU detection alone will not be sufficient ?
>=20

Indeed, measuring raw CPU speed is not enough (e.g. boards with sluggish
memory sub-systems). What Xenomai does is currently a best effort
(sometimes trivial, like ad hoc values obtained from experiments), with
heuristics which may be different depending on the underlying sw/hw
combo (see the x86 calibration.h). This is why the builtin
pre-calibrated value may be overriden by a kernel configuration knob.

Said differently, I had no clue, so I'm expecting users to have some.

> Best regards,
>=20
> Daniel Schnell.
>=20
>=20
>=20
>=20
>=20
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain=
.hid] On Behalf Of Johan Borkhuis
> Sent: 3. ma=ED 2007 12:36
> To: Xenomai-help@domain.hid
> Subject: [Xenomai-help] Latency calculation and test
>=20
> I am quite new to Xenomai, but not to realtime and embedded development. =

> I am trying to run Xenomai on a MVME3100 board (PPC8540 processor, kernel=
 version 2.6.14, Xenomai 2.3.1).
>=20
> I am trying to do latency measurements on my target, and I have some ques=
tions.
>=20
> As far as I understand it, the value in /proc/xenomai/latency is the time=
 needed to start a timer, and this value is subtracted from the value provi=
ded to the timer. The value calculated by Xenomai on my platform is 9489. A=
ll latencies reported with the latency tool are negative when this value is=
 used.
> When I write 0 to this setting (to get the real values without offset) an=
d run the latency test program I see different values for the different mod=
es: user space =3D 3.6 usec, kernel space =3D 1.8 usec and IRQ =3D 0.9 usec=
. What is the relation between the value calculated by Xenomai and the valu=
es measured by the latency program, and what is the correct way to calculat=
e the latency setting?
>=20
> I also did a port of the cyclictest program to Xenomai. Instead of the pt=
hreads I used the RT-tasks, like the latency program.  The cyclictest progr=
am uses signals to  trigger the task, but as I found out this does not work=
 in userspace: the applications returns to secondary mode at the moment the=
 thread waits for a signal. Is there another way to do this (next to moving=
 the whole program to kernel space)?
>=20
> One option of the cyclictest program is that you can have several threads=
 running. I modified the output of the cyclictest tool somewhat, to have mi=
n, max and average like the latency program.
> When running multiple threads within this program (without load) the valu=
es range from -5 usec to +5 usec, with an average of around 0 usec.=20
> But with more RT tasks I see a very high latency once in a while (over 40=
0 usec).
>=20
> Below is the example of such a test run with 10 threads/tasks:
>  T: 0 ( 1305) P:80 I:1000 O: 0 Min:   -2.404 Avg: -0.001 Max:   1.873
>  T: 1 ( 1306) P:79 I:1000 O: 0 Min:   -3.052 Avg: -0.001 Max:   1.584
>  T: 2 ( 1307) P:78 I:1000 O: 0 Min:   -5.694 Avg:  0.000 Max:  18.282
>  T: 3 ( 1308) P:77 I:1000 O: 0 Min:   -5.166 Avg:  0.046 Max: 479.782
>  T: 4 ( 1309) P:76 I:1000 O: 0 Min:   -2.595 Avg:  0.036 Max: 368.310
>  T: 5 ( 1310) P:75 I:1000 O: 0 Min:   -1.731 Avg: -0.001 Max:   1.633
>  T: 6 ( 1311) P:74 I:1000 O: 0 Min: -481.273 Avg: -0.001 Max: 490.352
>  T: 7 ( 1312) P:73 I:1000 O: 0 Min: -273.947 Avg: -0.001 Max: 277.717
>  T: 8 ( 1313) P:72 I:1000 O: 0 Min:  -47.016 Avg: -0.001 Max:  45.789
>  T: 9 ( 1314) P:71 I:1000 O: 0 Min:  -22.968 Avg: -0.001 Max:  29.572 (P=
=3DPriority, I=3Dinterval, O=3Doverruns)
>=20
> When looking at the detailed information, I see that the latencies occur =
when a higher priority task is ending. Is there some specific reason for th=
is, or is there some kind of configuration problem with my setup?
>=20
> Kind regards,
>     Johan Borkhuis
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



