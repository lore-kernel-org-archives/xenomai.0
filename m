Message-ID: <45FD13D5.7010704@domain.hid>
Date: Sun, 18 Mar 2007 11:26:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: xnintr_irq_handler: IRQ0 not handled.
	Disabling IRQ line.
References: <45F6C586.2050808@domain.hid>
In-Reply-To: <45F6C586.2050808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0B88A782F7496CC0A9D2B1E"
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
To: Edouard TISSERANT <edouard.tisserant@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0B88A782F7496CC0A9D2B1E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Edouard TISSERANT wrote:
> Hi all.
>=20
> I'm trying to implement support for the CAN PCMCIA Peak card with
> Xenomai in official Peak driver.
>=20
> First, I would like to know if someone already got success in writing
> some Xenomai IRQ handler for some PCMCIA devices. Is that a nonsense ? =
I
> believe I'm missing something in the way PCMCIA socket controller
> handles interrupts, linux side.
>=20
> I can observe on my laptop that PCMCIA socket controller IRQ and card
> IRQ do not conflict :
>=20
> ----------------------
> cat /proc/interrupts
>           CPU0
>  0:     163304   IO-APIC-edge      timer, rthal_broadcast_timer
>  1:        178   IO-APIC-edge      i8042
>  8:          2   IO-APIC-edge      rtc
>  9:         72   IO-APIC-fasteoi   acpi
> 12:        124   IO-APIC-edge      i8042
> 14:      13347   IO-APIC-edge      ide0
> 17:      36411   IO-APIC-fasteoi   uhci_hcd:usb5, HDA Intel, eth0
> 18:          1   IO-APIC-fasteoi   uhci_hcd:usb4, yenta
> 19:          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
> 20:          0   IO-APIC-fasteoi   uhci_hcd:usb3
> [...]
>=20
> ----------------------
> cat /proc/pcan
>=20
> *------------ PEAK-Systems CAN interfaces (www.peak-system.com)
> -------------
> *--------------------------  Release_20070306_n=20
> ----------------------------
> *------------------- [mod] [isa] [pci] [dng] [pcc] [rt]
> ---------------------
> *--------------------- 2 interfaces @ major 000 found
> -----------------------
> *n -type- ndev --base-- irq --btr- --read-- --write- --irqs-- -errors-
> status
> 40 pccard -NA- 00002100 003 0x001c 00000000 00000000 00000000 00000000
> 0x0000
> 41 pccard -NA- 00002120 003 0x001c 00000000 00000000 00000000 00000000
> 0x0000
> ----------------------
>=20
> In other worlds, PCMCIA subsystem claims that device IRQ is #3.
>=20
> When registering interrupt, I get this message :
>=20
> Xenomai: xnintr_irq_handler: IRQ0 not handled. Disabling IRQ line.

IRQ0 is weird. Are you sure you are registering the IRQ with RTDM while
providing the right number? What does /proc/xenomai/irq tell you?

>=20
> Handler looses more than 90% of #3 IRQ's.
>=20
> Any experience about PCMCIA/Xenomai would be welcome.

There is an RT-WLAN driver for an Asus PCMCIA adapter in RTnet. It's
experimental, but not due to PCMCIA, and I've personally seen it working.=


Jan


PS: At this chance, any plans to contribute PCMCIA support for PEAK
hardware to the standard CAN stack of Xenomai? There was already some
interest in such an alternative to the parport dongle e.g. The missing
piece (driver code) should be small and easily derivable from existing
SJA1000 adapter drivers.


--------------enigE0B88A782F7496CC0A9D2B1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/RPVniDOoMHTA+kRAhQwAJ9HH7mf3G5kB2HzG9xYF+EdAj06OgCfZZKi
23cT+anFGhEvK3BYPwh62jo=
=zIun
-----END PGP SIGNATURE-----

--------------enigE0B88A782F7496CC0A9D2B1E--

