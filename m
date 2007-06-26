Message-ID: <4680DCC8.1000704@domain.hid>
Date: Tue, 26 Jun 2007 11:30:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid>
In-Reply-To: <4680DA9B.5020501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA83749417C526FB1D0B08710"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Group-based RT caps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA83749417C526FB1D0B08710
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> I'm moving this thread to xenomai-core as I have some implementation id=
ea...
>=20
> Fillod Stephane wrote:
>> ...
>> I think Johan was not asking to disable the mlockall, but to allow som=
e.
>> non-root user to be able to do it. He found his solution anyway, which=

>> is worth an entry in the FAQ.
>>
>> Since it is going to be a FAQ for those people in embedded business,
>> some
>> tricks to allow non-root operation of mlockall, SCHED_FIFO, etc., woul=
d
>> be=20
>> useful. For example, you may hack the commoncap in linux/security/,=20
>> or a better solution would be to rely on realtime-lsm[1][2], thanks to=
=20
>> the audio folks.
>>
>> [1] http://sourceforge.net/projects/realtime-lsm/
>> [2] http://lwn.net/Articles/110346/
>>
>=20
> I think we could and should incorporate such a feature into the nucleus=
=2E
>=20
> There is already code in xnshadow_map playing with cap_effective, but
> that happens too late. Instead, we should establish a group-based acces=
s
> control just like rt-lsm (the other knobs of that module are either
> irrelevant for Xenomai (mlock=3D0) or broken security-wise (any=3D1)) a=
nd
> raise the required caps for a process that belongs to the specified
> group, likely when an Xenomai interface gets attached by that process.

At this chance we should also remove CONFIG_XENO_OPT_SECURITY_ACCESS and
make the check mandatory. Due to the mlockall test, we effectively
demand raised privileges already. So there is no use in leaving other
Xenomai services open for non-privileged users.

Jan


--------------enigA83749417C526FB1D0B08710
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgNzIniDOoMHTA+kRAq7tAJ98lh4Sxzunc4XXnKKKn2kCEr4M9wCeM0nt
zwIhzwlUPhf9//f9FbBHez4=
=YgFx
-----END PGP SIGNATURE-----

--------------enigA83749417C526FB1D0B08710--

