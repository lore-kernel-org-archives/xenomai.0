Message-ID: <458AADEE.6070005@domain.hid>
Date: Thu, 21 Dec 2006 16:53:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] please i need help for rt_intr_create() fails
References: <16509.54449.qm@domain.hid>
In-Reply-To: <16509.54449.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig134BC7555548C5C02FAFF351"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig134BC7555548C5C02FAFF351
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi all
> i am trying to create a user space parallel port interrupt but the prob=
lem is that   err=3Drt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTO=
ENA);
>=20
> returns -22 instead of zero which means success.i dont have idea what t=
his error code  -22 means.please help me in this regard.i am attaching th=
e sample code.If some one can send me some basic working user space xenom=
ai  code i would be  very thankful.Thanks,

Your test loads fine for me over latest Xenomai (but I see no reason why
older versions should fail). Maybe your kernel/userspace pair is out of
sync.

If the problem persists, add some printk into the path the
rt_intr_create syscall takes. Start here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/sysca=
ll.c#3066

Jan


--------------enig134BC7555548C5C02FAFF351
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiq3uniDOoMHTA+kRAjDHAJ4jGcLaN6xXGhMGeXkfM/aL2pFdpACcDstv
RrFjpMaiTuy9RDp8VB2kuT4=
=bTuz
-----END PGP SIGNATURE-----

--------------enig134BC7555548C5C02FAFF351--

