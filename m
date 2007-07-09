Message-ID: <46924B1B.1010308@domain.hid>
Date: Mon, 09 Jul 2007 16:50:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>
	<1183992374.6014.84.camel@domain.hid>
In-Reply-To: <1183992374.6014.84.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17A03518FE4C54914B78D640"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17A03518FE4C54914B78D640
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>> Hello,
>>
>> the attached patch changes:
>>
>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>
>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.
>>
>=20
> Merged, thanks.

You are too fast for me - I was still test-building my approach!

Looks rather like I picked the wrong expression for marking
rtdm_task_sleep_until deprecated. I would prefer to go for this variant
and back Wolfgang's patch out again:

--- include/rtdm/rtdm_driver.h  (Revision 2758)
+++ include/rtdm/rtdm_driver.h  (Arbeitskopie)
@@ -1009,7 +1009,7 @@ rtdm_task_sleep_abs(nanosecs_abs_t wakeu
 }

 /* rtdm_task_sleep_abs shall be used instead */
-static inline int __deprecated
+static inline int __deprecated_call__
 rtdm_task_sleep_until(nanosecs_abs_t wakeup_time)
 {
     return __rtdm_task_sleep(wakeup_time, XN_REALTIME);


But note that I'm still test-building...

Jan


--------------enig17A03518FE4C54914B78D640
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkkscniDOoMHTA+kRAv+6AJwJ/awbafGt2ncOAXXMBWyNae7fhwCfdKvV
zVfrOsNf7bAD4iux23CMYm8=
=EhDW
-----END PGP SIGNATURE-----

--------------enig17A03518FE4C54914B78D640--

