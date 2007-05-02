Message-ID: <46389325.7080200@domain.hid>
Date: Wed, 02 May 2007 15:33:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46388DCC.5070303@domain.hid>
In-Reply-To: <46388DCC.5070303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB2B3F413FE9634D7677E4D55"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] HELP!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB2B3F413FE9634D7677E4D55
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
> Sorry about the subject but I badly need some advice.
>=20
> I have tried 2 different makes of remote IO over CAN to achieve my 1ms
> control loop. The makes are WAGO and Schleicher. These are industrial
> modules that link to buscouplers (in my case CAN) and make the IO
> available to andy device that can talk CAN. In this case my xenomai'd P=
C
> platform.
>=20
> However both makes (and all others I have contacted) have bus couplers
> which are too slow to achieve this. 5ms is about the best they can do.
> The engineering departments (who were not aware of this restriction)
> agree that it is not a fundamental CAN problem but a matter of their
> hardware not being able to respond fast enough.
>=20
> I have given up hope of finding suppliers who can supply industrial (th=
e
> latter is important) equipment that will give me what I am looking for
> based on CAN. So I am willing to settle on another bus protocol (I will=

> still be using CAN for other sensors which are responding fast enough o=
n
> CAN) for the remote IO.
>=20
> Can anyone tell me what companies can supply remote IO that is fast eno=
ugh.

Vendor: Hey, CAN is slow anyway, why should _we_ hurry? ;)

(Can't help, sorry)

>=20
> Can anyone comment on the use of RTNET (real time ethernet I believe)
> with xenomai. I ahve not seen any evidence of it being alove on this
> mailing list.
>=20

Maybe you missed the separated lists? rtnet-user-at-lists.sourceforge.net=


But note in advance that RTnet for I/O coupling requires RTnet I/O
coupler that you cannot buy as there are no commercial ones. You would
have to embed it on your own. Maybe you then rather want to use the
Ethercat MasterLibrary with RTnet to attach Ethercat I/O nodes.

Jan


--------------enigB2B3F413FE9634D7677E4D55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOJMlniDOoMHTA+kRAhpuAJkB+PiEthlLe0yxcCq7em0USn8DMQCeKQiv
Qp2bgLRvO2N2hOa6iInL4vs=
=IY1n
-----END PGP SIGNATURE-----

--------------enigB2B3F413FE9634D7677E4D55--

