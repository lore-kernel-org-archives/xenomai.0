Message-ID: <45DEF872.5050608@domain.hid>
Date: Fri, 23 Feb 2007 15:21:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>
	<45DEF605.2060402@domain.hid> <45DEF6AA.5030609@domain.hid>
In-Reply-To: <45DEF6AA.5030609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72C7AC41EA267D47AD9B1E9C"
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
--------------enig72C7AC41EA267D47AD9B1E9C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Scholz wrote:
> Gilles,
>=20
>>> Sure but I would still not expect the system to hang!
>>> As I said missing a deadline is bad but ok.
>>> But hanging the whole system is not quite ok.
>> I want this bug solved too, especially since I am not sure that we wil=
l
>> only see it with too short periods.
>=20
> Makes us two! ;-)
>=20
>> I would add the call to printascii(printk_buff) directly in vprintk, a=
nd
>> use printk. Note however that special care must be taken to avoid
>> recursion when calling printk inside schedule, because printk may use
>> schedule. Anyway, I think the tracer will give better results than a
>> simple backtrace.
> Ok. Thanks.
>=20
> So what exactly shell I do? I have never worked with "the tracer".
>=20

Start here: http://www.xenomai.org/index.php/I-pipe:Tracer

I haven't followed all details (while hacking on other bugs :)), but you
have two options to catch a trace: the one described on that page *if*
your board survives the crash, or via ipipe_trace_panic_freeze()
followed by ipipe_trace_panic_dump() (+ switching to sync printk mode
first).

I'm currently cooking a patch to include the IRQ and domain states in
the latter output (they are available via /proc/ipipe/trace/frozen alread=
y).

Jan


--------------enig72C7AC41EA267D47AD9B1E9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vhyniDOoMHTA+kRAgtxAJ9gP4LSR3FgtEbl/YwgKz38iq3DWQCfarEl
W2S2lR+q+Zyev7emXSSZ4ic=
=lyNi
-----END PGP SIGNATURE-----

--------------enig72C7AC41EA267D47AD9B1E9C--

