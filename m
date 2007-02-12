Message-ID: <45D05431.10409@domain.hid>
Date: Mon, 12 Feb 2007 12:49:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
References: <45CF951B.8080404@domain.hid>	<1171233732.5035.24.camel@domain.hid>	<17871.41373.425284.839228@domain.hid>	<1171237780.5035.30.camel@domain.hid>	<17871.45750.434103.944040@domain.hid>	<45CFB49F.1050000@domain.hid>
	<45CFBE7B.3050906@domain.hid>
In-Reply-To: <45CFBE7B.3050906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig830ED96081AF65B0F85A7397"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig830ED96081AF65B0F85A7397
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> 2.6.19 didn't magically start to work as well. Instead I have a back
> trace now, see attachment.
>=20
> I included a full set of 16k points, but the thrilling things are aroun=
d
> -73 to -25: Some Linux process with IRQs on gets preempted by an RT-IRQ=

> (RTnet NIC). That triggers an RT kernel thread to run for a while (RTne=
t
> stack manager, prio 98). But when returning to Linux again, its IRQs
> remain masked now. The reason must be that weird exception at -62. Don'=
t
> know where it comes from and why is there no report about THAT issue in=

> the kernel logs.

The cause of this page fault will get tracked down later today, but the
way it is handled already causes some doubts to me. To make discussion
easier, here is the relevant excerpt from the trace:

> :    +func                 -73+   1.426  link_path_walk+0x14 (__link_pa=
th_walk+0xca0)
> :|   +func                 -72    0.605  __ipipe_handle_irq+0x14 (commo=
n_interrupt+0x18)
> :|   +func                 -71    0.472  __ipipe_ack_irq+0x8 (__ipipe_h=
andle_irq+0xaf)
> :|   +func                 -70    0.224  __ipipe_ack_level_irq+0x12 (__=
ipipe_ack_irq+0x19)
> :|   +func                 -70+   4.424  mask_and_ack_8259A+0x14 (__ipi=
pe_ack_level_irq+0x22)
> :|   +func                 -66    0.475  __ipipe_dispatch_wired+0x14 (_=
_ipipe_handle_irq+0x62)
> :|  # func                 -65    0.974  xnintr_irq_handler+0xe (__ipip=
e_dispatch_wired+0x95)
> :|  # func                 -64+   1.892  rtl8139_interrupt+0x11 [rt_813=
9too] (xnintr_irq_handler+0x3b)
> :|  # func                 -62    0.382  __ipipe_handle_exception+0xe (=
error_code+0x3e)
> :|  # func                 -62    0.222  __ipipe_test_root+0x8 (__ipipe=
_handle_exception+0x1a)
> :|  # func                 -62    0.377  __ipipe_stall_root+0x8 (__ipip=
e_handle_exception+0x15b)
> :|  #*func                 -62    0.173  trace_hardirqs_off+0xc (__ipip=
e_handle_exception+0x165)
> :|  #*func                 -61    0.211  __ipipe_test_root+0x8 (trace_h=
ardirqs_off+0x2d)
> :|  #*func                 -61+   1.965  do_page_fault+0xe (__ipipe_han=
dle_exception+0x6d)
> :   #*func                 -59    0.180  trace_hardirqs_on+0x11 (__ipip=
e_handle_exception+0xd9)
> :   #*func                 -59    0.163  __ipipe_test_root+0x8 (trace_h=
ardirqs_on+0x5e)
> :   #*func                 -59    0.396  mark_held_locks+0xe (trace_har=
dirqs_on+0x8b)
> :   #*func                 -58    0.212  mark_held_locks+0xe (trace_har=
dirqs_on+0xc9)
> :   #*func                 -58    0.461  __ipipe_restore_root+0x8 (__ip=
ipe_handle_exception+0xe1)
> :   #*func                 -58    0.253  __ipipe_unstall_root+0x8 (__ip=
ipe_restore_root+0x18)
> :   # func                 -57    0.224  __ipipe_stall_root+0x8 (ret_fr=
om_exception+0x5)
> :   #*func                 -57    0.366  trace_hardirqs_off+0xc (ret_fr=
om_exception+0xe)
> :   #*func                 -57    0.327  __ipipe_test_root+0x8 (trace_h=
ardirqs_off+0x2d)
> :|  #*func                 -57+   2.089  __ipipe_unstall_iret_root+0x8 =
(restore_nocheck_notrace+0x0)
> :|  #*func                 -54+   1.444  alloc_rtskb+0xa [rtnet] (rtl81=
39_interrupt+0x182 [rt_8139too])
> :|  #*func                 -53+   1.172  rt_eth_type_trans+0xe [rtnet] =
(rtl8139_interrupt+0x1d6 [rt_8139too])=20

The fault gets forwarded to Linux because ipipe_trap_notify doesn't
choke: we are neither running over a task with PF_EVNOTIFY set nor over
a kernel thread yet (IPIPE_NOSTACK_FLAG). Still, we are already in
primary domain, so I wonder if this forwarding is intentional. At least
it seems to break some things later on...

Jan


--------------enig830ED96081AF65B0F85A7397
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0FQxniDOoMHTA+kRArNnAJ9J0S7sZLIH6Y3VxTvrJGlaq6gD7ACdGnol
9C++qVnYv4GisRcyTWK31I8=
=u4Ic
-----END PGP SIGNATURE-----

--------------enig830ED96081AF65B0F85A7397--

