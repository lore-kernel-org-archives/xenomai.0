Message-ID: <46EB8A11.1060605@domain.hid>
Date: Sat, 15 Sep 2007 09:30:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <747825.19128.qm@domain.hid>
In-Reply-To: <747825.19128.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F272BA854663F9C169B5C3B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Adeos to Linux domain data communication
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F272BA854663F9C169B5C3B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

poornima r wrote:
> Hello,
>=20
> I am working on PPC boards (MPC 860).
> I have patched
> Adeos(adeos-ipipe-2.6.18-ppc-1.5-01.patch)
> to my vanilla kernel linux-2.6.18.
> My requirement are=20
> 1. A domain servicing critical interrupts and=20
> 2. Adeos to Linux domain communication
>=20
> I could implement the first requirement by creating a=20
> test domain where my interrupts are getting serviced
> as provided in the below link
> http://www.captain.at/adeos-ipipe-jitter-latency-test.php
>=20
>=20
> But for the second requirement I went through all the
> API services provided by Adeos but, dint find any APIs
>  providing data communication services between Adeos
> and Linux domains. Is there any method to implement
> the above similar to pipes in Xenomai (I am not using
> Xenomai in my current implementation).

Adeos/I-pipe is not implementing such services in order to remain lean.
It is considered the job of the Adeos user (like Xenomai or your own
domains) to handle this. What Adeos provides are means to stall as many
domains along the pipeline as required to execute critical sections like
for implementing interdomain communication services.

>=20
> But when went through Adeos related papers and
> documents, I found that Adeos is mainly used for
> harware sharing among multiple OSes or domains but
> alone does not provide tasking, communication, etc. So
> do you think    =20
> can we implement communication mechanism similar to
> xenomai pipes for Adeos domain and Linux domain
> communication or is it worth using Xenomai?    =20

That depends on how much more high-level services you may want to use
(now or in the future). From a certain point on, re-implementing things
becomes silly. If this is just about a basic pipe-like IPC for a simple
scenario like yours, it could make sense to write your own variant,
skipping all other services of the Xenomai core that may remain
unused on your target anyway (and their overhead).

Jan


--------------enig6F272BA854663F9C169B5C3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG64oRniDOoMHTA+kRAnMWAJ9jgnv3Euk8Oy79seZCML8iDT8SWACeND+V
JWa5NsxBYSNb1QTGwYHEILo=
=sUL7
-----END PGP SIGNATURE-----

--------------enig6F272BA854663F9C169B5C3B--

