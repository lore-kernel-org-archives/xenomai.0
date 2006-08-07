Message-ID: <44D74B8E.5050309@domain.hid>
Date: Mon, 07 Aug 2006 16:17:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
References: <1903678222@domain.hid> <44D74405.7000900@domain.hid>
	<1154960008.4322.8.camel@domain.hid>
In-Reply-To: <1154960008.4322.8.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDFB17BC79AF0ACACC32635D0"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFB17BC79AF0ACACC32635D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
>> Steve Kreyer wrote:
>>> Hi,
>>>
>>> Iam new to xenomai.=20
>>> For warming up I try to run this little test program:
>>>
>>> ---------------------------------------------------------------------=
--
>>> #include <native/task.h>
>>> #include <stdio.h>
>>> #include <sys/mman.h>
>>>
>>> RT_TASK task1;
>>>
>>> void rt_task1(void* user_data){
>>>     int err =3D 0;
>>>     printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));
>> You are running in one-shot mode, thus all time units are in
>> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the setu=
p
>> actually fails (but it doesn't report this - a corner case for
>> considering this a bug).
>=20
> The setup does not really fail, but the period is so short that the tic=
k
> occurs before the task has a chance to wait for the first release point=

> in the timeline, so rt_task_wait_period() notices that no timer is
> outstanding, but incorrectly concludes that no timer was ever armed.

Mmh, wouldn't the box simply lock up if the setup succeeded? It's a
periodic timer... :->

Jan


--------------enigDFB17BC79AF0ACACC32635D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE10uOniDOoMHTA+kRAmJuAJ9uC5mHQBbLwZGpCmjfyAc4BovQEACdH2oW
jy2FwlTsRF+FoIlzkyK+HCo=
=w87X
-----END PGP SIGNATURE-----

--------------enigDFB17BC79AF0ACACC32635D0--

