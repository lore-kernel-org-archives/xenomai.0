From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1173966835.16299.49.camel@domain.hid>
References: <1173966835.16299.49.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 15 Mar 2007 14:57:03 +0100
Message-Id: <1173967023.16299.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] [PATCH - ARM] ldrex/strex syntax errors with recent
	compilers
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Le jeudi 15 mars 2007 =E0 14:53 +0100, Stelian Pop a =E9crit :

[on xenomai-core ml]
> Hi,
>=20
> Trying to build a xenomai-enabled kernel using a recent compiler (tried
> with gcc version 4.1.1 (CodeSourcery ARM Sourcery G++ 2006q3-26), but
> all gcc > 4.1 might be affected) results in the following:
>=20
>   CC      kernel/xenomai/nucleus/shadow.o
> /tmp/cc0XooxH.s: Assembler messages:
> /tmp/cc0XooxH.s:1464: Error: instruction does not accept this addressin=
g mode -- `ldrex r1,r2'
> /tmp/cc0XooxH.s:1466: Error: instruction does not accept this addressin=
g mode -- `strex r3,r1,r2'
>=20
> Older gcc (like gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) have no proble=
m with this.
>=20
> It appears that the patch below fixes the compile error. I also verifie=
d=20
> that gcc-4.0.0 generates identical code using both forms.

The same issue is present in the mainline kernel too. I'll report this
on LKML but meanwhile the patch below could be included in the Adeos
patch as well...

Thanks.

Stelian.

diff --git a/include/asm-arm/atomic.h b/include/asm-arm/atomic.h
index c86c3d0..5dda903 100644
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -103,9 +103,9 @@ static inline void atomic_clear_mask(unsigned long ma=
sk, unsigned long *addr)
 	unsigned long tmp, tmp2;
=20
 	__asm__ __volatile__("@ atomic_clear_mask\n"
-"1:	ldrex	%0, %2\n"
+"1:	ldrex	%0, [%2]\n"
 "	bic	%0, %0, %3\n"
-"	strex	%1, %0, %2\n"
+"	strex	%1, %0, [%2]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
 	: "=3D&r" (tmp), "=3D&r" (tmp2)

--=20
Stelian Pop <stelian@domain.hid>


