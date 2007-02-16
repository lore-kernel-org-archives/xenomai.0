Message-ID: <45D5EC76.6020405@domain.hid>
Date: Fri, 16 Feb 2007 18:40:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sharing interrupts between several RT pci devices
	and non RT devices
References: <20070216081932.323430@domain.hid> <45D5739B.5030507@domain.hid>
	<20070216130634.216140@domain.hid>
In-Reply-To: <20070216130634.216140@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDA145C0FFF05A41E5C8E6609"
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
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA145C0FFF05A41E5C8E6609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steffen Mehlfeld wrote:
> Jan Kiszka wrote:
>=20
>> For the sake of cleanness: XN_xxx flags are for internal use only (ski=
ns
>> like RTDM do so), you are expected to work with RTDM_IRQTYPE_xxx here.=

>=20
> done so.
>=20
>>> Another solution would be not to share interrupts between rt and
>> non-rt-devices, but i have no clue how to do this, as i'm new to the w=
hole driver
>> development thing. As far as i understand, the PCI-BIOS tells each dev=
ice
>> via config-space which irq it has to use. Therefore it's pointless to =
call
>> rtdm_irq_request() with a irq-line other than that from config-space, =
as it
>> uses the irq from config-space anyway.=20
>>> Is there a way to specify which irq a pci device should use?
>> If the physical IRQs end up on the same line physical line, you have
>> lost. Then you can only write a special stub driver for your non-RT
>> device, that works over RTDM, detects if the event is for that device,=

>> shuts the IRQ up inside the hardware (there is always some kind of mas=
k
>> register), and signals the arrival e.g. via rtdm_nrtsig to the Linux
>> handler. When Linux is able to execute its driver, it can analyse the
>> IRQ reason and take the measures to finally re-enable IRQs on that
>> device again.
>>
>> That's of course still slower than an unshared IRQ design, but it is
>> deterministic even when you face an unpredictable non-RT IRQ load.
>=20
> That won't work for me, because the cards are supposed to run on lots o=
f different machines, with lots of different devices and therefore device=
-drivers that may share the irq-line with this rt-device.

Sounds a bit like "dynamic RT-system configuration" - scary. ;)

>=20
> On my development machine, the cards irq-line depends on the presence o=
f other pci-cards, on the used pci-slot and some other parameters i can't=
 figure out (sometimes it's on 9, 10, 11, ...).=20

The line is the physical trace on the board or in the chipset. What you
first of all see are moving numbers for your IRQs. But do the sharing
change as well unpredictably? Typically, there are fixed assignments
between PCI slots and lines.

>=20
> Is there no known way how to influence this (maybe via config-space)?

None I'm aware of. Some people reported BIOS options on the IRQ mapping,
but I never saw such thing. Normally, only flipping PCI cards or
disabling devices (or not using them) helps to get a line physically free=
=2E

Jan


--------------enigDA145C0FFF05A41E5C8E6609
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1ex2niDOoMHTA+kRAg2/AJ9a+Hmpf+k9cNo3HlGI6/+Jd2SbEgCePO3q
xQb797FtCD6QYwijYKXBLwk=
=caeu
-----END PGP SIGNATURE-----

--------------enigDA145C0FFF05A41E5C8E6609--

