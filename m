Message-ID: <463B2A69.7080704@domain.hid>
Date: Fri, 04 May 2007 14:43:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid> <1178281926.29093.93.camel@domain.hid>
In-Reply-To: <1178281926.29093.93.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40789A85C14A659E4A6FF244"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40789A85C14A659E4A6FF244
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-05-04 at 09:58 +0200, Johan Borkhuis wrote:
>> Philippe Gerum wrote:
>>>> When I write 0 to this setting (to get the real values without offse=
t)=20
>>>> and run the latency test program I see different values for the=20
>>>> different modes: user space =3D 3.6 usec, kernel space =3D 1.8 usec =
and IRQ=20
>>>> =3D 0.9 usec. What is the relation between the value calculated by X=
enomai=20
>>>> and the values measured by the latency program, and what is the corr=
ect=20
>>>> way to calculate the latency setting?
>>> None, actually. Xenomai does not calibrate the latency dynamically, b=
ut
>>> rather use a pre-defined value listed in asm-powerpc/calibration.h.
>>> ~9500 ns is the value picked for any ppc32 board right now.
>>>
>>> Please send back the proper calibration value for your board, we will=

>>> use it as the pre-calibrated data when MPC8540 is defined.
>> The values are determined using the latency tool with no system load:
>> User space:   3270   (latency: min=3D 0.000, avr=3D0.264, max=3D8.336)=

>> Kernel space: 1800   (latency: min=3D-0.180, avr=3D0.074, max=3D5.742)=

>> IRQ space:     800   (latency: min=3D-0.108, avr=3D0.153, max=3D0.792)=

>>
>> These are quite close to the values seen when running with a value of =
0=20
>> and looking at the output of the latency tool, as shown earlier.
>>
>> Some board information:
>> Processor: MPC8540
>> Board name: MVME3100
>> Freq: 833 MHz (bus =3D 333 MHz)
>> Bogomips: 829.44
>>
>>>> I also did a port of the cyclictest program to Xenomai. Instead of t=
he=20
>>>> pthreads I used the RT-tasks, like the latency program.  The cyclict=
est=20
>>>> program uses signals to  trigger the task, but as I found out this d=
oes=20
>>>> not work in userspace: the applications returns to secondary mode at=
 the=20
>>>> moment the thread waits for a signal. Is there another way to do thi=
s=20
>>>> (next to moving the whole program to kernel space)?
>>> Hard RT signals are not yet supported by Xenomai. It's on the 2.4
>>> roadmap though. So you are right, POSIX signals are presently only
>>> available from the regular glibc/kernel support, therefore Xenomai
>>> threads automatically move to secondary mode to process them. Precise=

>>> timing can be achieved with the POSIX skin using the non-portable
>>> pthread_set_periodic_np/pthread_wait_np interface.
>> I might have a look at these, but for now I do have a working realtime=
=20
>> latency test. I guess I will wait for the 2.4 version. Is there some=20
>> kind of timeline available for features and releases?
>=20
> The feature list for 2.4 is there:
> http://www.xenomai.org/index.php/TaskMarket
>=20
> 2.4 deadline is August 1st, and the merge window for new core features
> will be closed by June 15. I cannot tell you when the RT signals will b=
e
> available, it all depends on a scarce resource called "time".
>=20
>>>> One option of the cyclictest program is that you can have several=20
>>>> threads running. I modified the output of the cyclictest tool somewh=
at,=20
>>>> to have min, max and average like the latency program.
>>>> When running multiple threads within this program (without load) the=
=20
>>>> values range from -5 usec to +5 usec, with an average of around 0 us=
ec.=20
>>>> But with more RT tasks I see a very high latency once in a while (ov=
er=20
>>>> 400 usec).
>>>>
>>>> Below is the example of such a test run with 10 threads/tasks:
>>>>  T: 0 ( 1305) P:80 I:1000 O: 0 Min:   -2.404 Avg: -0.001 Max:   1.87=
3
>>>>  T: 1 ( 1306) P:79 I:1000 O: 0 Min:   -3.052 Avg: -0.001 Max:   1.58=
4
>>>>  T: 2 ( 1307) P:78 I:1000 O: 0 Min:   -5.694 Avg:  0.000 Max:  18.28=
2
>>>>  T: 3 ( 1308) P:77 I:1000 O: 0 Min:   -5.166 Avg:  0.046 Max: 479.78=
2
>>>>  T: 4 ( 1309) P:76 I:1000 O: 0 Min:   -2.595 Avg:  0.036 Max: 368.31=
0
>>>>  T: 5 ( 1310) P:75 I:1000 O: 0 Min:   -1.731 Avg: -0.001 Max:   1.63=
3
>>>>  T: 6 ( 1311) P:74 I:1000 O: 0 Min: -481.273 Avg: -0.001 Max: 490.35=
2
>>>>  T: 7 ( 1312) P:73 I:1000 O: 0 Min: -273.947 Avg: -0.001 Max: 277.71=
7
>>>>  T: 8 ( 1313) P:72 I:1000 O: 0 Min:  -47.016 Avg: -0.001 Max:  45.78=
9
>>>>  T: 9 ( 1314) P:71 I:1000 O: 0 Min:  -22.968 Avg: -0.001 Max:  29.57=
2
>>>> (P=3DPriority, I=3Dinterval, O=3Doverruns)
>>>>
>>>> When looking at the detailed information, I see that the latencies o=
ccur=20
>>>> when a higher priority task is ending. Is there some specific reason=
 for=20
>>>> this, or is there some kind of configuration problem with my setup?
>>> Confirmed here, latencies are way too high in this scenario. Could yo=
u
>>> try running a native latency test (testsuite/latency) in parallel of =
a
>>> running cyclic test? I'm interested by the maximum jitter you get the=
re.
>> When running latency at a higher priority than the cyclictest program =

>> the max increases from around 4 to 8 usec when the cyclictest stops. B=
ut=20
>> when running the latency program at a lower priority (60, while=20
>> cylictest is running at 80 - 71) the maximum increases dramatically:
>>
>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t=20
>> worst
>> RTD|      -0.096|       0.168|       3.843|       0|      -0.096|     =
 =20
>> 6.510
>> RTD|      -0.072|       0.216|      23.135|       0|      -0.096|     =
=20
>> 23.135
>> RTD|       0.048|       0.480|      14.270|       0|      -0.096|     =
=20
>> 23.135
>> RTD|       0.048|       0.480|      14.030|       0|      -0.096|     =
=20
>> 23.135
>> RTD|      -0.096|       0.552|     613.741|       7|      -0.096|     =

>> 613.741
>> RTD|      -0.096|       0.168|       7.975|       7|      -0.096|     =

>> 613.741
>> RTD|      -0.072|       0.168|       3.843|       7|      -0.096|     =

>> 613.741
>>
>> If you want I can send you my version of the cyclictest program.
>>
>=20
> Yes, please. We definitely need to fix this issue, or at least explain
> it asap.

Let me bet before the race is over: your cyclictest switches to
secondary (Linux) mode with its high prio threads (e.g. on termination),
priority coupling is active (that's default), and Linux runs on behalf
of cyclictest for several hundred us which causes the delay for low prio
latency. The I-pipe tracer would tell you more BTW, see Xenomai wiki.

Jan


--------------enig40789A85C14A659E4A6FF244
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGOyppniDOoMHTA+kRAqpgAJ9UGOsTbZSO4FaUoGt4jFAx9Lmi0ACYzAJw
HAKGvn/8aQ/2BuOYvFyBdw==
=tdQK
-----END PGP SIGNATURE-----

--------------enig40789A85C14A659E4A6FF244--

