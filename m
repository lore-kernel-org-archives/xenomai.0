Message-ID: <465099CE.2010004@domain.hid>
Date: Sun, 20 May 2007 20:56:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0D9B57E78B2A561E34E098E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] module_put called over non-root domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0D9B57E78B2A561E34E098E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just ran into this with CONFIG_IPIPE_DEBUG_CONTEXT (maybe due to some
bug of my own):

[  102.616000] I-pipe: Detected illicit call from domain 'Xenomai'
[  102.616000]         into a service reserved for domain 'Linux' and bel=
ow.
[  102.616000]        c741bdc8 00000000 00000000 c8860ef8 c741bdec c01056=
83 c032c200 c13fe22c
[  102.616000]        c0361f00 c741be08 c01519ed c032f5b8 c032c742 c03380=
b3 c8885100 c78beac0
[  102.616000]        c741be14 c0142ce9 c7a80b30 c741be3c c884d075 c885f1=
50 c8860ef8 c741be3c
[  102.616000] Call Trace:
[  102.616000]  [<c0104d9f>] show_trace_log_lvl+0x1f/0x40
[  102.616000]  [<c0104e71>] show_stack_log_lvl+0xb1/0xe0
[  102.616000]  [<c0105683>] show_stack+0x33/0x40
[  102.616000]  [<c01519ed>] ipipe_check_context+0xad/0xc0
[  102.616000]  [<c0142ce9>] module_put+0x19/0x90
[  102.616000]  [<c884d075>] xnshadow_unmap+0xb5/0x130 [xeno_nucleus]
[  102.616000]  [<c8871dc5>] __shadow_delete_hook+0x25/0x30 [xeno_native]=

[  102.616000]  [<c8842f78>] xnpod_schedule+0xb58/0x12f0 [xeno_nucleus]
[  102.616000]  [<c8844bfb>] xnpod_delete_thread+0x2cb/0x3d0 [xeno_nucleu=
s]
[  102.616000]  [<c886f5bd>] rt_task_delete+0x20d/0x220 [xeno_native]

I would dare to say that module_put in xnshadow_unmap is not well placed
as it can wakeup a Linux process. The module ref-counter maintenance
needs some postponing, I guess.

Jan


--------------enigC0D9B57E78B2A561E34E098E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGUJnSniDOoMHTA+kRAl9kAJ4qBSlrsqdoLsJrDBeA+9QYuluciwCfQPte
U0+z/ydjSMBlUpRYUdhqXOI=
=i7Ev
-----END PGP SIGNATURE-----

--------------enigC0D9B57E78B2A561E34E098E--

