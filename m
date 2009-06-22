From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A3E9E09.7060109@domain.hid>
References: <4A3E9E09.7060109@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Jun 2009 10:45:31 +0200
Message-Id: <1245660331.4087.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel build fails with
 CONFIG_X86_MCE_P4THERMAL=y
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2009-06-21 at 22:54 +0200, Stefan Kisdaroczi wrote:
> hi,
>=20
> if 'check for P4 thermal throttling interrupt.' (=20
> CONFIG_X86_MCE_P4THERMAL ) is enabled, kernel builds ok with 2.6.28, bu=
t=20
> fails with adeos-ipipe-2.6.29.5-x86-2.4-02.patch:
>=20
> arch/x86/kernel/ipipe.c: In function =E2=80=98__ipipe_enable_pipeline=E2=
=80=99:
> arch/x86/kernel/ipipe.c:210: error: =E2=80=98smp_thermal_interrupt=E2=80=
=99 undeclared=20
> (first use in this function)
> arch/x86/kernel/ipipe.c:210: error: (Each undeclared identifier is=20
> reported only once
> arch/x86/kernel/ipipe.c:210: error: for each function it appears in.)
> make[3]: *** [arch/x86/kernel/ipipe.o] Fehler 1
> make[2]: *** [arch/x86/kernel] Fehler 2
>=20

Thanks. I will push 2.4-03 out after I have received confirmation that
everything is fine on your side. TIA,

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 28cc903..d186a4c 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -116,6 +116,9 @@ void smp_invalidate_interrupt(struct pt_regs *regs);
 void smp_call_function_interrupt(struct pt_regs *regs);
 void smp_call_function_single_interrupt(struct pt_regs *regs);
 void uv_bau_message_interrupt(struct pt_regs *regs);
+#ifdef CONFIG_X86_32
+void smp_thermal_interrupt(struct pt_regs *regs);
+#endif
=20
 static void __ipipe_ack_irq(unsigned irq, struct irq_desc *desc)
 {

>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



