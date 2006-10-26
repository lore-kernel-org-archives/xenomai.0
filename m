Message-ID: <45409310.5070504@domain.hid>
Date: Thu, 26 Oct 2006 12:50:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problemm with 2.2.4 release
References: <200610261227.29595.s.zimmermann@domain.hid>
In-Reply-To: <200610261227.29595.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29637A531ABF16AFBCF847C3"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29637A531ABF16AFBCF847C3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hello list,
> I recently switched from 2.2.0 on Kernel 2.6.17.6 to more actual 2.2.4 =
 on=20
> Kernel 2.6.17.14.
> After upgrading my periodic tasks won't work at all (task_wait and=20
> set_periodic functions return errors). I wrote a little testprogram to =
verify=20
> it's not a problem with my Software. The code runs fine on my Notebook,=
 still=20
> under 2.2.0/2.6.17.6, but won't work on my Desktop (AMD X2 / VIA K8T800=
) with=20
> the all-new Kernel/Xenomai installation. Maybe there is some config-thi=
ng i=20
> have overseen?
>=20
> #include <iostream>
> #include <sys/mman.h>
>=20
> #include "native/task.h"
> #include "native/timer.h"
>=20
> RT_TASK maintask;
>=20
> int main(void){
> 	std::cout << "xenomai 2.2.4 timer-test" << std::endl;
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> =09
> 	int err;
> 	unsigned long overrun =3D 0;=20
> =09
> 	err =3D rt_task_shadow (&maintask,"maintask",10,0);
> 	std::cout << "task shadow:" << err << std::endl;
> =09
> 	err =3D rt_timer_set_mode(1000000);
> 	std::cout << "timer set mode:" << err << std::endl;
> =09
> 	err =3D rt_task_sleep(1000);
> 	std::cout << "task sleep:" << err << std::endl;
> =09
> 	err =3D rt_task_set_periodic(NULL,TM_NOW,1000); =20
> 	std::cout << "task set periodic:" << err << std::endl;
> =09
> 	for(int i  =3D 0; i < 3; i++){
> 		err =3D rt_task_wait_period(&overrun);
> 		std::cout << "task wait period:" << err << " overrunns:" << overrun <=
<=20
> std::endl;
> 	}
> =09
> 	return 0;
> }
>=20
> Output on my Workstation:
> ----------------------------------------------
> xenomai 2.2.4 timer-test
> task shadow:0
> timer set mode:0
> task sleep:0
> task set periodic:-22
> task wait period:-11 overrunns:0
> task wait period:-11 overrunns:0
> task wait period:-11 overrunns:0
>=20
> Output on my Notebook:
> ----------------------------------------------
> xenomai 2.2.4 timer-test

I guess this is a typo (2.2.0?).

> task shadow:0
> timer set mode:0
> task sleep:0
> task set periodic:0
> task wait period:0 overrunns:0
> task wait period:0 overrunns:0
> task wait period:0 overrunns:0
>=20

Looks like we have a bug here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L340=
8

That new LART check doesn't consider the periodic mode where period does
not have the same unit as nkschedlat. Something like this might be
needed (quick hack alarm!):

--- ksrc/nucleus/pod.c  (revision 1747)
+++ ksrc/nucleus/pod.c  (working copy)
@@ -3413,7 +3413,7 @@ int xnpod_set_thread_periodic(xnthread_t
                        xntimer_stop(&thread->ptimer);

                goto unlock_and_exit;
-       } else if (period < nkschedlat) {
+       } else if (nkpod->tickvalue =3D=3D 1 && period < nkschedlat) {
                /* LART: detect periods which are shorter than the
                 * intrinsic latency figure; this must be a joke... */
                err =3D -EINVAL;

Jan


--------------enig29637A531ABF16AFBCF847C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQJMQniDOoMHTA+kRAoGeAJ4zi2MAbdko2KdaN7MNBVP7/aBsswCfTzF/
wxh3M+ruB6QROcxwvPUb38I=
=oy3G
-----END PGP SIGNATURE-----

--------------enig29637A531ABF16AFBCF847C3--

