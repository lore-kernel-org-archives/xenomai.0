Message-ID: <45AE8062.7050701@domain.hid>
Date: Wed, 17 Jan 2007 21:00:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel
	on	FC6	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>	<45ADE724.3010800@domain.hid>
	<45AE3ED4.7040506@domain.hid> <45AE68CF.5080200@domain.hid>
	<45AE7D81.9050007@domain.hid>
In-Reply-To: <45AE7D81.9050007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE26F93CED5AC4E614B86ED9"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE26F93CED5AC4E614B86ED9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Hmm, that tickles my fantasy once again: Could we derive generic .spec=
s
>> from your files to include them in the Xenomai distribution? Then some=

>> additional Makefile rules could provide a "make rpm" that generates
>> packages for kernel and userland (when given some kernel.tar.bz2).
>> Basically, your steps generalised and automated.
>=20
> That would be great.  I started with the 'mkspec' script from the
> vanilla kernel tree, and added a few things that make the resulting RPM=
s
> work better with Fedora.  I'm not sure how other distributions handle
> things like creating an initrd, etc.  Maybe someone could post a
> kernel.spec file for the latest version of SuSE.  I can look at it and
> see how it differs from what I'm doing on Fedora.

You don't want to see it. In case so insist:

http://www.rts.uni-hannover.de/rtaddon/rpms/src/unpacked/kernel-xeno-defa=
ult.spec

>=20
> Right now, my spec file also creates a HUGE kernel-source RPM that
> contains the whole compiled source tree.  I really need to understand
> how the Fedora spec file creates kernel-devel RPMs that have just the
> stuff needed for compiling kernel modules.  This would be a lot better
> than having the huge kernel-source RPM that I generate now.

No clue either here (given the SuSE file...).

>=20
>> This would help us to provide, e.g., an i386 pre-built package with
>> reasonable default config, something I still consider useful. But, of
>> course, it must not cost any effort :). Automated rpm generation would=

>> be a big step in that direction.
>=20
> I think that would be very useful to many folks.
>=20
>> BTW, have you seen my Xenomai.spec for the SuSE packages I once posted=
?
>> Attached is an updated version. It splits the Xenomai userland in
>> several sub-packages to allow selective installation.
>=20
> No, I hadn't looked at it.  That is probably a better approach.  I can
> test this on Fedora when I get a chance.

You're welcome. The userspace part should be simpler to make generic.

Jan


--------------enigAE26F93CED5AC4E614B86ED9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFroBiniDOoMHTA+kRAnZ4AKCAdtcJOi4OLukAeRYbaJ1l3sFQ0QCeM7ul
Xv7sHVYjpGjB30uoA5eQnHM=
=TkKy
-----END PGP SIGNATURE-----

--------------enigAE26F93CED5AC4E614B86ED9--

