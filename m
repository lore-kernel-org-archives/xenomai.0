Message-ID: <49F016B2.8040709@domain.hid>
Date: Thu, 23 Apr 2009 09:20:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49EF0CFE.90405@domain.hid> <1240417384.6987.8.camel@domain.hid>
	<49EF4A6A.4010604@domain.hid>
In-Reply-To: <49EF4A6A.4010604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9393CA496A4733970019712C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] BUG on xnintr_attach
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9393CA496A4733970019712C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2009-04-22 at 14:26 +0200, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> issuing  rtdm_irq_request and, thus, xnintr_attach can trigger a
>>> "I-pipe: Detected stalled topmost domain, probably caused by a bug." =
if
>>> the interrupt type is MSI:
>>>
>>>   [<ffffffff80273cce>] ipipe_check_context+0xe7/0xe9
>>>   [<ffffffff8049dae9>] _spin_lock_irqsave+0x18/0x54
>>>   [<ffffffff8037dcc2>] pci_bus_read_config_dword+0x3c/0x87
>>>   [<ffffffff80387c1d>] read_msi_msg+0x61/0xe1
>>>   [<ffffffff8021c5b8>] ? assign_irq_vector+0x3e/0x49
>>>   [<ffffffff8021d7b2>] set_msi_irq_affinity+0x6d/0xc8
>>>   [<ffffffff8021fa5d>] __ipipe_set_irq_affinity+0x6c/0x77
>>>   [<ffffffff80274231>] ipipe_set_irq_affinity+0x34/0x3d
>>>   [<ffffffff8027c572>] xnintr_attach+0xaa/0x11e
>>>
>>> Two option to fix this, but I'm currently undecided which one to go:
>>>  - harden pci_lock (drivers/pci/access.c) - didn't we applied such a
>>>    MSI-related workaround before?
>> This did not work as expected: pathological latency spots. This said,
>> the vanilla code has evolved since I tried this quick hack months ago,=

>> so it may be worth to look at this option once again.
>>
>>>  - move xnarch_set_irq_affinity out of intrlock (but couldn't we face=

>>>    even more pci_lock related issues?)
>>>
>> Since upstream decided to use PCI config reads even inside hot paths
>> when processing MSI interrupts, the only sane way would be to make the=

>> locking used there Adeos-aware, likely virtualizing the interrupt mask=
=2E
>> The way upstream generally deals with MSI is currently a problem for u=
s.
>=20
> Hmm, guess this needs a closer look again. But I vaguely recall upstrea=
m
> had removed the config reading at least from the hot paths due to
> complaints about performance.

I went through the critical MSI code paths again. Its irqchip comes with
ack, mask/unmask and set_affinity which may be used by Xenomai. The ack
is most important as it runs during early dispatching, but it maps to
ack_apic_edge, thus is clean. The rest is contaminated with PCI config
access.

At least pci_lock is involved for this, depending on the PCI access
method, also pci_config_lock. And then there are other code paths that
call wake_up_all while holding pci_lock. This locks more or less hopeless=
=2E

On the other hand, we shouldn't depend on mask/unmask or set_affinity
while in critical Xenomai/I-pipe code paths. The MSI interrupt flow is
the same as for edge-triggered (except that there is even no EIO). That
means we do not mask deferred interrupts. And that means we should be
safe once the affinity setting is fixed.

Jan


--------------enig9393CA496A4733970019712C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknwFrcACgkQniDOoMHTA+n9igCdEo3VWVHYJbGeLTZZBLnt7Pjk
RmkAn2xstnSpa3Zu8sBm5Gn2U+FfWJeo
=pjJ/
-----END PGP SIGNATURE-----

--------------enig9393CA496A4733970019712C--

