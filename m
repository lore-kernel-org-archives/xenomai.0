Message-ID: <441ED657.1080405@domain.hid>
Date: Mon, 20 Mar 2006 17:20:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: <200603201434.15258@domain.hid>
In-Reply-To: <200603201434.15258@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig995FF3B026C6521369019E3B"
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig995FF3B026C6521369019E3B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> Hello,
> I'm trying to port a  driver of a AD card to RTDM.

The discussion around blockable contexts made me forget to ask some
question:

I heard rumours of some COMEDI (www.comedi.org) port over RTDM recently,
don't know the current status. Anyway, have you considered that
abstraction model for your driver? Is there already a COMEDI driver for
your card in COMEDI? Maybe it's more useful then to through all efforts
together and get a generic solution running.

Jan


--------------enig995FF3B026C6521369019E3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHtZXniDOoMHTA+kRAoHiAJ9v/amNP9mXVhjM2p6Kn6Nj5ADJMwCfa5lq
Wnpdm61chZz5knwK3Y6QsZM=
=c4xO
-----END PGP SIGNATURE-----

--------------enig995FF3B026C6521369019E3B--

