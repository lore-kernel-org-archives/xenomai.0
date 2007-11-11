Message-ID: <4737510F.7010309@domain.hid>
Date: Sun, 11 Nov 2007 19:59:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>	<473006D8.4080808@domain.hid>	<47302D55.9050808@domain.hid>	<47339C53.5010700@domain.hid>	<4734677E.6010904@domain.hid>	<47348EE0.5020007@domain.hid>	<473493CB.4080701@domain.hid>
	<4734995B.20900@domain.hid>
In-Reply-To: <4734995B.20900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig480277C0D6E2EF59B074F193"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig480277C0D6E2EF59B074F193
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>
>>>> Well, this is practically your original version. I still don't see w=
hy
>>>> we want debug code in production setups (WARN_ON, e.g., doesn't work=

>>>> this way either),
>>> Do you actually leave CONFIG_IPIPE_DEBUG on in production setups?
>> Not /me, but your patch drags in the the full warning message even
>> without CONFIG_IPIPE_DEBUG - if I virtually apply the patch correctly.=

>>
>=20
> Are you 100% sure of this?

Yep, I am. The rationale here is to keep the Linux fault path free of
tests, unless we need them urgently also for non-debug setups. We don't,
we just loose the context information in case the test is actually true.
The oops will come anyway.

>=20
>>>> and I still don't understand why you want to report
>>>> user faults as kernel bugs.
>>>>
>>> This is a red herring: we are currently in a situation where such
>>> messages would be actual kernel issues because some APIs are sloppy w=
rt
>>> kernel/user copies, this is the point.
>>>
>>>> If you want to spot skin issues, just grep for __xn_copy_to/from_use=
r or
>>>> __xn_strncpy_from_user and check for missing return code evaluations=
=2E
>>>> Really, that's nothing we need runtime checks in I-pipe for.
>>>>
>>> It's a _debug_ tool until everything is fixed, because we have loads =
of
>>> APIs to fix for untested copy_from/to_user, and anything out-of-tree
>>> code may have used the same way. It's merely a conditional and passiv=
e
>>> check, far away from the hot path, which is there "just in case". The=

>>> same way you may run with the domain context checker enabled although=

>>> you may be reasonably confident that having some context mismatch sti=
ll
>>> hiding in the Xenomai core is currently unlikely -- but you know noth=
ing
>>> about what may be going on out-of-tree.
>>>
>>> This feature is mainly aimed at API writers, not users. Additionally,=

>> If you want to support API writer: Let us tag __xn_copy* with
>> __must_check - _that_ would be the right tool for pointing out remaini=
ng
>> issues, not some runtime warning that a) only triggers if the user
>=20
> What do you make of existing setups which will not upgrade to 2.4 in an=
y
> foreseeable future?

99% of the very same setups won't upgrade to new kernel patches either,
so the effect is likely negligible.

>=20
>> stumbled over it and b) causes false positives for those skin which
>> already behave nicely.
>>
>=20
> The only case I see which could bother you is this one: people arming

No, I'm still mumbling about both of the explained issues.

> CONFIG_IPIPE_DEBUG because they are in development mode, and passing
> deadly spurious arguments to a syscall for reading/writing memory. I'm

They are no longer deadly (since we started switching to root). The
skins already handle them, some just fail to inform the user who may
then stumble differently about his own faults. See, I didn't introduce
CONFIG_IPIPE_DEBUG for user space debugging, it has always been a kernel
debug switch. So I would prefer to keep its semantics straight here as we=
ll.

> not exactly sure that their main problem would be the warning message
> per-se, right?
>=20
> Do you have any other illustration of so-called false positive I may
> have missed?
>=20
>>> not everyone is going to switch to 2.4 with the ironed kernel/user co=
py
>>> code overnight, so we want this code in 2.6.20/x86 too, so that at
>>> least, we may tell people to upgrade their I-pipe patch if need be, t=
hen
>>> switch CONFIG_IPIPE_DEBUG on to trap those trivial issues, including
>>> over past 2.3.x releases. At least, we could tell them how and where =
to
>>> fix their code.
>>>
>>> At worst, the message will never trigger because all bugous spots wil=
l
>>> have been addressed within the skins during the next stable releases:=

>>> fine. Otherwise, we will have more information to chase such kind of =
bugs.
>> Nope, it will trigger also after the skins are converted. This is what=

>> makes it inappropriate IMHO.
>>
>=20
> What's really inappropriate, is more likely to pass bugous pointers to =
a
> syscall, I think.

Bogus user pointers don't need to worry us from the I-pipe perspective.
I-pipe users either wrapped them in copy_to/from_user or will trap on
them loudly anyway. If they wrap but fail to report, then this is still
no excuse to pile up debugging code under I-pipe, because the kernel
will remain unaffected. Even if it is a small test like this here, it is
a question of principles.

Jan

PS:
---
 arch/i386/kernel/ipipe.c |   34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

Index: linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
@@ -616,12 +616,6 @@ static int __ipipe_xlate_signo[] =3D {
 };
 #endif /* CONFIG_KGDB */
=20
-#ifdef CONFIG_IPIPE_DEBUG
-#define ipipe_may_dump_nonroot_fault(regs)	1
-#else
-#define ipipe_may_dump_nonroot_fault(regs)	(!search_exception_tables((re=
gs)->eip))
-#endif
-
 fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_c=
ode, int vector)
 {
 	unsigned long flags;
@@ -654,23 +648,19 @@ fastcall int __ipipe_handle_exception(st
 		return 1;
 	}
=20
-	/*
-	 * Detect unhandled faults from kernel space over non-root domains.
-	 */
-	if (unlikely(!ipipe_root_domain_p && !(error_code & 4))) {
-		/*
-		 * Always warn about such faults when running in debug
-		 * mode, otherwise avoid reporting the fixable ones.
-		 */
-		if (ipipe_may_dump_nonroot_fault(regs)) {
-			struct ipipe_domain *ipd =3D ipipe_current_domain;
-			ipipe_current_domain =3D ipipe_root_domain;
-			ipipe_trace_panic_freeze();
-			printk(KERN_ERR "DOMAIN FAULT: Unhandled exception over domain"
-			       " %s - switching to ROOT\n", ipd->name);
-			dump_stack();
-		}
+#ifdef CONFIG_IPIPE_DEBUG
+	/* Warn about unhandled faults over non-root domains in kernel space
+	 * unless they occured at fixable locations. */
+	if (unlikely(!ipipe_root_domain_p) && !(error_code & 4) &&
+	    !search_exception_tables(instruction_pointer(regs))) {
+		struct ipipe_domain *ipd =3D ipipe_current_domain;
+		ipipe_current_domain =3D ipipe_root_domain;
+		ipipe_trace_panic_freeze();
+		printk(KERN_ERR "BUG: Unhandled exception over domain"
+				" %s - switching to ROOT\n", ipd->name);
+		dump_stack();
 	}
+#endif /* CONFIG_IPIPE_DEBUG */
=20
 	/* Always switch to root so that Linux can handle it cleanly. */
 	ipipe_current_domain =3D ipipe_root_domain;


--------------enig480277C0D6E2EF59B074F193
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHN1EPniDOoMHTA+kRAgNYAJ4rnOjYkLLerkDGFtvGucA03M/ghgCdFCy7
eyZt66oqN46fuQkIngWyu2o=
=gfb3
-----END PGP SIGNATURE-----

--------------enig480277C0D6E2EF59B074F193--

