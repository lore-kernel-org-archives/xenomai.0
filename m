Message-ID: <4438E90F.6070304@domain.hid>
Date: Sun, 09 Apr 2006 12:59:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Proposal to use buildbot for Xenomai
References: <200604072337.48181.niklaus.giger@domain.hid>
	<443777D4.3030002@domain.hid>
	<200604081223.11896.niklaus.giger@domain.hid>
In-Reply-To: <200604081223.11896.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0FC418A278E0C3109D1E0FB"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0FC418A278E0C3109D1E0FB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Samstag, 8. April 2006 10:44 schrieb Jan Kiszka:
>> Niklaus Giger wrote:
>>> Hi everybody
> <..>
>> This is a really great idea! Of course, I already have another test
>> candidate in mind: RTnet 8). Specifically the PPC environment would be=

>> interesting, as our "buildbot" (sorry, Wolfgang G. ;) ) is typically
>> very busy so that build regressions are sometimes only detected with
>> delay on that platform. Is it also possible to explicitly trigger an
>> update and rebuild?
> Yes of course. Just select a buildslave (e.g. ppc or hcu3 ->=20
> http://ngiger.dyndns.org/buildbot/hcu3) and you may manually trigger it=
=2E I=20
> intentionally left this facility open for everybody to test it. But it =
would=20
> of course be possible to restrict it only to a few selected developers.=
=20
>=20
> If you want, I can help you to setup the master.cfg for a rtnet buildbo=
t.

I would love to, but you know - time...

>=20
>> But also for Xenomai I would see this as a very useful tool, e.g. for
>> 2.4 build tests (I must confess I only test sporadically against this
>> kernel).
> I will add one. Could you please e-mail me (privately if you want) a wo=
rking=20
> config (ppc, no cross compiling if possible). Or do you want to add a b=
uild=20
> slave under your control?

Hmm, I would prefer to just use something, especially as my PPC
experiences are quite limited :). But I guess here are qualified people
listening who can quickly dig out some config.

> <..>
>> Is there no reset button you could control via a master station, e.g. =
by
>> attaching some cheap electronic to a parallel or serial port?
> There is a reset button, but then you have it running and consuming=20
> electricity all the times.

Yep, understandable.

>> I just remember that DENX once had or still have a remote PPC test-lab=

>> running. I CC'ed Wolfgang, maybe he could comment on this if and how i=
t
>> could be used.
> I would be willing to setup a buildbot for the u-boot, too, as my board=
 boots=20
> with a very outdated version of u-boot.
>=20
> Best regards
>=20

Jan


--------------enigE0FC418A278E0C3109D1E0FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOOkQniDOoMHTA+kRAjfXAJoCi+JCNdmnH8BZSejOKpx2hrZ8RQCfTVL0
OQvreUsAR2syT8VLQleLsJU=
=WbYU
-----END PGP SIGNATURE-----

--------------enigE0FC418A278E0C3109D1E0FB--

