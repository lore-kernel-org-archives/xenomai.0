Message-ID: <43E22EF4.5060809@domain.hid>
Date: Thu, 02 Feb 2006 17:10:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Three questions about RTDM
References: <1138870064.8753.19.camel@domain.hid>	<43E1D0D6.2020003@domain.hid>	<1138876539.8753.60.camel@domain.hid>	<43E1E252.8090304@domain.hid>
	<1138894042.8753.105.camel@domain.hid>
In-Reply-To: <1138894042.8753.105.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF1FAFE293D0996B6073D780"
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
To: Alessio Igor Bogani <abogani@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF1FAFE293D0996B6073D780
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi Jan,
>=20
> [RTDM Docs]
>>> I would be very happy to see for RTDM something similar to Xenomai's
>>> Native-API-Tour.
>> Would be nice - just takes /someone/ to write it... :-/
>=20
> Ok :-)
>=20
>> Maybe this paper can provide a few further hints meanwhile:
>>
>> ftp://ftp.realtimelinuxfoundation.org/pub/events/rtlws-2005/JanKiszka.=
pdf
>=20
> Wow! Can you put this document in Technical articles section in
> Xenomai's site? I think that this document could be useful for others. =


Yes, this should be done indeed.

@All: How to include this in the SVN and later the website? As PDF only
or also in source code form (it's latex).

>=20
> [heartbeat example]
>>> Mysteriously heartbeat.ko module resulted is dependent from
>>> latency_rt.ko module (present in testsuite\klatency in Xenomai packag=
e)
>>> for a reason that i don't understand. :-(
>>> How can resolve this problem?
>> Due to which symbol? Which Xenomai version precisely? Indeed very
>> strange. Something must be broken in your build.
>=20
> Xenomai 2.0.3
>=20
> Heartbeat.ko is loaded but not start and rtdm_task_init() return a -11
> error code (EAGAIN?). If i load latency_rt.ko before to load
> heartbeat.ko this work perfectly.
> I suppose that heartbeat.ko should do start a timer, or not?

RTDM does not know any abstraction for the system timer. That's intended
because only the native skin currently controls it at API level, all
others via a module parameter. So, to test heartbeat, you just have to
load any skin or application that starts the timer. "insmod xeno_posix"
does this job e.g.

Jan



--------------enigFF1FAFE293D0996B6073D780
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4i70niDOoMHTA+kRAoGnAJoCZyrghI1DdGXsf7WRZ8RQhLyUkgCcCXc6
wrGUrd1JAe9AU98XlWOPLhk=
=yHos
-----END PGP SIGNATURE-----

--------------enigFF1FAFE293D0996B6073D780--

