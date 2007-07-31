Message-ID: <46AF84B6.50306@domain.hid>
Date: Tue, 31 Jul 2007 20:51:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46AF5F1E.7030009@domain.hid> <1185899217.6611.246.camel@domain.hid>
In-Reply-To: <1185899217.6611.246.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE25CB351682C26A6FD8E2E3"
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
--------------enigBE25CB351682C26A6FD8E2E3
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

False alarm: Some forgotten Linux program was waiting on /dev/rtp
devices. Everything's unloading fine again after killing it.

Jan


--------------enigBE25CB351682C26A6FD8E2E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGr4S3niDOoMHTA+kRAkA4AJ9oun+/IpUkCq1VNlypnrts5LhjNgCfYGZ7
QUcNrsgrFssHBI0WsXhobD8=
=hNh7
-----END PGP SIGNATURE-----

--------------enigBE25CB351682C26A6FD8E2E3--

