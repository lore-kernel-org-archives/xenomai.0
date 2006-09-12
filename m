Message-ID: <4506EC10.1010807@domain.hid>
Date: Tue, 12 Sep 2006 19:19:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Bad EIP kernel-Oops
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
In-Reply-To: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig323FAE4CA147D6573991FE04"
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
To: nils.kemper@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig323FAE4CA147D6573991FE04
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nils Kemper wrote:
> Hi,
> I want to use Xenomai, but I get (sometimes, but everytime the same)
> kernel-Oops just by running xeno-test:
>=20
> [..]
> Xenomai: stopping native API services.
> I-pipe: Domain Xenomai unregistered.
> Xenomai: hal/x86 stopped.
> Xenomai: real-time nucleus unloaded.
>  Unable to handle kernel NULL pointer dereference at virtual address 00=
000000
>  printing eip:
>  00000000
>  *pde =3D 00000000
>  Oops: 0000 [#1]
>  PREEMPT
>  Modules linked in: netconsole 8139too crc32 ipv6 nfs lockd sunrpc
> intel_agp ehci_hcd uhci_hcd usbcore i810_audio ac97_codec soundcore 3c5=
9x
> mii agpgart
>  CPU:    0
>  EIP:    0060:[<00000000>]    Not tainted VLI
>  EFLAGS: 00010246   (2.6.16.27n-xeno222 #7)
>  EIP is at rest_init+0x3feffde0/0x63
>  eax: c030ba80   ebx: c030ba80   ecx: 00000002   edx: 00000003
>  esi: c030ba80   edi: 00000246   ebp: 00000021   esp: cc1bbf80
>  ds: 007b   es: 007b   ss: 0068
>  Process dd (pid: 11490, threadinfo=3Dcc1ba000 task=3Dd56f8a70)
>  Stack: <0>c013f158 00000021 c030ba80 cc1bbfbc 00000001 c0314408 c030ba=
80
> cc1bbfbc
>         00000000 00000200 08051000 cc1ba000 c0111c3d 00000000 c0102ec6
> 00000000
>         08051000 00000200 00000200 08051000 bfda2568 00000003 0000007b
> 0000007b
>  Call Trace:
>         [<c013f158>] __ipipe_dispatch_event+0xcd/0xeb
>         [<c0111c3d>] __ipipe_syscall_root+0x2f/0xd8
>         [<c0102ec6>] sysenter_past_esp+0x3b/0x67
>  Code:  Bad EIP value.
>  <4>I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.2.2 (Ride) loaded.
> Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> [..]
>=20
> I'm sure somthing is wrong with my kernel-config, so I have attached it=
,
> together with the xeno-test-output.
> BTW: I tried noapic, acpi=3Doff with no success.

Looks like a cleanup race in the nucleus unloading code. I just got it
here as well after adoption to your .config (all modularised,
CONFIG_PREEMPT). It basically seems to melt down to having high syscall
load (e.g. dd if=3D/dev/zero of=3D/dev/null) during nucleus unload.

Unless someone around immediately has an idea why some syscall traps
onto a NULL pointer (or something else - I had non-NULL address here), I
would try to get this over a debugging environment "later". Hope the bug
is not too volatile...

Thanks for reporting so precisely!

Jan


--------------enig323FAE4CA147D6573991FE04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBuwQniDOoMHTA+kRAthwAJ44D5CrPSrCbbDLYrRG8ADs6p0CYQCfUxyE
YXWizEeP06J0V7eqpPGHz7I=
=LXjb
-----END PGP SIGNATURE-----

--------------enig323FAE4CA147D6573991FE04--

