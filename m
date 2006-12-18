Message-ID: <45868FFA.7000503@domain.hid>
Date: Mon, 18 Dec 2006 13:56:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtnet / Xenomai: Kernel 2.6.19.1 hangs,	2.6.17.7
	works
References: <26440461.1166445600596.JavaMail.ngmail@domain.hid>
In-Reply-To: <26440461.1166445600596.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5097683875658D5A93BCB987"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5097683875658D5A93BCB987
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi rtnet and Xenomai users,
>=20
> I have an issue with the latest Xenomai (svn #1962) and rtnet (svn #109=
5) versions
> using kernel 2.6.19.1. The very same application worked fine on 2.6.17.=
7 (same Xenomai/rtnet).

/Might/ be an issue of the still fresh 2.6.19 patch. You are using
latest ipipe 1.6-02? Any difference with an earlier version of the
patch? Is the IRQ routing identical for both 2.6.19 and .17?

> My application does the following steps in user space:
> 1) I open one UDP socket to an embedded device.
> 2) The timeout of the socket is set to 5 seconds.
> 3) I send out one UDP message A via rt_dev_send() to the device.
> 4) Then I wait for the response for A in rt_dev_recv()
> 5) Directly after the return of rt_dev_recv() I send  message B via rt_=
dev_send()
> 6) Then I wait for the response for B in rt_dev_recv()
> Here my PC freezes. I am no longer able to access it, I have to press t=
he reset button on the PC.
>=20
> I have connected the PC and the embedded device with a hub. This allows=
 me to monitor the network
> traffic using a second PC. Ethereal shows me, that message B is sent to=
 the embedded device
> and the response of B is sent back to the PC.
>=20
> Whenever I place a printf() directly after the rt_dev_recv() statements=
 to see what happens,
> everything works fine and the PC no longer freezes.

printf causes a mode switch and certainly some delay that may let the
system avoid the race situation above.

>=20
> As mentioned above, when I use the very same application with 2.6.17.7 =
(same Xenomai, rtnet version)
> everything is perfect!
> I have a Pentium 4 Dual core, SMP enabled.
>=20
> Any idea on this strange behaviour?

Not directly.

OK, this is what you could try: Switch on the Xenomai watchdogs (soft
and NMI). Check if the NMI watchdog is working: boot log messages, maybe
even a test triggering via small /proc/xenomai/nmi_maxlat (we had
problems with it already on some other user's box, so some confirmation
the NMI works is useful). Then see if you system can at least issue some
oops on lock-up. Attach a serial console to grab it.

Beyond this test, could you also try with CONFIG_SMP switched off?

Jan


--------------enig5097683875658D5A93BCB987
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFho/7niDOoMHTA+kRAoD7AJkBoVNi3bptOxUjKBZsTPi6w6UBkwCfcpF1
VtrqVFKI6Au0LhRVF0R1s7g=
=LXkL
-----END PGP SIGNATURE-----

--------------enig5097683875658D5A93BCB987--

