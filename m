Message-ID: <45CFB4A9.5070704@domain.hid>
Date: Mon, 12 Feb 2007 01:28:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45CDAA95.1070900@domain.hid> <45CDC5AE.5010903@domain.hid>	
	<45CDC6A0.1020407@domain.hid> <1171233728.5035.22.camel@domain.hid>
In-Reply-To: <1171233728.5035.22.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3167EF61B13FF8672F6A183C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: tracer broken on 2.6.20-i386
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3167EF61B13FF8672F6A183C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> On Sat, 2007-02-10 at 14:20 +0100, Jan Kiszka wrote:
>  =20
>> Jan Kiszka wrote:
>>    =20
>>> Jan Kiszka wrote:
>>>
>>>      =20
>>>> Philippe,
>>>>
>>>> have you had to adopt any tracer-related code while switching to 2.6=
=2E20?
>>>> The same .config that worked fine for 2.6.19 doesn't boot here on
>>>> 2.6.20. The kernel hangs during or after decompression. Disabling th=
e
>>>> tracer resolves this.
>>>>  =20
>>>>        =20
>>> I had a look at latest -rt and found some new change (which turned ou=
t
>>> to be a hack). Playing with it, I understood its motivation (avoid
>>> instrumentation of the decompressor). Here comes a cleaner variant fo=
r
>>> 2.6.20 (all archs). Tracer boots fine again. :)
>>>      =20
>>           ^^^^^^^^^
>> Strike that, I lost the overview for a while. It remains an i386 issue=
=2E
>>
>>    =20
>
> The tracer still has a problem when booting 2.6.20 here (UP, LAPIC,
> static Xenomai build, default configuration for both Xeno and the
> pipeline+tracer, your latest patch against boot/compressed/Makefile
> applied).
>
> __ipipe_trace seems to be called before the trace log has been setup,
> hence the box jumps out of the window upon an invalid data reference
> when storing some mcount data. Enabling the VMALLOC log option clears
> the issue.
>  =20
CONFIG_REGPARM passed away. It became default in fact. The following patc=
h
removes the remainders from the tracer:

---
 arch/i386/kernel/entry.S  |   11 -----------
 arch/i386/kernel/mcount.S |   13 +------------
 2 files changed, 1 insertion(+), 23 deletions(-)

Index: linux-2.6.20/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/entry.S
+++ linux-2.6.20/arch/i386/kernel/entry.S
@@ -105,25 +105,14 @@ VM_MASK		=3D 0x00020000
 				jnz restore_nocheck_notrace
=20
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-# ifdef CONFIG_REGPARM
-#  define LOAD_ARG
-#  define REMOVE_ARG
-# else  /* !CONFIG_REGPARM */
-#  define LOAD_ARG      pushl %eax
-#  define REMOVE_ARG    addl $4, %esp
-# endif /* CONFIG_REGPARM */
 # define IPIPE_TRACE_IRQ_ENTER \
 	lea PT_EIP-4(%esp), %ebp; \
 	movl PT_ORIG_EAX(%esp), %eax; \
-	LOAD_ARG; \
 	call ipipe_trace_begin; \
-	REMOVE_ARG
 # define IPIPE_TRACE_IRQ_EXIT \
 	pushl %eax; \
 	movl PT_ORIG_EAX+4(%esp), %eax; \
-	LOAD_ARG; \
 	call ipipe_trace_end; \
-	REMOVE_ARG; \
 	popl %eax
 #else  /* !CONFIG_IPIPE_TRACE_IRQSOFF */
 #define IPIPE_TRACE_IRQ_ENTER
Index: linux-2.6.20/arch/i386/kernel/mcount.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/mcount.S
+++ linux-2.6.20/arch/i386/kernel/mcount.S
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/i386/mcount.S
  *
- *  Copyright (C) 2005 Jan Kiszka
+ *  Copyright (C) 2005, 2007 Jan Kiszka
  */
=20
 .globl mcount
@@ -17,23 +17,12 @@ mcount:
 	pushl %edx
=20
 	pushl $0		# no additional value (v)
-#ifdef CONFIG_REGPARM
 	movl (%ebp),%eax
 	movl 0x4(%ebp),%edx	# __CALLER_ADDR0
 	movl 0x4(%eax),%ecx	# __CALLER_ADDR1
 	movl $0,%eax		# IPIPE_TRACE_FUNC
 	call __ipipe_trace
 	popl %eax
-#else /* !CONFIG_REGPARM */
-	movl (%ebp),%eax
-	movl 0x4(%eax),%eax
-	pushl %eax		# __CALLER_ADDR1
-	movl 0x4(%ebp),%eax
-	pushl %eax		# __CALLER_ADDR0
-	pushl $0		# IPIPE_TRACE_FUNC
-	call __ipipe_trace
-	addl $0x10,%esp
-#endif /* CONFIG_REGPARM */
=20
 	popl %edx
 	popl %ecx


Looking at the tracer enable code made me wonder why it didn't look like
it should do. Some patch obviously dropped on the floor:

https://mail.gna.org/public/adeos-main/2006-12/msg00037.html

Please apply now as well.

Jan



--------------enig3167EF61B13FF8672F6A183C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFz7SpniDOoMHTA+kRAiXDAJ9tRl6SrsveYGfU/IUllYt+D7sHgwCfV6Qe
94bghLXxNLc0IOuCq/kHrcY=
=D341
-----END PGP SIGNATURE-----

--------------enig3167EF61B13FF8672F6A183C--

