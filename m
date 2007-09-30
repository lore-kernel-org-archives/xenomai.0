Message-ID: <46FFC58E.1030700@domain.hid>
Date: Sun, 30 Sep 2007 17:49:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <db67beef0709261544q2e6e454wf07ccacd4f77f1e4@domain.hid>
In-Reply-To: <db67beef0709261544q2e6e454wf07ccacd4f77f1e4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC79C90F5FC7FEE711BEFF69B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Shared interrupt :(
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: bite <anonimo.passante@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC79C90F5FC7FEE711BEFF69B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

bite wrote:
> Hi, this is my first post, I'm using Xenomai since a few days, I beg yo=
ur
> pardon if my question has already been answered.
>=20
> My problem is not directly related to Xenomai, but it prevents me from =
using
> Xenomai (as well as any other kind of realtime extension, I think).
>=20
> The point is: I have a PCI axis control board and with Xenomai I can us=
e it
> well on some kind of hardware.
>=20
> On a different machine, the irq of this board happens to be shared with=
 an
> usb irq, and I get lots of problems there. Erratic behaviour, pc hangin=
g and
> killed cats.
>=20
> Things do not change if I include I_PROPAGATE in the interrupt mode fla=
gs.
>=20
> I recompiled the kernel with IO_APIC and LOCAL_APIC set, but what happe=
ns
> then is just that the conflicting interrupts both move together, hand i=
n
> hand, from the same irq 9 to the same irq 18 :) Shame!
>=20
> Is there any known solution for this embarrassing problem? Somebody
> suggested me to put the board in a different PCI slot, but unluckily I
> cannot do so because of a geometric constraint.

This is really a FAQ in this list, and if I weren't too busy, I would
now take the chance and hack up a wiki page on this. Please browse the
mailing list archives for the shared irq topic. And if you (anyone else
is invited as well) would like to do us a favour, put what you find into
a new wiki FAQ page on xenomai.org so that we can simply cite it on
future postings like this. :)

Jan

PS: If you stumble over the RT-IRQ-stub-for-Linux-devices approach in
the archive: I have some idea to ease the development, but it is stalled
due the limited time to work it out. If you feel like you need such a
stub, I can tell you more, just ask again.


--------------enigC79C90F5FC7FEE711BEFF69B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/8WOniDOoMHTA+kRAkN7AKCE41g0Pek/1DhvhD2+FQYliCMY7wCdF2qC
xa1zfF2oz+QSTeLvirL4Kfo=
=T0zs
-----END PGP SIGNATURE-----

--------------enigC79C90F5FC7FEE711BEFF69B--

