Message-ID: <4726EBBF.4030900@domain.hid>
Date: Tue, 30 Oct 2007 09:30:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472112E2.90008@domain.hid> <4723122D.3070002@domain.hid>
	<47267BD1.9030604@domain.hid>
In-Reply-To: <47267BD1.9030604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig733DD90B6C24D9F919D13EE8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-test failed to open benchmark device,
 code -19 at t1 and t2 # latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig733DD90B6C24D9F919D13EE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> Jan Kiszka wrote:
>> Dennis Nguyen wrote:
>> =20
>>> Hi,
>>>
>>> I built 2.6.22.10 linux kernel -i386 with xenomai 2.4-rc4 and
>>> adeos-ipipe-2.6.22-i386-1.10-09.patch.
>>>
>>> I checked enable SMI workaround, uncheck frequency scaling, uncheck A=
CPI
>>> and uncheck APM.
>>>
>>> I ran xeno-test and get the following failed message:
>>>
>>> Thu Oct 25 13:17:02 PDT 2007
>>> running: ./run -- -sh -T 120 -t1 # latency
>>> *
>>> *
>>> * Type ^C to stop this application.
>>> *
>>> *
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: in-kernel periodic task
>>> =3D=3D All results in microseconds
>>> latency: failed to open benchmark device, code -19
>>> (modprobe xeno_timerbench?)
>>>
>>> Thu Oct 25 13:17:04 PDT 2007
>>> running: ./run -- -sh -T 120 -t2 # latency
>>> *
>>> *
>>> * Type ^C to stop this application.
>>> *
>>> *
>>> =3D=3D Sampling period: 100 us
>>> =3D=3D Test mode: in-kernel timer handler
>>> =3D=3D All results in microseconds
>>> latency: failed to open benchmark device, code -19
>>> (modprobe xeno_timerbench?)
>>>
>>> Could you help me to solve the issue?
>>>    =20
>>
>> What does the kernel log say (=3D>dmesg) when you manually insert the
>> module (=3D>modprobe xeno_timerbench)? Do you still have versioning
>> conflicts with your modules (as reported on rtnet-users)?
>>
>> Jan
>>
>>  =20
>=20
> I could not find xeno_timerbench. How to include the xeno_timerbench
> when it is built?
> I got:
> [root@domain.hid bin]# modprobe xeno_timerbench
> FATAL: Module xeno_timerbench not found.
>=20
> I don't know about the versioning conflicts.

Did you enable the timer benchmark in the kernel configuration (Xenomai
menu -> drivers -> testing -> timer benchmark)=DF

Jan


--------------enig733DD90B6C24D9F919D13EE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJuu/niDOoMHTA+kRAmo3AJ94PolI6rMVjt04x/DnRxH5W5GXVACdHxmW
JA1ug+b5UftUkKwwWuGo/N8=
=Rdqx
-----END PGP SIGNATURE-----

--------------enig733DD90B6C24D9F919D13EE8--

