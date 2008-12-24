Message-ID: <49518900.5040504@domain.hid>
Date: Wed, 24 Dec 2008 01:57:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081223190649.26094.61372.stgit@domain.hid>
	<49513A4F.2060700@domain.hid>
In-Reply-To: <49513A4F.2060700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD7BA08DF5DB10291C1C5448C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v2 0/5] NMI watchdog fixes / enhancements
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7BA08DF5DB10291C1C5448C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Changes since last round:
>>  - Fix build breakage of trunk against 2.6.27
>>  - Make rthal_nmi_release more robust (additional patch)
>>  - Fix issue of last patch on 32 bit (untested last-minute changes...)=

>>
>> All patches are also available at
>> git://git.kiszka.org/xenomai.git nmi-wd-queue
>=20
> I remind you that trunk is currently broken for the posix skin on arm, =
a
> regression introduced by your FASTSYNCH patches. From my point of view,=

> fixing this regression is more important than fixing an option that
> almost nobody uses with untested patches...

Many things are broken and awaiting a fix. I also have 6 posted bug
fixes in my assorted patch queue for Xenomai ATM. But this doesn't mean
everything else has to wait just because review or merging is delayed
due to current overload.

And FYI, I've discussed the posix skin setup race with Wolfgang last
week, suggesting a few things to try next on his target - what he will
likely do as soon as time permits. I can't help at this point as A) the
race is not yet obvious for me and B) I've no chance to reproduce it.
But any further information on this is always welcome - if you happen to
see the problem as well.

Regarding this thread, I would appreciate if we could just stay on
topic. If you don't have the time for the patches, then it's absolutely
OK, just leave them alone.

Jan


--------------enigD7BA08DF5DB10291C1C5448C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklRiQUACgkQniDOoMHTA+lRNQCeNEu18H1G4KX3OG9jgHKzTKgw
jN8Ani2NjVa0o0+mtUElkX1wvNQHlNOF
=g+25
-----END PGP SIGNATURE-----

--------------enigD7BA08DF5DB10291C1C5448C--

