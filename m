Message-ID: <443777D4.3030002@domain.hid>
Date: Sat, 08 Apr 2006 10:44:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Proposal to use buildbot for Xenomai
References: <200604072337.48181.niklaus.giger@domain.hid>
In-Reply-To: <200604072337.48181.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA853C683A13D186F8C096234"
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
--------------enigA853C683A13D186F8C096234
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi everybody
>=20
> If you point your browser at http://ngiger.dyndns.org/buildbot/ (with e=
nding=20
> slash please), you will find a first prototype of the continuos integra=
tion=20
> tool buildbot (http://buildbot.sourceforge.net/)
>=20
> It proves that it possible to automatically retrieve each revison of th=
e=20
> Xenomai and compile it for (at the moment) two targets, a stock PPC and=
 a=20
> custom PPC405 board (cross-compiling).
>=20
> At the moment it already is useful for me, but I would like to ask your=
=20
> opinion about its usefulness. Would this be useful for you too? Do you =
have a=20
> special target to propose (other architectures, other target like skins=
, all=20
> xenomai components as modules/built-ins, mvm simulator)?

This is a really great idea! Of course, I already have another test
candidate in mind: RTnet 8). Specifically the PPC environment would be
interesting, as our "buildbot" (sorry, Wolfgang G. ;) ) is typically
very busy so that build regressions are sometimes only detected with
delay on that platform. Is it also possible to explicitly trigger an
update and rebuild?

But also for Xenomai I would see this as a very useful tool, e.g. for
2.4 build tests (I must confess I only test sporadically against this
kernel).

>=20
> Be warned that setting up a buildbot master/slave using known good=20
> configuration is easy and can be accomplished in less than half an hour=
, but=20
> tweaking the master.cfg takes time and errors are not always easy to sp=
ot.=20
> E.g. I spent about 40 hours to until I could present you this email and=
 the=20
> attached documents.
>=20
> Corrections/suggestions to all documents included are welcome.
>=20
> In the attached tar file you find a pdf file with detailed instructions=
 on how=20
> to setup a build slave/master for xenomai to experiment with.=20
>=20
> I am willing to work in the next weeks (or months) to improve the build=
bot=20
> master, integrate more slaves. If the xenomai developers would like to =

> transfer (now or some time later) the master to another machine this wo=
uld be=20
> fine for me too. Anywhy if this buildbot master generates too much traf=
fic I=20
> might be forced to remove it, as the machine is my private small server=
=20
> connected via ASDL (1000kb upstream and only about 200kb downstream for=
 you).
>=20
> My plans to improve include:
> - fix any error reported by the eventual users of the buildbot
> - fix some buildbot minor annoyance
>   a) may be a prettier stylesheet
>   b) use the names of the buildsteps as in=20
> http://ngiger.dyndns.org/buildbot/hcu3/builds/13 also in the main page)=

>=20
> - Handle correctly cases like changes in the xenomai repository which r=
equire=20
> new configs, new kernel or patch-versions
>=20
> - Not only compile xenomai but also actually run some tests to prove th=
e=20
> changes valid.=20

Yep, a very good idea as well. Regression tests, also in combination
with more complex applications on top of Xenomai (like RTnet ;): a
simple loopback ping test e.g.), would improve the code quality even
faster during the development cycles.

>   This will either require buildbot changes to add a step where one can=
 reboot=20
> a slave and run the next step with the new kernel (How to handle non-bo=
ots?)=20
> or=20
>   add a separate target board whose power supply can be switched off/on=
 by an=20
> external device. What I found are either=20
> I) Ethernet controlled power switch like
> http://info.infratec-ag.de/catalog/product_info.php?products_id=3D830&l=
anguage=3Den&osCsid=3Da3995263b1f1ca75af33fe9d0d5fa384=20
> or IO-devices, like the
> II) USB LabJack http://www.labjack.com/labjack_u12.html.
> Suggestions for a cheaper solution would be always welcome.

Is there no reset button you could control via a master station, e.g. by
attaching some cheap electronic to a parallel or serial port?

I just remember that DENX once had or still have a remote PPC test-lab
running. I CC'ed Wolfgang, maybe he could comment on this if and how it
could be used.

Jan


--------------enigA853C683A13D186F8C096234
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEN3fUniDOoMHTA+kRAo3qAKCCt8MLQTwo04OP0jBeYdKBDFKtgACfTgTN
SQdOHVvhchtFb4sLRaGiI3A=
=I/OV
-----END PGP SIGNATURE-----

--------------enigA853C683A13D186F8C096234--

