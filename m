Message-ID: <45E161AA.9070005@domain.hid>
Date: Sun, 25 Feb 2007 11:15:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Scheduling of different domains in Adeos
References: <45E15BC1.2000303@domain.hid>
In-Reply-To: <45E15BC1.2000303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig849044CDB8159388CA55B1D5"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig849044CDB8159388CA55B1D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Dear Adeos Developers/Users,
>=20
> while I was reading some papers about Adeos I was wondering how
> scheduling is done with Adeos, if there are several domains (e.g. each
> is an own operating system) working on top of it. Is there some kind of=

> a master-scheduler which selects the domain which is allowed to run nex=
t
> based on a static priority?
>=20

Scheduling takes place only based on the domain priority, each time a
new asynchronous event (interrupt) arrives or a domain reports to be
idle. There is no explicit source file or function called "scheduler",
you will find its logic in the dispatching code of pipelined interrupts
and in ipipe_suspend_domain().

Jan


--------------enig849044CDB8159388CA55B1D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4WGrniDOoMHTA+kRAqISAJ9wXtmofiIArJP/fDImS/kjiV0JCwCaAp74
+05R0Wf7BmhmQ/TIYd/lqYc=
=oPqX
-----END PGP SIGNATURE-----

--------------enig849044CDB8159388CA55B1D5--

