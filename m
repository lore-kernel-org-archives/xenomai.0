Message-ID: <4732C546.90602@domain.hid>
Date: Thu, 08 Nov 2007 09:13:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C98D28A7D04CD72CFCF2F39"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Testing LTTng: first insights
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C98D28A7D04CD72CFCF2F39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

testing my ltt patches over 2.6.23-i386 with latest Xenomai SVN, I found
the first noteworthy effect. First the relevant trace snippet:

=2E..
kernel_irq_exit: 430.606359465 (/usr/src/lttng-xenomai/trace4/cpu_0), 0, =
0, swapper, , 0, 0x0, SYSCALL
xn_nucleus_irq_enter: 430.608893573 (/usr/src/lttng-xenomai/trace4/cpu_0)=
, 0, 0, swapper, , 0, 0x0, SYSCALL { irq =3D 233 }
xn_nucleus_tbase_tick: 430.608894311 (/usr/src/lttng-xenomai/trace4/cpu_0=
), 0, 0, swapper, , 0, 0x0, SYSCALL { base =3D "master" }
xn_nucleus_irq_exit: 430.608895290 (/usr/src/lttng-xenomai/trace4/cpu_0),=
 0, 0, swapper, , 0, 0x0, SYSCALL { irq =3D 233 }
xn_nucleus_irq_enter: 430.608896506 (/usr/src/lttng-xenomai/trace4/cpu_0)=
, 0, 0, swapper, , 0, 0x0, SYSCALL { irq =3D 233 }
xn_nucleus_tbase_tick: 430.608897147 (/usr/src/lttng-xenomai/trace4/cpu_0=
), 0, 0, swapper, , 0, 0x0, SYSCALL { base =3D "master" }
xn_nucleus_timer_expire: 430.608897986 (/usr/src/lttng-xenomai/trace4/cpu=
_0), 0, 0, swapper, , 0, 0x0, SYSCALL { timer =3D 0xf10e505c }
xn_nucleus_irq_exit: 430.608898959 (/usr/src/lttng-xenomai/trace4/cpu_0),=
 0, 0, swapper, , 0, 0x0, SYSCALL { irq =3D 233 }
kernel_timer_update_time: 430.608901508 (/usr/src/lttng-xenomai/trace4/cp=
u_0), 0, 0, swapper, , 0, 0x0, SYSCALL { jiffies =3D
4294998430, xtime_sec =3D 1194421869, xtime_nsec =3D 280190150, walltomon=
otonic_sec =3D -1194421446, walltomonotonic_nsec =3D 923956260 }
xn_nucleus_timer_start: 430.608904869 (/usr/src/lttng-xenomai/trace4/cpu_=
0), 0, 0, swapper, , 0, 0x0, SYSCALL { timer =3D 0xf10e505c, base =3D "ma=
ster", value =3D 3989600, interval =3D 0, mode =3D 0 }
kernel_softirq_entry: 430.608906715 (/usr/src/lttng-xenomai/trace4/cpu_0)=
, 0, 0, swapper, , 0, 0x0, SOFTIRQ { softirq_id =3D 1 }
kernel_timer_timeout: 430.608908237 (/usr/src/lttng-xenomai/trace4/cpu_0)=
, 0, 0, swapper, , 0, 0x0, SOFTIRQ { pid =3D 7381 }
kernel_sched_try_wakeup: 430.608909293 (/usr/src/lttng-xenomai/trace4/cpu=
_0), 0, 0, swapper, , 0, 0x0, SOFTIRQ { pid =3D 7381, state =3D 1 }
kernel_timer_timeout: 430.608911261 (/usr/src/lttng-xenomai/trace4/cpu_0)=
, 0, 0, swapper, , 0, 0x0, SOFTIRQ { pid =3D 7711 }
kernel_sched_try_wakeup: 430.608912078 (/usr/src/lttng-xenomai/trace4/cpu=
_0), 0, 0, swapper, , 0, 0x0, SOFTIRQ { pid =3D 7711, state =3D 1 }
kernel_timer_set: 430.608914373 (/usr/src/lttng-xenomai/trace4/cpu_0), 0,=
 0, swapper, , 0, 0x0, SOFTIRQ { expires =3D 31135, function =3D 0xc01fb8=
8e, data =3D 0 }
kernel_softirq_exit: 430.608915649 (/usr/src/lttng-xenomai/trace4/cpu_0),=
 0, 0, swapper, , 0, 0x0, SYSCALL { softirq_id =3D 1
}
=2E..

Xenomai is loaded at this time but not yet used. Linux runs in tickless
highres mode and obviously had programmed the host timer to fire here.
But instead of one timer IRQ (233) + its handling, we see an additional
early shot (about 3 =B5s too early here - the longer the timer is
programmed in advance, the larger the error gets) before the xntimer
finally expires. But at the same time, /proc/xenomai/latency reports
1000 (1 =B5s). So there must be more discrepancy between TSC and APIC
timebases, no? Well, nothing critical, but at least suboptimal, maybe
pointing at some hidden minor bug. Once time permits, I will check the
APIC frequency and the delay calculation on my box and compare it to
what Linux uses.

Jan




--------------enig9C98D28A7D04CD72CFCF2F39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHMsVGniDOoMHTA+kRAgXvAJ4qJnPq2G5t6rgbg87sRhn8a9IZZQCggGlu
f4kruCj9t1/Z8FmnPcoxBOM=
=63SS
-----END PGP SIGNATURE-----

--------------enig9C98D28A7D04CD72CFCF2F39--

