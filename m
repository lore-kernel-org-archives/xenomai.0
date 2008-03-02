Message-ID: <47CACD33.5000107@domain.hid>
Date: Sun, 02 Mar 2008 16:52:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47CA8934.3060405@domain.hid>
	<18378.50046.906228.646119@domain.hid>
In-Reply-To: <18378.50046.906228.646119@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53F0F57C7C44A95D5082A6DD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/6] Fix, refactor,
 and optimize xnlock services, v2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53F0F57C7C44A95D5082A6DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > here comes version 2 of my xnlock rework. Changes since the first
>  > release:
>  >=20
>  >  - Moved xnlock_spin out-of-line instead uninlining the irqsave/rest=
ore
>  >    services
>=20
> The size changes are not as dramatic as with the first version. Did you=

> have any chance to test the latency with your first version?

Not under the same conditions (isolated core). In essence, the gain was
less significant (~1 us). I came to the conclusion that this might be
due to some loss related to moving xnlock_put_irqrestore out-of-line (I
think now that function was too small for this).

Instead of further digging into this I decided to address the root of
the issue, ie. bringing down the text size of the pipeline-head
services. So you now have to apply the ipipe patch to achieve both a
text size reduction (almost as good as the original one) AND a code path
length reduction (more important!). Actually, I haven't even done a full
benchmark with this patch applied as well yet, but it is not that
interesting as the runtime advantage is obvious (simply less ops).

>=20
>  >  - Beautified xnlock_dbg interface (now only static-inlines)
>=20
> Well, I am still not convinced, I still find the debugging version hard=
er
> to read. Is there a problem with implementing the two versions
> separately with a unique #ifdef?

Well, everything is possible. But we would start to duplicate LOC again,
namely both the lock implementations and the debugging services. Just
look at the final system.h and pod.h after applying all patches.

I could try this, but only if it is _really_ desired. I'm convinced it
is the wrong way because I consider the readability and consistency of
the lock implementation more important than its debug code.

Jan


--------------enig53F0F57C7C44A95D5082A6DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHys04niDOoMHTA+kRAviIAJsGzSpj24lxMsd/poX+It31aZ/fHACaAhLY
wZfCrCfscXXIw0/KldXPRbM=
=66bx
-----END PGP SIGNATURE-----

--------------enig53F0F57C7C44A95D5082A6DD--

