Message-ID: <458A828A.6060506@domain.hid>
Date: Thu, 21 Dec 2006 13:48:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <458A4DE0.5030005@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
In-Reply-To: <2890274.1166696466862.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4343D66D1CB59B0574BE71D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4343D66D1CB59B0574BE71D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan, hi everybody,
>=20
> I have stripped down my program that is crashing Xenomai even further.
> (I have attached the complete source code).
> No rtnet is required.
> Now I have the following real time task:
>=20
> static void realtimetask(void *arg)
> {
>     system("ls -l");
>     rt_task_sleep(1000000000ULL);
>     printf("rt_task_sleep done...\n");
> }

Does this code freeze your box as well:

#include <native/task.h>
#include <sys/mman.h>

main()
{
    RT_TASK task;

    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_task_shadow(&task, "crash", 1, 0);
    rt_task_sleep(1000000000ULL);
    system("ls -l");
    rt_task_sleep(1000000000ULL);
    printf("rt_task_sleep done...\n");
}

Or what is different with your test case? I got hold of P4 2.8 GHz
meanwhile, but the box still prefers to run the code without troubles.

Jan


--------------enigA4343D66D1CB59B0574BE71D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFioKKniDOoMHTA+kRAt/LAJ4ogw4dac9fHpA5C2qSx6a5epbfiQCeLK+f
Pv0rpAdlUCNCcePutex/dWw=
=aP9g
-----END PGP SIGNATURE-----

--------------enigA4343D66D1CB59B0574BE71D--

