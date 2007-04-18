Message-ID: <46268879.30507@domain.hid>
Date: Wed, 18 Apr 2007 23:07:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid> <1176926837.5010.90.camel@domain.hid>
In-Reply-To: <1176926837.5010.90.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB706B30E4A59D4A0F381362C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB706B30E4A59D4A0F381362C
Content-Type: multipart/mixed;
 boundary="------------090409080201080108000902"

This is a multi-part message in MIME format.
--------------090409080201080108000902
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2007-04-18 at 20:13 +0200, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> here is an explanation of the scalable scheduler issue I face on x86_6=
4
>> under different gcc compilers:
>>
>>         unsigned long x =3D 0;
>>         int n =3D 32;
>>
>>         x |=3D 1 << n;
>>
>> The last instruction translates to:
>>
>> 	mov    0xfffffffffffffffc(%rbp),%ecx
>> 	mov    $0x1,%eax
>> 	shl    %cl,%eax
>> 	cltq
>> 	or     %rax,0xfffffffffffffff0(%rbp)
>>
>=20
> Blast. Good spot.
>=20
>> That means we only shift with 32-bit precision although the target typ=
e
>> is 64 bit. We find such code for setting the queue usage bits in
>> addmlq(), but probably elsewhere too. This variant lets gcc generate t=
he
>> desired code:
>>
>> 	x |=3D (unsigned long)1 << n;
>>
>> Compiler issue, x86_64-specific oddity, or generic 64-bit problem we m=
ay
>> have across the ipipe and Xenomai code (ppc64, ia64?)?
>>
>=20
> A brief look at the I-pipe code base shows that most shift expressions
> have righthand sides limited to small values (at least always < 32), an=
d
> when they don't, the lefthand side is properly cast to long long values=
,
> so this should be ok.
>=20
> BUT, it's a general 64bit port issue for Xenomai, which is not specific=

> to the multi-level queue implementation. We have the same issue going o=
n
> with at least:
>=20
> - the posix registry
> - the message pipe support from the nucleus
> - the vrtx id generator
>=20
> Gentlemen, it's time for bug hunting.
>=20
>> After patching nucleus/queue.h appropriately, my oopses disappear, but=

>> RT threads still do not run (no CSW to the threads latency creates).
>> Jan
>>
>>
>> PS: If you are interested, I could post a modified qemu patch that
>> enables gdb kernel debugging under x86_64.
>>
>=20
> Yes please. I would have a look to the remaining issue I have here
> exclusively over qemu, which seems unrelated to the multi-level queue
> issue though.
>=20

Attached. A post to qemu-devel is also on the way. I wonder way the
original patch by Jason Wessel, posted last September, or a variant of
it still didn't make it into a qemu release or at least its CVS. Anyway.

Jan

--------------090409080201080108000902
Content-Type: text/plain;
 name="x86_64-gdb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="x86_64-gdb.patch"

Index: qemu-0.9.0/gdbstub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-0.9.0.orig/gdbstub.c
+++ qemu-0.9.0/gdbstub.c
@@ -220,9 +220,78 @@ static int put_packet(GDBState *s, char=20
     }
     return 0;
 }
+#if defined(TARGET_X86_64)
+/* Defines from GDB register struct numbers */
+#define _RAX	0
+#define _RBX	1
+#define _RCX	2
+#define _RDX	3
+#define _RSI	4
+#define _RDI	5
+#define _RBP	6
+#define _RSP	7
+#define _R8	8
+#define _R15	15
+#define _PC	16
+#define _PS	17
+#define _CS	18
+#define _SS	19
+#define _DS	20
+#define _ES	21
+#define _FS	22
+#define _GS	23
+#define _NREGS	24
=20
-#if defined(TARGET_I386)
+static int cpu_gdb_read_registers(CPUState *env, uint8_t *mem_buf)
+{
+    uint64_t *registers =3D (uint64_t *)mem_buf;
+    int i;
+
+    registers[_RAX] =3D env->regs[R_EAX];
+    registers[_RBX] =3D env->regs[R_EBX];
+    registers[_RCX] =3D env->regs[R_ECX];
+    registers[_RDX] =3D env->regs[R_EDX];
+    registers[_RSI] =3D env->regs[R_ESI];
+    registers[_RDI] =3D env->regs[R_EDI];
+    registers[_RBP] =3D env->regs[R_EBP];
+    registers[_RSP] =3D env->regs[R_ESP];
+    for (i =3D 8; i < 16; i++)
+        registers[i] =3D env->regs[i];
+    registers[_PC] =3D env->eip;
+    registers[_PS] =3D env->eflags;
+    registers[_CS] =3D env->segs[R_CS].selector;
+    registers[_SS] =3D env->segs[R_SS].selector;
+    registers[_DS] =3D env->segs[R_DS].selector;
+    registers[_ES] =3D env->segs[R_ES].selector;
+    registers[_FS] =3D env->segs[R_FS].selector;
+    registers[_GS] =3D env->segs[R_GS].selector;
+
+    for(i =3D 0; i < _NREGS; i++)
+        tswapl(registers[i]);
+
+    return _NREGS * 8;
+}
+
+static void cpu_gdb_write_registers(CPUState *env, uint8_t *mem_buf, int=
 size)
+{
+    uint32_t *registers =3D (uint32_t *)mem_buf;
+    int i;
+
+    env->regs[R_EAX] =3D tswapl(registers[_RAX]);
+    env->regs[R_EBX] =3D tswapl(registers[_RBX]);
+    env->regs[R_ECX] =3D tswapl(registers[_RCX]);
+    env->regs[R_EDX] =3D tswapl(registers[_RDX]);
+    env->regs[R_ESI] =3D tswapl(registers[_RSI]);
+    env->regs[R_EDI] =3D tswapl(registers[_RDI]);
+    env->regs[R_EBP] =3D tswapl(registers[_RBP]);
+    env->regs[R_ESP] =3D tswapl(registers[_RSP]);
+    for (i =3D 8; i < 16; i++)
+        env->regs[i] =3D tswapl(registers[i]);
+    env->eip =3D tswapl(registers[_PC]);
+    env->eflags =3D tswapl(registers[_PS]);
+}
=20
+#elif defined(TARGET_I386)
 static int cpu_gdb_read_registers(CPUState *env, uint8_t *mem_buf)
 {
     uint32_t *registers =3D (uint32_t *)mem_buf;

--------------090409080201080108000902--

--------------enigB706B30E4A59D4A0F381362C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJoh6niDOoMHTA+kRAgGrAJ4vEH+F5F6mOxMRemKdpDBBS+SdCACeKAfy
iL53itFBuJ/mRmF2dLneS/I=
=wt32
-----END PGP SIGNATURE-----

--------------enigB706B30E4A59D4A0F381362C--

