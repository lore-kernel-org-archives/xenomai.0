Message-ID: <45DF0393.5010808@domain.hid>
Date: Fri, 23 Feb 2007 16:09:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>	<45DEF605.2060402@domain.hid>
	<45DEF6AA.5030609@domain.hid>	<45DEF872.5050608@domain.hid>
	<45DF021A.3080807@domain.hid>
In-Reply-To: <45DF021A.3080807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5CEC5AA33D8031A2F28302E3"
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CEC5AA33D8031A2F28302E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Scholz wrote:
> Jan,
>=20
>>> So what exactly shell I do? I have never worked with "the tracer".
>>>
>> Start here: http://www.xenomai.org/index.php/I-pipe:Tracer
>>
>> I haven't followed all details (while hacking on other bugs :)), but y=
ou
>> have two options to catch a trace: the one described on that page *if*=

>> your board survives the crash, or via ipipe_trace_panic_freeze()
>> followed by ipipe_trace_panic_dump() (+ switching to sync printk mode
>> first).
>=20
> Do I need CONFIG_IPIPE_TRACE_MCOUNT=3Dy for the ipipe_trace_panic_dump(=
)?

Yes, because this is what adds per-function call trace points. Otherwise
the information is fairly thin.

Jan


--------------enig5CEC5AA33D8031A2F28302E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3wOUniDOoMHTA+kRAhdtAJwL/5aPB2A4x4J75eZfPDzSgaHMrgCfZ2VQ
0jagubJOZV2KYlUMqQBih2I=
=Sq3U
-----END PGP SIGNATURE-----

--------------enig5CEC5AA33D8031A2F28302E3--

