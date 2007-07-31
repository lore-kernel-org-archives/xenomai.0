Message-ID: <46AF63F8.70207@domain.hid>
Date: Tue, 31 Jul 2007 18:31:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46AF5F1E.7030009@domain.hid> <1185899217.6611.246.camel@domain.hid>
In-Reply-To: <1185899217.6611.246.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1DEAD3177F1C7BA96F9B5072"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] 2.4-rc1: modular nucleus cannot be	unloaded
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DEAD3177F1C7BA96F9B5072
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-07-31 at 18:11 +0200, Jan Kiszka wrote:
>> Already a plain command sequence causes this problem:
>>
>> # modprobe xeno_nucleus
>> # rmmod xeno_nucleus
>> rmmod: xeno_nucleus: Resource temporarily unavailable
>>
>> Can anyone confirm?
>=20
> Cannot reproduce it here. However, I got another report saying that
> /proc/xenomai/stat would return -ENOMEM. Cannot reproduce it here
> either, though, but it does happen on the other site.

OK, will look into it again once I found what breaks
xnintr_edge_shirq_handler() here (2.4 and 2.3). Damn it.

Jan


--------------enig1DEAD3177F1C7BA96F9B5072
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGr2P5niDOoMHTA+kRAjxEAJ9+CfMp07IAPXBcwbvj1HgDJGuRlQCeLa0m
NLAQcLBZtdZA7hJaFKsyYwg=
=0v1H
-----END PGP SIGNATURE-----

--------------enig1DEAD3177F1C7BA96F9B5072--

