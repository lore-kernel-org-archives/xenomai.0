Message-ID: <44326FBB.9070405@domain.hid>
Date: Tue, 04 Apr 2006 15:08:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Panic in rt_queue_create: bug or misuse?
References: <6ee4c8380604032304h2de399c6geffbbae78ab6124b@domain.hid>	<443225ED.6070104@domain.hid>
	<44322BDD.8010706@domain.hid>
	<6ee4c8380604040553t1ece4750waa548d1715be3e30@domain.hid>
In-Reply-To: <6ee4c8380604040553t1ece4750waa548d1715be3e30@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4EBB5784066663CAB39F1CF"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4EBB5784066663CAB39F1CF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
> How could I forget mlockall? I've been calling it in rtai forever...Is
> there any other neccessary boilerplate?

This is a very frequently made mistake. Philippe, is there a chance add
some simple debug check for this situation? Something to check when the
first shadow thread is created for a process?

Jan


--------------enigF4EBB5784066663CAB39F1CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMm+7niDOoMHTA+kRAjwyAJ4/ACbyyAT6DK1bUjMyngqUCbGSiwCcDmvL
etGJjf4JyPBpb/JIQiDbDzI=
=LRyk
-----END PGP SIGNATURE-----

--------------enigF4EBB5784066663CAB39F1CF--

