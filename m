Message-ID: <4917597F.4040102@domain.hid>
Date: Sun, 09 Nov 2008 22:43:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <491749A1.7060609@domain.hid>
In-Reply-To: <491749A1.7060609@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Compile Kernel 2.6.26 with adeos patch failed
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Newsgroup <newsgroup@domain.hid>
Cc: xenomai@xenomai.org

Newsgroup wrote:
> Hello,
>=20
> ive got a problem compiling the patched 2.6.26.7 linux kernel with the
> adeos-ipipe patch.
>=20
> after calling the prepare-kernel.sh script and "make menuconfig" i try
> to build the kernel.
>=20
> This error occurs:
>

export LANG=3DC before compiling would be nice for non-german speaking folk=
s.

> scripts/kconfig/conf -s arch/x86/Kconfig
> CHK include/linux/version.h
> CHK include/linux/utsrelease.h
> CALL scripts/checksyscalls.sh
> CHK include/linux/compile.h
> CC arch/x86/kernel/ipipe.o
> arch/x86/kernel/ipipe.c: In Funktion =C2=BB__ipipe_divert_exception=C2=AB:
> arch/x86/kernel/ipipe.c:810: Fehler: =C2=BBex_do_device_not_available=C2=
=AB
> nicht deklariert (erste Benutzung in dieser Funktion)
> arch/x86/kernel/ipipe.c:810: Fehler: (Jeder nicht deklarierte Bezeichner
> wird nur einmal aufgef=C31/4hrt
> arch/x86/kernel/ipipe.c:810: Fehler: f=C31/4r jede Funktion in der er
> auftritt.)
> make[1]: *** [arch/x86/kernel/ipipe.o] Fehler 1
> make: *** [arch/x86/kernel] Fehler 2
>=20
> can anyone able to help me?
>

Switch off KGDB support or apply this:

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 3a24903..de6fd50 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -807,7 +807,7 @@ int __ipipe_divert_exception(struct pt_regs *regs, int =
vector)
 #ifdef CONFIG_KGDB
 	/* catch int1 and int3 over non-root domains */
 #ifdef CONFIG_X86_32
-	if (!ipipe_root_domain_p && vector !=3D ex_do_device_not_available) {
+	if (!ipipe_root_domain_p && vector !=3D ex_device_not_available) {
 #else
 	if (!ipipe_root_domain_p) {
 #endif


> Greets
>=20
> Maveric
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

