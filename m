Message-ID: <45E478BB.40301@domain.hid>
Date: Tue, 27 Feb 2007 19:30:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] task not being scheduled
References: <200702271214.01911.jweber@domain.hid>
In-Reply-To: <200702271214.01911.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AE23E3132D1807D578342ED"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AE23E3132D1807D578342ED
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> I have system where a 100Hz periodic task is occasionally over running =
it's
> periodic task wakeup by 10s of msec.  To debug the problem, I froze an =
ipipe
> verbose trace upon an -ETIMEDOUT error return from rt_task_wait_period(=
).
> A filtered output of the trace appears below.  This trace includes ever=
y
> occurence of the task, which is pid 7380.

Please post the unfiltered (but compressed) trace. It's not yet obvious
from the excerpt below what happens.

>=20
> :|  # [ 7380] -<?>-   35 -25252+   5.587  xnpod_resume_thread+0x59 [xen=
o_nucleus ] (xnthread_periodic_handler+0x31 [xeno_nucleus])
> :|  # [ 7380] -<?>-   35 -24820+   4.214  xnpod_schedule+0x6c0 [xeno_nu=
cleus] (x npod_suspend_thread+0x118 [xeno_nucleus])
> :|  # [ 7380] -<?>-   35 -24734+   1.501  xnpod_schedule+0x97 [xeno_nuc=
leus] (xn intr_irq_handler+0x9a [xeno_nucleus])
> :|  # [ 7380] -<?>-   35 -24589+   1.218  xnpod_schedule+0x6c0 [xeno_nu=
cleus] (x nintr_irq_handler+0x9a [xeno_nucleus])
> :   + func               -24587    0.493  __rt_task_wait_period+0x11 [x=
eno_native] (hisyscall_event+0x162 [xeno_nucleus])
> :   + func               -24586    0.485  rt_task_wait_period+0xb [xeno=
_native] (__rt_task_wait_period+0x3f [xeno_native])
> :   + func               -24586    0.464  xnpod_wait_thread_period+0xe =
[xeno_nucleus] (rt_task_wait_period+0x4b [xeno_native])
> :|  + begin   0x80000001 -24586    0.718  xnpod_wait_thread_period+0x1e=
d [xeno_nucleus] (rt_task_wait_period+0x4b [xeno_native])
> :|  # func               -24585    0.621  xnpod_suspend_thread+0xe [xen=
o_nucleus] (xnpod_wait_thread_period+0x91 [xeno_nucleus])
> :|  # func               -24584    0.558  xnpod_schedule+0xe [xeno_nucl=
eus] (xnpod_suspend_thread+0x118 [xeno_nucleus])
> :|  # [ 7380] -<?>-   35 -24584    0.847  xnpod_schedule+0x97 [xeno_nuc=
leus] (xn pod_suspend_thread+0x118 [xeno_nucleus])
> :|  # [    0] -<?>-   -1 -10630    0.916  xnpod_schedule+0x6c0 [xeno_nu=
cleus] (xnintr_irq_handler+0x9a [xeno_nucleus])
> :|  # [    0] -<?>-   -1 -4632    0.886  xnpod_schedule+0x6c0 [xeno_nuc=
leus] (xnintr_irq_handler+0x9a [xeno_nucleus])
> :|  # [ 7380] -<?>-   35  -609+   1.747  xnpod_resume_thread+0x59 [xeno=
_nucleus] (xnthread_periodic_handler+0x31 [xeno_nucleus])
> :|  # [ 7380] -<?>-   35  -186+   4.288  xnpod_schedule+0x6c0 [xeno_nuc=
leus] (xn pod_suspend_thread+0x118 [xeno_nucleus])
> :|  # [ 7380] -<?>-   35  -143+   1.554  xnpod_schedule+0x97 [xeno_nucl=
eus] (xni ntr_irq_handler+0x9a [xeno_nucleus])
> :|  # [ 7380] -<?>-   35    -6+   1.211  xnpod_schedule+0x6c0 [xeno_nuc=
leus] (xn intr_irq_handler+0x9a [xeno_nucleus])
> <   + freeze  0x00000007     0    0.929  xnshadow_sys_trace+0x8b [xeno_=
nucleus] (hisyscall_event+0x162 [xeno_nucleus])
>=20
>=20
> At time -24587 usec, the task calls rt_task_wait_period(), presumable t=
o
> sleep for approx 10msec.  So, I would expect to see the task resumed at=

> approx clock -14587.  However, the task is not resumed until clock -609=
,
> and not run until time -186.  So, the task wasn't sheduled for over 14m=
sec.
> During this time, the ROOT task, presumably pid=3D0 priority=3D-1,  ran=
  61
> times.  I included a 2 samples of this in the above trace.
> Thus a worse priority task ran many times, when my better priority
> task was not being scheduled.
>=20
> I am new to interpreting ipipe traces, and may be overlooking some of t=
he details.
> I would appreciate help understanding this problem, and how to fix it.
>=20
> config:
> arch =3D x86
> Linux 2.6.17.14
> Xenomai-2.2.4
> ipipe 1.5-00
>=20
>=20
> TIA,
> 	Jeff
>=20

Jan


--------------enig0AE23E3132D1807D578342ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5Hi7niDOoMHTA+kRArkoAJ4kvOutfjGxwaKwT6xzLOO4G6f9pQCfTA35
NdaMDBoRcyKQlMLgPLvGVEQ=
=Iv95
-----END PGP SIGNATURE-----

--------------enig0AE23E3132D1807D578342ED--

