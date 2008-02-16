Message-ID: <47B6C752.4080503@domain.hid>
Date: Sat, 16 Feb 2008 12:21:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.5479.1202920211.28415.xenomai@xenomai.org>	<47B415340200000100192592@domain.hid>
	<47B45F5D.60509@domain.hid>
In-Reply-To: <47B45F5D.60509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D238038A325E9689AF516BF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai-2.4.2 vs kernel-2.6.24 (i686)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Hubert Talbot <Hubert.Talbot@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D238038A325E9689AF516BF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Hubert Talbot wrote:
>> Hi,
>>
>> I try to build kernel 2.6.24 with adeos-ipipe-2.6.24-x86-2.0-03.patch
>> and I get this:
>>
>>   ...
>>   AR      arch/x86/lib/lib.a
>>   GEN     .version
>>   CHK     include/linux/compile.h
>>   UPD     include/linux/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> arch/x86/kernel/built-in.o: In function `do_machine_check_vector':
>> ipipe.c:(.text+0x128de): undefined reference to `do_machine_check'
>> make[1]: *** [.tmp_vmlinux1] Erreur 1
>> make[1]: quittant le r=E9pertoire * /usr/src/linux-2.6.24 *
>> make: *** [debian/stamp-build-kernel] Erreur 2
>>
>=20
> It's a 64bit symbol only it seems. Disable CONFIG_X86_MCE for now, will=

> fix. Thanks.

Here is some fix for this:

---
 arch/x86/kernel/ipipe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/arch/x86/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -644,8 +644,13 @@ asmlinkage int __ipipe_syscall_root(stru
 static void do_machine_check_vector(struct pt_regs *regs, long error_cod=
e)
 {
 #ifdef CONFIG_X86_MCE
+#ifdef CONFIG_X86_32
+	extern void (*machine_check_vector)(struct pt_regs *, long error_code);=

+	machine_check_vector(regs, error_code);
+#else  /* !CONFIG_X86_32 */
 	void do_machine_check(struct pt_regs *, long);
-	do_machine_check(regs,error_code);
+	do_machine_check(regs, error_code);
+#endif /* !CONFIG_X86_32 */
 #endif /* CONFIG_X86_MCE */
 }
=20


--------------enig8D238038A325E9689AF516BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHtsdWniDOoMHTA+kRAngVAJ485C/acQpiIMVw5Bla+e37oViy2ACfS9Q1
lqFwPOeqNl7cTCBn+iUzjAo=
=fg/e
-----END PGP SIGNATURE-----

--------------enig8D238038A325E9689AF516BF--

