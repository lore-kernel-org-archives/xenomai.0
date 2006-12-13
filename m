Message-ID: <45803F34.9000003@domain.hid>
Date: Wed, 13 Dec 2006 18:58:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87CE7250CCC57F8A2EA8FCE7"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] avoid suboptimal use of ipipe_lock_cpu
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig87CE7250CCC57F8A2EA8FCE7
Content-Type: multipart/mixed; boundary="------------030603090601060404070007"

This is a multi-part message in MIME format.
--------------030603090601060404070007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

while disassembling that bug in start_kernel, I noticed that
ipipe_lock_cpu(flags) is used in a suboptimal way in some
ipipe_XXX_head() services, i.e. when the flags are actually of no
interest. The compiler still generates the unneeded pushf/pop <reg>, and
this in a hot-path.

Attached patch should perform better. Lightly tested, but QEMU SMP still
works here.

Jan

--------------030603090601060404070007
Content-Type: text/plain;
 name="avoid-ipipe_lock_cpu.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="avoid-ipipe_lock_cpu.patch"

---
 include/linux/ipipe.h |    8 ++++----
 kernel/ipipe/core.c   |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.19/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/include/linux/ipipe.h
+++ linux-2.6.19/include/linux/ipipe.h
@@ -471,18 +471,18 @@ static inline void ipipe_restore_pipelin
 static inline void ipipe_stall_pipeline_head(void)
 {
 	ipipe_declare_cpuid;
-	unsigned long flags;
=20
-	ipipe_lock_cpu(flags);
+	local_irq_disable_hw();
+	ipipe_load_cpuid();
 	__set_bit(IPIPE_STALL_FLAG, &__ipipe_pipeline_head()->cpudata[cpuid].st=
atus);
 }
=20
 static inline unsigned long ipipe_test_and_stall_pipeline_head(void)
 {
-	unsigned long flags;
 	ipipe_declare_cpuid;
=20
-	ipipe_lock_cpu(flags);
+	local_irq_disable_hw();
+	ipipe_load_cpuid();
 	return __test_and_set_bit(IPIPE_STALL_FLAG, &__ipipe_pipeline_head()->c=
pudata[cpuid].status);
 }
=20
Index: linux-2.6.19/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/kernel/ipipe/core.c
+++ linux-2.6.19/kernel/ipipe/core.c
@@ -303,10 +303,10 @@ void fastcall ipipe_restore_pipeline_fro
 void ipipe_unstall_pipeline_head(void)
 {
 	struct ipipe_domain *head;
-	unsigned long flags;
 	ipipe_declare_cpuid;
=20
-	ipipe_lock_cpu(flags);
+	local_irq_disable_hw();
+	ipipe_load_cpuid();
 	head =3D __ipipe_pipeline_head();
 	__clear_bit(IPIPE_STALL_FLAG, &head->cpudata[cpuid].status);
=20
@@ -323,9 +323,9 @@ void ipipe_unstall_pipeline_head(void)
 void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head, u=
nsigned long x)
 {
 	ipipe_declare_cpuid;
-	unsigned long flags;
=20
-	ipipe_lock_cpu(flags);
+	local_irq_disable_hw();
+	ipipe_load_cpuid();
=20
 	if (x) {
 #ifdef CONFIG_DEBUG_KERNEL

--------------030603090601060404070007--

--------------enig87CE7250CCC57F8A2EA8FCE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgD80niDOoMHTA+kRAr1tAJ93mmRVHr85V+h7TgMhY/qg5rYjPwCfdUj9
k+uWHdzH/EoT/99M2jsyn+Y=
=H2VX
-----END PGP SIGNATURE-----

--------------enig87CE7250CCC57F8A2EA8FCE7--

