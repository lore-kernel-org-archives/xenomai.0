Message-ID: <4631E30B.6060701@domain.hid>
Date: Fri, 27 Apr 2007 13:48:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
In-Reply-To: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC6A3E66F467274E98AFF723"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC6A3E66F467274E98AFF723
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I am using kernel 2.6.20.4 and Xenomai 2.3.1 on a SMP enabled dual core=
 Pentium 4.
> Everything works fine when I do not enable the CONFIG_PCI_MSI (Messages=
 signaled interrupts) for
> PCI Express.
> As I am always short with interrupts I want to use MSI for the PCIe bas=
e
> I/O devices like Ethernet.
>=20
> When I run the same kernel without any Xenomai patch, it works really f=
ine.
> My onboard PCIe e1000 network adapter will be loaded fine and gets the =
(cool) interrupt number 219!
> Perfect!
>=20
> When I use the Adeos patch from Xenomai 2.3.1 on this kernel the modpro=
be of the e1000 driver
> leads to a kernel crash.
> At this stage no real time application is running.
> Using a serial console, I was able to log the kernel dump.
> Here it is:
>=20
> BUG: unable to handle
>  kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: e1000
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted VLI
> EFLAGS: 00010086   (2.6.20.4 #7)
> EIP is at _stext+0x3feffc70/0x14
> eax: c0112244   ebx: 00000006   ecx: c011434d   edx: c168c000
> esi: 00000006   edi: 00000046   ebp: ffffffff   esp: c168de20
> ds: 007b   es: 007b   ss: 0068
> Process ifconfig (pid: 1231, ti=3Dc168c000 task=3Dc1692a90 task.ti=3Dc1=
68c000)
> Stack: c03e5680 000000db 00000000 c03d9100 c010ef83 00006d80 00000001 0=
0000060
>        e099a210 00000286 ffffff24 df77b5c8 00000000 0000000f 00000001 c=
0103439
>        df77b5c8 e099a0ff e09c0000 00000000 0000000f 00000001 80080740 d=
fd2007b
> Call Trace:
>  [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0a1>] dev_mc_upload+0x24/0x37
>  [<c02db5ac>] dev_open+0x44/0x62
>  [<c02da079>] dev_change_flags+0x47/0xe4
>  [<c030d192>] devinet_ioctl+0x252/0x56f
>  [<c02db18a>] dev_ifsioc+0x113/0x38d
>  [<c02d15a4>] sock_ioctl+0x0/0x1ad
>  [<c02d1732>] sock_ioctl+0x18e/0x1ad
>  [<c02d15a4>] sock_ioctl+0x0/0x1ad
>  [<c015e18f>] do_ioctl+0x1f/0x62
>  [<c015e416>] vfs_ioctl+0x244/0x256
>  [<c015e45b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code:  Bad EIP value.
> EIP: [<00000000>] _stext+0x3feffc70/0x14 SS:ESP 0068:c168de20
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
>  [<c010b903>] smp_call_function+0x66/0x10a
>  [<c0118e12>] printk+0x62/0xd5
>  [<c010b9c2>] smp_send_stop+0x1b/0x2b
>  [<c01183ad>] panic+0x4d/0xe4
>  [<c0103f71>] die+0x1f2/0x226
>  [<c011167c>] do_page_fault+0x447/0x517
>  [<c010f61d>] __ipipe_handle_exception+0xce/0x158
>  [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
>  [<c033336d>] error_code+0x81/0x90
>  [<c011434d>] try_to_wake_up+0x33c/0x346
>  [<c0112244>] __activate_task+0x1c/0x29
>  [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0a1>] dev_mc_upload+0x24/0x37
>  [<c02db5ac>] dev_open+0x44/0x62
>  [<c02da079>] dev_change_flags+0x47/0xe4
>  [<c030d192>] devinet_ioctl+0x252/0x56f
>  [<c02db18a>] dev_ifsioc+0x113/0x38d
>  [<c02d15a4>] sock_ioctl+0x0/0x1ad
>  [<c02d1732>] sock_ioctl+0x18e/0x1ad
>  [<c02d15a4>] sock_ioctl+0x0/0x1ad
>  [<c015e18f>] do_ioctl+0x1f/0x62
>  [<c015e416>] vfs_ioctl+0x244/0x256
>  [<c015e45b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I have attached my kernel config to this mail.
> Any idea on this? Is there anybody out there that has MSI running succe=
sfully with the Xenomai adeos patch?

Hmm, from a glance at the 2.6.20 ipipe patch I would say that MSI is
currently unsupported. No related patch hunk makes it look suspicious to
me -- or is this supposed to work automagically, Philippe?

In the meantime, could you post me your vmlinux privately? When time
allows, I would like to disassemble __ipipe_handle_irq and maybe more.
Please also attach your .config.

Jan


--------------enigCC6A3E66F467274E98AFF723
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMeMMniDOoMHTA+kRAsOoAJ9oOyEXTyTR2w0C1Vrwa6pt2QZ/UQCfbbwB
aELufD0JnesKRGOwBfLYEgE=
=RocR
-----END PGP SIGNATURE-----

--------------enigCC6A3E66F467274E98AFF723--

