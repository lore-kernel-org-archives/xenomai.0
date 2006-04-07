Message-ID: <443662DE.8020804@domain.hid>
Date: Fri, 07 Apr 2006 15:02:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>
	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>
	<44352E12.1000502@domain.hid> <443533E3.6080305@domain.hid>
	<4435363B.50701@domain.hid> <443537C5.1080801@domain.hid>
	<44354CC5.8080405@domain.hid>
In-Reply-To: <44354CC5.8080405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94D9690DD83EE4DBEEC252EB"
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
--------------enig94D9690DD83EE4DBEEC252EB
Content-Type: multipart/mixed; boundary="------------020506070509040700010801"

This is a multi-part message in MIME format.
--------------020506070509040700010801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> ...
>>> It seems that the pipeline log is not synced by
>>> __ipipe_unstall_iret_root.
>>> We need to know why. Question: is the root stage stalled or unstalled=
 by
>>> this
>>> routine during the latest call before the box freezes?
>>
>>
>> I'm currently switching my brain between to many tasks: Could you simp=
ly
>> tell me what variable to check so that I can hack some
>> ipipe_trace_special into the kernel?
>=20
> The value of the IPIPE_STALL_FLAG for the root domain upon exit from
> __ipipe_unstall_iret_root.
>=20

The problem seems to be the stalled Xenomai domain:

>   fn                 1917    3.503  cond_resched+0x9 (console_condition=
al_schedule+0x16)
>  |fn                 1921    2.706  __ipipe_handle_irq+0xe (common_inte=
rrupt+0x18)
>  |fn                 1923    1.548  __ipipe_ack_common_irq+0x9 (__ipipe=
_handle_irq+0xc0)
>  |fn                 1925    4.390  mask_and_ack_8259A+0xb (__ipipe_ack=
_common_irq+0x47)
>  |(0x20) 0x00000000  1929    0.796  __ipipe_handle_irq+0x144 (common_in=
terrupt+0x18)
>  |(0x30) 0x00000064  1930    0.766  __ipipe_handle_irq+0x15c (common_in=
terrupt+0x18)
>  |(0x31) 0x00000064  1931    0.812  __ipipe_handle_irq+0x169 (common_in=
terrupt+0x18)
>  |(0x32) 0x000000c8  1932    0.766  __ipipe_handle_irq+0x17e (common_in=
terrupt+0x18)
>  |(0x32) 0x00000001  1932    0.781  __ipipe_handle_irq+0x188 (common_in=
terrupt+0x18)
>  |(0x21) 0x00000000  1933    1.383  __ipipe_handle_irq+0x208 (common_in=
terrupt+0x18)
>  |fn                 1934    1.413  __ipipe_stall_root+0x8 (resume_kern=
el+0x5)
>   fn                 1936    1.052  __ipipe_unstall_iret_root+0x8 (rest=
ore_raw+0x0)
>  |(0x11) 0x00000000  1937    0.932  __ipipe_unstall_iret_root+0x31 (res=
tore_raw+0x0)
>  |(0x03) 0x00000000  1938    1.774  __ipipe_unstall_iret_root+0x64 (res=
tore_raw+0x0)
>   fn                 1940    0.736  console_conditional_schedule+0x8 (f=
bcon_redraw+0xdf)

This was taken during the failing Linux timer tick with the attached
instrumentation hack.

BTW, that trace hacking reminds me that we should really think about
making a kernel debugger run. I recently noticed that latest kgdb
applied with a single failing hunk on top of ipipe (2.6.15, x86). Maybe
it is just about making kgdb's irq-locks ipipe-aware and bypassing the
ipipe for int3 and the serial IRQ (so that ipipe can be debugged as
well) and catching the relevant exceptions. Hmm, the debugger seems to
get initialised in the "early" stage. Is this before or after ipipe setup=
?

Jan

--------------020506070509040700010801
Content-Type: text/plain;
 name="ipipe-root-instr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-root-instr.patch"

--- arch/i386/kernel/ipipe-root.c.orig	2006-04-05 23:13:45.000000000 +020=
0
+++ arch/i386/kernel/ipipe-root.c	2006-04-07 14:35:30.000000000 +0200
@@ -315,11 +315,13 @@ asmlinkage void __ipipe_unstall_iret_roo
 	   emulation. */
=20
 	if (!(regs.eflags & X86_EFLAGS_IF)) {
+ipipe_trace_special(0x10, 0);
 		__set_bit(IPIPE_STALL_FLAG,
 			  &ipipe_root_domain->cpudata[cpuid].status);
 		ipipe_mark_domain_stall(ipipe_root_domain, cpuid);
 		regs.eflags |=3D X86_EFLAGS_IF;
 	} else {
+ipipe_trace_special(0x11, 0);
 		__clear_bit(IPIPE_STALL_FLAG,
 			    &ipipe_root_domain->cpudata[cpuid].status);
=20
@@ -335,6 +337,7 @@ asmlinkage void __ipipe_unstall_iret_roo
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 	ipipe_trace_end(0x8000000D);
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+ipipe_trace_special(0x03, ipipe_root_domain->cpudata[cpuid].status);
 }
=20
 asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
@@ -457,20 +460,26 @@ fastcall int __ipipe_divert_exception(st
 static inline void __ipipe_walk_pipeline(struct list_head *pos, int cpui=
d)
 {
 	struct ipipe_domain *this_domain =3D ipipe_percpu_domain[cpuid];
+ipipe_trace_special(0x30, ipipe_root_domain->priority);
+ipipe_trace_special(0x31, this_domain->priority);
=20
 	while (pos !=3D &__ipipe_pipeline) {
 		struct ipipe_domain *next_domain =3D
 		    list_entry(pos, struct ipipe_domain, p_link);
+ipipe_trace_special(0x32, next_domain->priority);
+ipipe_trace_special(0x32, next_domain->cpudata[cpuid].status);
=20
 		if (test_bit
 		    (IPIPE_STALL_FLAG, &next_domain->cpudata[cpuid].status))
 			break;	/* Stalled stage -- do not go further. */
=20
+ipipe_trace_special(0x34, 0);
 		if (next_domain->cpudata[cpuid].irq_pending_hi !=3D 0) {
=20
 			if (next_domain =3D=3D this_domain)
 				__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
 			else {
+ipipe_trace_special(0x35, 0);
 				__ipipe_switch_to(this_domain, next_domain,
 						  cpuid);
=20
@@ -483,6 +492,7 @@ static inline void __ipipe_walk_pipeline
 					__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
 			}
=20
+ipipe_trace_special(0x36, 0);
 			break;
 		} else if (next_domain =3D=3D this_domain)
 			break;
@@ -587,7 +597,9 @@ int __ipipe_handle_irq(struct pt_regs re
 	   marked as 'sticky'. This search does not go beyond the
 	   current domain in the pipeline. */
=20
+ipipe_trace_special(0x20, 0);
 	__ipipe_walk_pipeline(head, cpuid);
+ipipe_trace_special(0x21, 0);
=20
 	ipipe_load_cpuid();
=20

--------------020506070509040700010801--

--------------enig94D9690DD83EE4DBEEC252EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENmLeniDOoMHTA+kRAixNAJ9ScZyhksivSXUx1/t/8OeEH/HgGgCbBmvy
y1gkSgA37Bs2T+O4K7MrBYE=
=8S82
-----END PGP SIGNATURE-----

--------------enig94D9690DD83EE4DBEEC252EB--

