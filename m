Message-ID: <4565C1D7.9060509@domain.hid>
Date: Thu, 23 Nov 2006 16:44:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN: multiple sockets on one device
References: <DD39B5C3F4963040ADC9768BE7E430CB015D51BC@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D51BC@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD840B092C74853BA6286B67C"
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD840B092C74853BA6286B67C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Hi,
> =20
> If one opens two sockets to one CAN port and wants to use one socket
> file descriptor for reading and the other for writing, is it possible t=
o
> limit the writing socket to _write only_, so it doesn't receive message=
s
> ?

Option 1: Do not bind the socket, use sendto/sendmsg for transmitting
(send requires binding).

Option 2: Register an impossible filter for the write-only socket. This
is suboptimal ATM. Actually we should allow registering an empty filter
list for this purpose. This has been recently discussed on the socketcan
list, but I'm not aware of any concrete result.

Jan


--------------enigD840B092C74853BA6286B67C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZcHXniDOoMHTA+kRAqnhAJwJLLgudval6n8E1UtRMaEHH2cy6wCeNCF8
mO3DHErceyY/BzAn4v4SBwQ=
=G2n9
-----END PGP SIGNATURE-----

--------------enigD840B092C74853BA6286B67C--

