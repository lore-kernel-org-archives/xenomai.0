Message-ID: <457686F3.1080008@domain.hid>
Date: Wed, 06 Dec 2006 10:01:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4ABED13B6C6C3CEDD967DC3B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] How to hook genirq best
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4ABED13B6C6C3CEDD967DC3B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

in an earlier thread on I-pipe for 2.6.19-ppc from Xenomai-core,
Wolfgang remarked:
>>> Unfortunately, "generic" applies only to the Linux part. I
>>> realized, that the new IPIPE support for the genirqs requires
>>> even more arch-specific modifications than the old interface :-(
>>> on PowerPC.
>>=20
>> How comes? I haven't found time to analyse this for the latest x86=20
>> patch, but there it should be "more generic" than before. Do you
>> think this is a genirq issue or an I-pipe problem?
>=20
> Well, it's nothing serious and we should discuss this issue in a=20
> separated thread. I just wanted to have a closer look to the new port
>  before asking. At a first glance I saw that the irq_chip structure
> has two new elements, ipipe_ack and ipipe_eoi. This requires patching
> of every PIC interface. There are a few for x86 but plenty for
> PowerPC. Philippe, is this really necessary? I would prefer the old
> style using "#ifndef CONFIG_IPIPE" around the "chip->ack" in common
> code.

I had a look at the related part in 2.6.19-i386-1.6-01 meanwhile, and
there seems to be a concise pattern for the irq_chip changes:

=2Eipipe_ack =3D (.mask_ack) ? .mask_ack : .ack;
=2Eipipe_eoi =3D .eoi;

I agree with Wolfgang, these changes indeed require a lot of patching
already on x86 because often two versions of the irq_chip definition
have to be provided (and there is the risk to miss one as it currently
seems to be the case in visws_apic.c).

I must confess that I do not see the advantage of the approach to patch
the irq_chip definitions directly. Rather, one of the following ways
should scale better over a large number of irq_chips:

A) Perform patching during runtime when I-pipe is taking over the IRQs.
Should be a trivial loop over all IRQ descriptors. Either overwrite the
existing irq_chips (i.e. like sketched above) or provide new pseudo
irq_chip structures to Linux.

B) Patch the users of chip->ack/eoi/mask_ack or whatever. Given that
this should basically be confined to kernel/irq/chip.c, it looks
manageable too and would also avoid any useless runtime checks for NULL
handlers or even calling void functions.


Another topic is how to deal with pending IRQs. I haven't looked through
all cases yet, but already the fasteoi one seems to differ in I-pipe
when comparing to a similar situation in -rt: threaded IRQs. -rt ends
(eoi) and masks such IRQs that are about to be deferred to thread
context, I-pipe only ends them. Generally, the question remains for me
if at least IRQs arriving to a stalled I-pipe domain should always be
masked on ack and unmask when being replayed.

Jan


--------------enig4ABED13B6C6C3CEDD967DC3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFdobzniDOoMHTA+kRAqjOAJ4gUNDlnjLd+QJbvmCdnzlLSgyVwgCdEJ7p
d4NJL8RbN4FXHTXQbvEk6Zw=
=qXTm
-----END PGP SIGNATURE-----

--------------enig4ABED13B6C6C3CEDD967DC3B--

