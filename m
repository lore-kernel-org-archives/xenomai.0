Message-ID: <45D5739B.5030507@domain.hid>
Date: Fri, 16 Feb 2007 10:04:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sharing interrupts between several RT pci devices
	and non RT devices
References: <20070216081932.323430@domain.hid>
In-Reply-To: <20070216081932.323430@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0035E887728A2B3D12A14034"
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
To: Steffen Mehlfeld <S.Mehlfeld@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0035E887728A2B3D12A14034
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steffen Mehlfeld wrote:
> Hi,
>=20
> I'm trying to run several pci cards in rt mode. Therefore I call rtdm_i=
rq_request() with the flags XN_ISR_SHARED | XN_ISR_EDGE.=20

For the sake of cleanness: XN_xxx flags are for internal use only (skins
like RTDM do so), you are expected to work with RTDM_IRQTYPE_xxx here.

>=20
> In the ISR I check the interrupt status register of the pci-card. If th=
e irq was caused by that card, i handle it and return RTDM_IRQ_HANDLED. I=
f not, I return XN_ISR_NONE, which I understand means 'not my interrupt, =
try the next registered ISR'.

Yep.

>=20
> This works fine as long as my pci-cards have their own interrupt line. =
But when the PCI-BIOS let them share the interrupt line with something li=
ke the ethernet-card (which runs in non-rt mode) the problems starts. Of =
course the ethernet-card gets no more interrupts and stops working.
>=20
> To solve this I'd have to propagate the irq to the linux domain, when i=
 figure out that the irq wasn't called by one of my cards (i can detect t=
his with global flags in the kernel module).
> But as soon as i start returning XN_ISR_PROPAGATE from the isr, i get t=
he message "Xenomai: xnintr_edge_shirq_handler(): failed to get the IRQ9 =
line free.", which i think doesn't mean, that all is going well.=20

Yes, because the IRQ line is still high, and that must not be the case
after all RT handlers were executed.

>=20
> The api documentation tells not to return XN_ISR_PROPAGATE if you share=
 irqs amongst rt devices, which i think is reasonable if you don't know, =
wether all rt-devices already checked their ir-flags.=20
> But isn't there a way to propagate the irq to linux, if i'm sure that i=
t belongs there?

There used to be a wrapper for XN_ISR_PROPAGATE in earlier RTDM (again:
don't use XN-flags...), but we removed it because there is not sane way
that this cross-domain sharing would work deterministically.

Reason: When you propagate the line release to Linux, you throw away any
temporal predictability of your RT driver's IRQ handling. When will
Linux execute the non-RT handler so that the RT driver can receive new
IRQs again? No one knows...

>=20
> Another solution would be not to share interrupts between rt and non-rt=
-devices, but i have no clue how to do this, as i'm new to the whole driv=
er development thing. As far as i understand, the PCI-BIOS tells each dev=
ice via config-space which irq it has to use. Therefore it's pointless to=
 call rtdm_irq_request() with a irq-line other than that from config-spac=
e, as it uses the irq from config-space anyway.=20
> Is there a way to specify which irq a pci device should use?

If the physical IRQs end up on the same line physical line, you have
lost. Then you can only write a special stub driver for your non-RT
device, that works over RTDM, detects if the event is for that device,
shuts the IRQ up inside the hardware (there is always some kind of mask
register), and signals the arrival e.g. via rtdm_nrtsig to the Linux
handler. When Linux is able to execute its driver, it can analyse the
IRQ reason and take the measures to finally re-enable IRQs on that
device again.

That's of course still slower than an unshared IRQ design, but it is
deterministic even when you face an unpredictable non-RT IRQ load.

Jan


--------------enig0035E887728A2B3D12A14034
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1XOeniDOoMHTA+kRArddAJ40d77USH2mCUu2RihpFKacVfXBbwCeJ56U
yTjb8YNNcUdztZPZwVIQ5SU=
=QIAw
-----END PGP SIGNATURE-----

--------------enig0035E887728A2B3D12A14034--

