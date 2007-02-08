Message-ID: <45CB4291.408@domain.hid>
Date: Thu, 08 Feb 2007 16:32:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>	
	<17864.63903.244809.994959@domain.hid>	
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>	
	<45C9B7C4.8050705@domain.hid>
	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>
In-Reply-To: <cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig46DBFCE9659BAA55006E850A"
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46DBFCE9659BAA55006E850A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> 2007/2/7, Jan Kiszka <jan.kiszka@domain.hid>:
>>
>> Your /proc/interrupts output already suggests it: CONFIG_PCI_MSI is se=
t
>> in your config. It's worth trying the disable it, because even plain
>> Linux has problems with certain board/device combinations. But I don't=

>> recall if tg3 was recently involved in such, it may still be an ipipe
>> bug here.
>=20
> The same xenomai patched kernel with CONFIG_PCI_MSI disable
> boots fine with following /proc/interrupt:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>           CPU0       CPU1
>  0:    2169593          0   IO-APIC-edge      timer, rthal_broadcast_ti=
mer
>  1:          2          0   IO-APIC-edge      i8042
>  2:          0          0    XT-PIC-XT        cascade
>  8:          1          0   IO-APIC-edge      rtc
> 12:          4          0   IO-APIC-edge      i8042
> 14:      18945          0   IO-APIC-edge      ide0
> 16:      26920          0   IO-APIC-fasteoi   eth0, eth1
> 20:      12861          0   IO-APIC-fasteoi   uhci_hcd:usb1,
> ehci_hcd:usb4, libata
> 21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
> 22:      10967          0   IO-APIC-fasteoi   uhci_hcd:usb3
> NMI:          0          0
> LOC:    2169430    2169431
> ERR:          0
> MIS:          0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The former kernel used with kernel boot parameter "nomsi" continues
> to hang despite the boot parameter for "nomsi".
> I did go back to http://www.xenomai.org/index.php/FAQs
> and saw informations about SMI
> "On some systems, SMI may be involved in thermal throttling of the
> CPU. Thus, switching it off can cause hardware damage in overheat
> scenarios."
>=20
> Now I'm lost with those 3 letters acronyms :((
> Does SMI has something to do with MSI or not?

You can form both acronyms using the same set of letters, that's all.

>=20
> In both cases (SMI related to MSI or not)
> How can I know if SMI is used for thermal throttling on my box?

Unless you over-clock your system, or save cooling equipment, there is
practically no problem. AFAIK, no one experienced damage from overheat
so far while SMI was disabled. Still there is a theoretical risk,
therefore we warn.

>=20
> I have the same boot problem with cpus=3D1 and the first kenrel (SMI en=
abled)
> (the box hangs on ifup eth0).
>=20
> Now with the "bootable" xenomai-kernel config
> I go on and give a try to launch xeno-test (with no option at all),
> and it hangs the box the near the:
> "cat /proc/xenomai/rtdm/protocol_devices"
> message

Sounds like !MSI just moves the bug around.

>=20
> Where should I look in order to  investigate this hang.
>=20
> I attached the .config corresponding to bootable but hangable kernel.

Can you attach a serial console to your system (see
linux/Documentation/serial-console.txt) and grab the full kernel log up
to the hang? Maybe we have an oops that just cannot come out anymore.
Even if not, you could then try to instrument (printk) the kernel
towards the faulting lines.

Jan


--------------enig46DBFCE9659BAA55006E850A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFy0KRniDOoMHTA+kRAmmmAJ9FsDX0MzcF0/NBTo5h3scFvygGlwCdEzTi
/UTiK2XNNIsI1GqdPWCgu18=
=y5Rh
-----END PGP SIGNATURE-----

--------------enig46DBFCE9659BAA55006E850A--

