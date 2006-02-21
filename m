Message-ID: <43FB5DB1.2000703@domain.hid>
Date: Tue, 21 Feb 2006 19:36:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
References: <C02098C9.24B1%steve@domain.hid>
In-Reply-To: <C02098C9.24B1%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig704B34BE4186BBC3A448F3DA"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig704B34BE4186BBC3A448F3DA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> Here are the routines in question:
>=20
> low priority:
>=20
> for(;;) {
>     /* regular rf watchdogs */
>     outb(0x45, 0x????);
>     outb(0x6a, 0x????);
>     outb(0x7e, 0x????);
>               =20
>     outb(0, 0x????); //patient watchdog
>     outb(0, 0x????); //fault led
>=20
>     flip_reg_bits(WRFPC, 0x????); //flash yellow led
>                =20
>     ????_flip_spi_bits(HV_STATUS_CONTROL, HV_WDOG_STROBE_MONITOR);
>                =20
>     rt_task_wait_period();
> }
>=20
> high priority:
>=20
>     for(;;) {
>         if(motor_move) {
>             syslog(LOG_INFO, "about to lock up");
>             for(int i=3D0; i<100000000; i++);

This loop is always executed in secondary mode. This means it /may/ run
at the original high prio of that thread if syslog() did not trigger a
Linux reschedule, and it will run at prio 0 if syslog did so. This
depends on the arrival of Linux IRQs or the need of syslog to block on
some other Linux process.

Again, if you want RT for sure after a Linux call, use explicit mode
switching.

>             motor_move=3D0;
>         }
>=20
>         rt_task_wait_period();
>     }
>=20
> All function calls contain only inb or outb, no system calls. If I comm=
ent
> out the syslog call in the high priority thread, the yellow LED stops
> flashing completely. Otherwise, it flashes every second, with the
> periodicity of the higher priority thread.
>=20
> I have another problem, too:
>=20
> Using the same yellow LED flashing thread, if I start up a LOWER priori=
ty
> task like this, I can see jitter on my LED strobe line on the scope onc=
e a

Also as rt-thread?

> second. Why would the lower priority thread making a system call affect=
 the
> higher priority one?
>=20
> for(;;) {
>     syslog(LOG_INFO, "sleeping 1");
>     sleep(1);
> }

Something seems to be broken, but it is hard to analyse remotely if in
the test setup or the system.

Please replace your LED thread in this scenario with the latency test
tool, running at the same frequency. Collect the worst-case data. If
they show quirks as well, consider applying the tracer patch and catch
the abnormal jitters via "latency -f". You can tune the number if
backtrace_points in /proc/ipipe/tracer until you get a significant time
interval into the trace.

Jan


--------------enig704B34BE4186BBC3A448F3DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+12xniDOoMHTA+kRAiFkAJsGDrhwnRQI8gfO6RADOf4OW/wfxACdECb2
UFsEb91rNDECZ0/DU7jB+7s=
=ql4a
-----END PGP SIGNATURE-----

--------------enig704B34BE4186BBC3A448F3DA--

