Message-ID: <45C33513.9070704@domain.hid>
Date: Fri, 02 Feb 2007 13:56:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] timer issues with SVN head
References: <45C225D1.7060503@domain.hid> <1170409213.4981.4.camel@domain.hid>
In-Reply-To: <1170409213.4981.4.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1073402BE9E15513FE7C32AD"
Sender: jan.kiszka@domain.hid
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
--------------enig1073402BE9E15513FE7C32AD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> On Thu, 2007-02-01 at 18:39 +0100, Jan Kiszka wrote:
>  =20
>> Hi,
>>
>> just to save my current finding and maybe trigger some feedback:
>>
>> We just tried both 2.3.x-SVN and trunk with our "reference robot". Whi=
le
>> 2.3.x behaves fine, weird things happened with trunk /wrt some serial
>> device. We saw reception timeouts and no serial IRQs.
>>
>> So I fired up a second box with plain latency test (all the latest: SV=
N,
>> 2.6.19.2, ipipe-i386-1.6-06):
>>
>>    =20
>>> root@domain.hid :/root# latency     =20
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: periodic user-mode task
>>> =3D=3D All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)=

>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---l=
at worst
>>> RTD| 1299105.405| 1505168.638|  -14316.105|    3671| 1299105.405|  -1=
4316.105
>>>      =20
>
> I can't reproduce this here, so this is likely an untested configuratio=
n
> issue again.
>
> .config welcome. TIA,
>
>  =20
What about a patch? =3D8)

--- include/nucleus/timebase.h  (revision 2094)
+++ include/nucleus/timebase.h  (working copy)
@@ -183,7 +183,7 @@ static inline xnticks_t xntbase_get_jiff
=20
 static inline xnticks_t xntbase_get_rawclock(xntbase_t *base)
 {
-	return xntbase_get_jiffies(base);
+	return xntbase_periodic_p(base) ? base->jiffies : xnarch_get_cpu_tsc();=

 }
=20
 int xntbase_alloc(const char *name,


This fixes at least one symptom I found, the broken latency test, but we =
still need
to re-check the serial device scenario on the robot. That will take longe=
r
unfortunately.

Jan



--------------enig1073402BE9E15513FE7C32AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwzUTniDOoMHTA+kRAnyDAJ44mSOug+HEMHcT+A5wTUcbzA9vNwCfQ7no
Mw5YEUglRJca8FEF39MdYls=
=FKyt
-----END PGP SIGNATURE-----

--------------enig1073402BE9E15513FE7C32AD--

