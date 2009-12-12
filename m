Message-ID: <4B240D0B.50603@domain.hid>
Date: Sat, 12 Dec 2009 22:37:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F717012C5357EC5B7B05DC5"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [pull request] x86: critical fix for native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F717012C5357EC5B7B05DC5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Recent moving of ipipe_suspend_domain finally exposed a deeper flaw in
cpu_idle on x86: We failed to check the pipeline log before issuing the
real hlt. This caused IRQ latencies or even drops for Linux,
specifically on SMP. Credits go to plain QEMU whose slow SMP mode caused
ipipe_critical_enter to deadlock frequently enough.

The first patch of this series fixes this (see below), the second one
simply removes the two useless ipipe_suspend_domain calls.


The following changes since commit 7cd56451b429702996adef794f01f1067e5fff=
51:
  Philippe Gerum (1):
        ipipe-2.6.31.1-x86-2.4-08

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.31-x86

Jan Kiszka (2):
      x86: Properly virtualize native_safe_halt
      x86: Drop redundant ipipe_suspend_domain from cpu_idle

 arch/x86/include/asm/ipipe_base.h |    2 ++
 arch/x86/include/asm/irqflags.h   |    8 +++++---
 arch/x86/kernel/ipipe.c           |   23 +++++++++++++++++++++++
 arch/x86/kernel/process_32.c      |    2 --
 arch/x86/kernel/process_64.c      |    3 ---
 5 files changed, 30 insertions(+), 8 deletions(-)

------

x86: Properly virtualize native_safe_halt

We have to check the root domain's log before halting. If it is not
empty, we need to replay and return immediately. Otherwise we risk to
defer or even lose root domain interrupts.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe_base.h |    2 ++
 arch/x86/include/asm/irqflags.h   |    8 +++++---
 arch/x86/kernel/ipipe.c           |   23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_base.h b/arch/x86/include/asm/ipi=
pe_base.h
index c3bd7d1..3c81096 100644
--- a/arch/x86/include/asm/ipipe_base.h
+++ b/arch/x86/include/asm/ipipe_base.h
@@ -203,6 +203,8 @@ static inline unsigned long __ipipe_test_root(void)
=20
 #endif /* !CONFIG_SMP */
=20
+void __ipipe_halt_root(void);
+
 void __ipipe_serial_debug(const char *fmt, ...);
=20
 #endif	/* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqfl=
ags.h
index 71ede94..1baceba 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -72,10 +72,12 @@ static inline void native_irq_enable(void)
=20
 static inline void native_safe_halt(void)
 {
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-	ipipe_trace_end(0x8000000E);
-#endif
+#ifdef CONFIG_IPIPE
+	barrier();
+	__ipipe_halt_root();
+#else
 	asm volatile("sti; hlt": : :"memory");
+#endif
 }
=20
 static inline void native_halt(void)
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index d4789c8..487b2b0 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -601,6 +601,29 @@ void __ipipe_preempt_schedule_irq(void)
=20
 #endif /* !CONFIG_X86_32 */
=20
+void __ipipe_halt_root(void)
+{
+	struct ipipe_percpu_domain_data *p;
+
+	/* Emulate sti+hlt sequence over the root domain. */
+
+	local_irq_disable_hw();
+
+	p =3D ipipe_root_cpudom_ptr();
+
+	clear_bit(IPIPE_STALL_FLAG, &p->status);=20
+
+	if (unlikely(p->irqpend_himask !=3D 0)) {
+		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+		local_irq_enable_hw();
+	} else {
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+		ipipe_trace_end(0x8000000E);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+		asm volatile("sti; hlt": : :"memory");
+	}
+}
+
 static void do_machine_check_vector(struct pt_regs *regs, long error_cod=
e)
 {
 #ifdef CONFIG_X86_MCE
--=20
1.6.0.2


--------------enig4F717012C5357EC5B7B05DC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkskDQ8ACgkQitSsb3rl5xQz/ACfedrWKbm3l4n4yA/Hwp8kPiRX
urcAoOVqd7TZU12yOyAFjWvm1BEgG3b3
=/Egk
-----END PGP SIGNATURE-----

--------------enig4F717012C5357EC5B7B05DC5--

