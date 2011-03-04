From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 4 Mar 2011 15:53:42 +0100
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
In-Reply-To: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4248826.GJ61z5cYvx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201103041554.07327.kisda@domain.hid>
Subject: Re: [Xenomai-help] xenomai patched kernel "laggy"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Hyams <jeff.hyams@domain.hid>
Cc: xenomai@xenomai.org

--nextPart4248826.GJ61z5cYvx
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Freitag 04 M=E4rz 2011, 14.39:44 schrieb Jeff Hyams:
> I am running a patched 2.6.32.20 kernel with the correct xenomai patches
> (2.5.5.2 and the adeos patch for 2.6.32.20) and my RT application seems to
> work fine, I can use the PEAK CAN drivers fine, and I managed to make a
> config where all my interrupts work.  However, when using the machine
> without any real time apps running, I start to see a lot of latency in
> normal use.  Ie, a regular compile operation that normally takes a few
> seconds all the sudden takes a minute, and my i/o also seems incredibly
> slow.  The display also seems lag frequently.

Is the kernel laggy too if you disable "real-time sub-system -> Xenomai" and
"processor type and features" -> Interrupt pipeline" in the configuration ?

Stefan

--nextPart4248826.GJ61z5cYvx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1w/P8ACgkQIPTw9rIdn6pq7QCeMmaF3KelF0UiV9ESG48PW7aI
cN0AnjE7L0QHkT6OhYsZCBLZWO8FZ+BX
=c8CV
-----END PGP SIGNATURE-----

--nextPart4248826.GJ61z5cYvx--

