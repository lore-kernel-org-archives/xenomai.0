Date: Tue, 18 Apr 2006 17:35:08 +0200
From: Luotao Fu <l.fu@domain.hid>
Subject: Re: [Xenomai-help] strangeness at kernel configuration
Message-ID: <20060418153508.GB4482@domain.hid>
References: <20060418144146.GA4482@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20060418144146.GA4482@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

seemed that I'm getting Kerneloops trying loading rtdm drivers:
This is what I see while trying to load the timerbench driver.=20

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0155ad2
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: xeno_timerbench nfs lockd sunrpc uhci_hcd usbcore 8139to=
o mii
CPU:    0
EIP:    0060:[<c0155ad2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16xeno.svn #2)
EIP is at rtdm_dev_register+0x238/0x408
eax: 00000000   ebx: 00000013   ecx: 00000000   edx: d0839738
esi: 00000000   edi: d0839720   ebp: ce30df88   esp: ce30df74
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2731, threadinfo=3Dce30c000 task=3Dcfe03050)
Stack: <0>d0839800 00000000 d0839800 08053ef8 08053ef8 ce30dfa4 d083b024 d0=
839720
       d083972c 0000001f d0838dc5 00000000 ce30dfb4 c012ff3a b7df5000 08053=
ef8
       ce30c000 c010286a b7df5000 0002ebff 08053ef8 08053ef8 08053ef8 bfd77=
c48
Call Trace:
 [<c0103793>] show_stack_log_lvl+0xad/0xb5
 [<c01038ef>] show_registers+0x127/0x190
 [<c0103ad6>] die+0x106/0x1bc
 [<c010f299>] do_page_fault+0x384/0x4ad
 [<c010cd20>] __ipipe_handle_exception+0x69/0x95
 [<c01033c0>] error_code+0x54/0x64
 [<d083b024>] init_module+0x24/0x26 [xeno_timerbench]
 [<c012ff3a>] sys_init_module+0xb5/0x22b
 [<c010286a>] sysenter_past_esp+0x63/0x67
Code: 35 bc 70 3b c0 83 c2 0c bb 1f 00 00 00 80 7f 0c 00 74 0e 0f be 02 42 =
01 c1 4b 74 05 80 3a 00 75 f2 a1 b4 70 3b c0 21 f1 89 4d f0 <8b> 0c c8 8b 1=
1 0f 18 02 90 8b 75 f0 8d 04 f0 39 c1 74 3d 8b 5d


This really confuses me, especially I compiled now the Kernel with a config=
 file=20
out of my archvie which worked fine with 2.6.15 and ipipe-1.2*, Anybody an =
Idea for this?

Thanx again
cheers
Luotao Fu

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFERQcsiruQY+UyUmERAkgWAKClp4t5ADDmHvLwSmXEFh7QA4vCNACfVkU3
s0vfg4pA29ZvvXRhOh6zwjo=
=gigG
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

