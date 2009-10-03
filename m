Message-ID: <4AC77260.9090800@domain.hid>
Date: Sat, 03 Oct 2009 17:48:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <021401ca40ef$f0503470$d0f09d50$@biz>
In-Reply-To: <021401ca40ef$f0503470$d0f09d50$@biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig64F8B47C56CD8712494D645B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel panic on reboot (Xenomai 2.4.9.1,
 kernel 2.6.31, x86 SMP)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Stocks <rjs@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64F8B47C56CD8712494D645B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rob Stocks wrote:
> We have a problem with Xenomai v2.4.9.1, kernel 2.6.31, x86 SMP in that=
 we
> get a kernel panic on reboot:
>=20
> 	swapper[0]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
> 	no vm86_info: BAD
> 	Kernel panic - not syncing: Attempted to kill the idle task!
> 	Pis: 0, comm.: swapper Not tainted 2.6.31-CROCUS #1
> 	Call Trace:
> 	 [<810280cb>] panic+0x49/0xed
> 	 [<8102a6f6>] do_exit+0x55/0xdc4
> 	 [<81028fec>] ? printk+0x9f/0x104
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	 [<81014af7>] save_v86_state+0xa6/0x168
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	 [<81002ac6>] work_notifysig_v86+0x06/0x18
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	reboot[1781]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
> 	no vm86_info: BAD
>=20
> Other than this, it seems to work fine.
>=20
> We had previously been using v2.4.7, kernel 2.6.28.7 which does not hav=
e
> this issue but for development, we would like to use X and we find that=
 some
> X applications (e.g. Netbeans & eclipse) hang the system (with no indic=
ation
> of cause i.e. no console messages & nothing in the logs - the system ju=
st
> stops). However, when we use v2.4.9.1 with kernel 2.6.31, we can use X =
apps
> perfectly but we can't reboot!
>=20
> Anyone have any ideas/suggestions?

Patch below fixes it for me.

There seems to be another gremlin like this, but it needs a second
check. I will post official patches once that is done.

Jan

----------->

x86: Fix reboot for SMP

So far I-pipe called reboot_interrupt recursively as it virtualized the
wrong entry call.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 arch/x86/include/asm/hw_irq.h |    1 +
 arch/x86/kernel/ipipe.c       |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.=
h
index d523a86..6a7c6bc 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -122,6 +122,7 @@ extern void smp_invalidate_interrupt(struct pt_regs *=
);
 #else
 extern asmlinkage void smp_invalidate_interrupt(struct pt_regs *);
 #endif
+extern asmlinkage void smp_reboot_interrupt(void);
 #endif
=20
 extern void (*__initconst interrupt[NR_VECTORS-FIRST_EXTERNAL_VECTOR])(v=
oid);
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index af902c6..b8f9139 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -297,7 +297,7 @@ void __init __ipipe_enable_pipeline(void)
=20
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     ipipe_apic_vector_irq(REBOOT_VECTOR),
-			     (ipipe_irq_handler_t)&reboot_interrupt,
+			     (ipipe_irq_handler_t)&smp_reboot_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);


--------------enig64F8B47C56CD8712494D645B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrHcmQACgkQitSsb3rl5xROKwCgh36pWBqBfz/nxGM5dTTVjBwi
PzYAoM1nD7JLYQsngm9QObdNwOMrLLaT
=/Flj
-----END PGP SIGNATURE-----

--------------enig64F8B47C56CD8712494D645B--

