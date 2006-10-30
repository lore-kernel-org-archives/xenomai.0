Message-ID: <45463851.3030202@domain.hid>
Date: Mon, 30 Oct 2006 18:37:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with rt_queue
References: <20061030160829.3119.qmail@domain.hid>
In-Reply-To: <20061030160829.3119.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAFBFC9FB2B372A3B7B18D49"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAFBFC9FB2B372A3B7B18D49
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Thanks Jan .
> I have executed # patch -p0 < native-queue-bcast-fix.patch in directory=
 where xenomai is installed and in my case it is  /usr/xenomai directory =
but sender still goes out of memory  if no  listener  is  waiting on the =
queue and displays the message
>=20
> rt_queue_alloc(queue_inout, 8) failed
>=20
> After this message is displayed and i try to execute sender again then =
sender doesnot execute at all and simply displays above message so i need=
 to restart my computer if i want to eecute sender again .Should i execut=
e patch in some other directory or  is it some other problem?

Nope. Executing your original test case after applying my patch (AND
rebuilding Xenomai - did you check if the kernel you run got updated?)
clearly demonstrated on my box that the problem was fixed.

I would suggest to do a clean rebuild from latest SVN.

Jan


--------------enigFAFBFC9FB2B372A3B7B18D49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFRjhRniDOoMHTA+kRAk+4AJ9VB2NBdeDSlmLTFLaGC3qEKSZMtgCeMDfu
WVxd8P0vbKmI33sfWhkI8ck=
=AVQX
-----END PGP SIGNATURE-----

--------------enigFAFBFC9FB2B372A3B7B18D49--

