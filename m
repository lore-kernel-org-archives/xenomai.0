Message-ID: <464175A7.6060504@domain.hid>
Date: Wed, 09 May 2007 09:17:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid> <463EEA4A.1070405@domain.hid>
	<463F1468.8010403@domain.hid> <463F178D.4020805@domain.hid>
	<463F1D99.5090208@domain.hid> <463F2F14.1000205@domain.hid>
	<46401F76.7080904@domain.hid>
In-Reply-To: <46401F76.7080904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62CF469BA2E7B952875A3F63"
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62CF469BA2E7B952875A3F63
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Jan,
>=20
> Jan Kiszka wrote:
>> Johan Borkhuis wrote:
>> -snip-
>> =20
>>> :|  + begin   0x80000001 -1908    0.414  __ipipe_dispatch_event+0x1e4=

>>> (__ipipe_syscall_root+0x64)
>>> :|  + end     0x80000001 -1908!  52.121  __ipipe_dispatch_event+0x204=

>>> (__ipipe_syscall_root+0x64)
>>> :   + func               -1857+   1.170  do_page_fault+0x14
>>> (handle_page_fault+0xc)
>>>    =20
>> This one is interesting: page fault over the RT-thread that belongs to=

>> PID 1160 (prio 79).
>> =20
>>> :|  # func               -1845+   1.585  rpi_push+0x14 [xeno_nucleus]=

>>> (xnshadow_relax+0x84 [xeno_nucleus])
>>> :|  # func               -1844    0.463  xnpod_schedule_runnable+0x14=

>>> [xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])
>>> :|  # [    0] swapper 79 -1843+   1.658  xnpod_schedule_runnable+0x54=

>>> [xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])
>>>    =20
>> And now we are running the Linux kernel at xeno-prio 79 (due to
>> prio-coupling).
>>  =20
> Thank you for pointing these out. This made me change 2 things in the
> configuration:
> - Disabling swap. This should not make any difference as I don't have
> any swapspace, but the page_fault triggered me to have a look at that
> setting.
> - Enabling "Disable priority coupling". I missed the Disable part here,=

> so it was still enabled during this run.

Don't get me wrong: I was not saying the prio-coupling it the root of
the problem here, it's just an amplifier. The (or at least one) root is
that your RT task still causes page faults. That needs to be fixed!

>=20
> When running with priority coupling disabled the latency is down to les=
s
> than 100 usec. But this is always the case when a higher priority
> rt_task is stopped, even with only one higher priority thread. Would
> this be a normal latency if a higher prio rt_task is deleted? Below are=

> the results of a test run, where the max latency is 67 usec (the 40 use=
c
> of the first line is caused by the trace-setup):
>=20
> bash-3.00# ./latency -f -P 60
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
> RTH|--lat min|--lat avg|--lat max|-overrun|--lat best|--lat worst
> RTD|   -2.642|    0.432|   40.768|       0|    -2.642|     40.768
> RTD|   -2.594|    0.408|    8.744|       0|    -2.642|     40.768
> RTD|   -2.642|    0.432|    6.198|       0|    -2.642|     40.768
> RTD|   -2.306|    0.552|   33.129|       0|    -2.642|     40.768
> RTD|   -2.330|    0.480|   67.483|       0|    -2.642|     67.483
> RTD|   -2.474|    0.408|    6.150|       0|    -2.642|     67.483
> RTD|   -2.666|    0.408|   10.330|       0|    -2.666|     67.483
> RTD|   -2.546|    0.432|    6.222|       0|    -2.666|     67.483
> ---|---------|---------|---------|--------|----------------------
> RTS|   -2.666|    0.432|   67.483|       0|    00:00:08/00:00:08
> bash-3.00#
>=20
> bash-3.00# ./cyclictest-Xenomai -q -h -t 1
> #T: 0 P:80 I:10000 O:   0 C: 100 Min: -5.560 Avg:  0.052 Max:  5.732
>=20
>=20
> I also attached another logfile, this one belongs to the session above.=

>=20
> If deleting a rt_task has such a large impact on lower priority tasks,
> would it be possible to lower to priority of the to be deleted task to
> 0, just to avoid this impact?

IIRC, cyclictest does precisely this before thread termination, ie.
drops RT properties. This is indeed recommended if you have
prio/coupling on and perform cleanup while other critical tasks continue
to work.

> (I know, in a RT system you should setup your system before the system
> is operational, and do not create or remove tasks dynamically, but
> sometimes this is needed).
>=20
> Kind regards,
>    Johan Borkhuis
>=20

Jan


--------------enig62CF469BA2E7B952875A3F63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQXWnniDOoMHTA+kRAnN4AJ9+k+BhWMtPlrIo84tybewVruztFwCeKkkt
+bsQkH8DX1gGIsOuXrz/zX4=
=eVvJ
-----END PGP SIGNATURE-----

--------------enig62CF469BA2E7B952875A3F63--

