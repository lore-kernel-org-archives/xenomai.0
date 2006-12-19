Message-ID: <45884DC5.2030701@domain.hid>
Date: Tue, 19 Dec 2006 21:38:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<4586A0E6.6060608@domain.hid> <4586A820.3040509@domain.hid>
	<200612192054.54573.niklaus.giger@domain.hid>
In-Reply-To: <200612192054.54573.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0B0C878719A553162B09527"
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
To: niklaus.giger@domain.hid
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0B0C878719A553162B09527
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Montag, 18. Dezember 2006 15:39 schrieb Gilles Chanteperdrix:
>> Jan Kiszka wrote:
>>> @all: please give the -rc3 tar.bz2 hell! New files can easily slip
>>> through the developer fingers when it comes to distribution (I know t=
his
>>> very well /wrt RTnet...).
>> The way around this is to run automated scripts using the result of a
>> make distcheck instead of using an svn checkout. Niklaus, how hard wou=
ld
>> it be to change the buildbot to do this ?
> What do you want the buildbot do to exactly?
> a) First svn checkout followed by make distcheck?  This is easy. eg. I =
would=20
> just add an additional step before the "configured
> xenomai"
>=20
> b) Grab tarballs, extract them to clean directory? Here I need to study=
 the=20
> buildbot a bit better, as it does no concept for tarballs as ChangeSour=
ces.=20
> But I might write a small script which polls=20
> http://download.gna.org/xenomai/testing/ and
> http://download.gna.org/xenomai/stable/ for new tarballs. If found I wo=
uld=20
> unpack it somewhere and submit the change to some new builders Buildbot=
=20
> (similar to the /buildbot-full/).
> This will probably take a few hours of work, but quite for some time I =
felt=20
> uncomfortable about neither testing branches nor releases.
> If this solution works I would suggest that the release manager should =
delay=20
> announcing the availability of a new releases till he has examined the =

> results of the buildbot.
>=20
> What variant do you prefer?

I rather think c) is desired: checkout from svn, make dist, untar that
archive and continue to work with *those* sources.

Jan


--------------enigC0B0C878719A553162B09527
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiE3FniDOoMHTA+kRAvDGAKCFH9EHv3OSbO00dOBx85U/qxtyVgCdF/dB
Rx0t0g7EtFSjKW8tiTD1aKE=
=iJpD
-----END PGP SIGNATURE-----

--------------enigC0B0C878719A553162B09527--

