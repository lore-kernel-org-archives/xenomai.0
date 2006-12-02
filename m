Message-ID: <45716330.7000306@domain.hid>
Date: Sat, 02 Dec 2006 12:27:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD328D975AA1CDC5370243814"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix i386 nmi build for 2.6.19
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD328D975AA1CDC5370243814
Content-Type: multipart/mixed; boundary="------------040401040501010307010709"

This is a multi-part message in MIME format.
--------------040401040501010307010709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

As the subject states. Compiles and runs fine - which implies that the
whole 2.6.19-ipipe-1.6-00 patch works perfectly on my Thinkpad. Also
right now while typing this mail. :)

Jan


--------------040401040501010307010709
Content-Type: text/x-patch;
 name="fix-nmi-for-2.6.19-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-nmi-for-2.6.19-i386.patch"

Index: ksrc/arch/i386/nmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/nmi.c	(Revision 1914)
+++ ksrc/arch/i386/nmi.c	(Arbeitskopie)
@@ -72,11 +72,13 @@ static rthal_nmi_wd_t rthal_nmi_wds[NR_C
 static unsigned long rthal_nmi_perfctr_msr;
 static unsigned int rthal_nmi_p4_cccr_val;
 static void (*rthal_nmi_emergency) (struct pt_regs *);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 static void (*rthal_linux_nmi_tick) (struct pt_regs *);
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #define MSR_P4_IQ_CCCR0		0x36C
-#define nmi_active (nmi_watchdog !=3D NMI_NONE)
+#define rthal_nmi_active (nmi_watchdog !=3D NMI_NONE)
 static inline void wrmsrl(unsigned long msr, unsigned long long val)
 {
 	unsigned long lo, hi;
@@ -84,9 +86,15 @@ static inline void wrmsrl(unsigned long=20
 	hi =3D val >> 32;
 	wrmsr(msr, lo, hi);
 }
-#else /* Linux >=3D 2.6 */
+#else /* Linux 2.6.0..18 */
 extern int nmi_active;
-#endif /* Linux >=3D 2.6 */
+#define rthal_nmi_active	nmi_active
+#endif /* Linux 2.6.0..18 */
+
+#else /* Linux >=3D 2.6.19 */
+static int (*rthal_linux_nmi_tick) (struct pt_regs *, unsigned);
+#define rthal_nmi_active	atomic_read(&nmi_active)
+#endif /* Linux >=3D 2.6.19 */
=20
 static void rthal_touch_nmi_watchdog(void)
 {
@@ -105,7 +113,15 @@ static void rthal_touch_nmi_watchdog(voi
 	}
 }
=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs)
+#define NMI_RETURN		return
 static void rthal_nmi_watchdog_tick(struct pt_regs *regs)
+#else /* Linux >=3D 2.6.19 */
+#define CALL_LINUX_NMI		rthal_linux_nmi_tick(regs, reason)
+#define NMI_RETURN		return 1
+static int rthal_nmi_watchdog_tick(struct pt_regs *regs, unsigned reason=
)
+#endif /* Linux >=3D 2.6.19 */
 {
 	int cpu =3D rthal_processor_id();
 	rthal_nmi_wd_t *wd =3D &rthal_nmi_wds[cpu];
@@ -125,7 +141,7 @@ static void rthal_nmi_watchdog_tick(stru
=20
 	if ((long long)(now - wd->next_linux_check) >=3D 0) {
=20
-		rthal_linux_nmi_tick(regs);
+		CALL_LINUX_NMI;
=20
 		do {
 			wd->next_linux_check +=3D RTHAL_CPU_FREQ;
@@ -150,6 +166,7 @@ static void rthal_nmi_watchdog_tick(stru
 	}
 =09
 	wrmsrl(wd->perfctr_msr, now - wd->next_linux_check);
+	NMI_RETURN;
 }
=20
 static int earlyshots_read_proc(char *page,
@@ -175,7 +192,7 @@ static int earlyshots_read_proc(char *pa
=20
 int rthal_nmi_request(void (*emergency) (struct pt_regs *))
 {
-	if (!nmi_active || !nmi_watchdog_tick)
+	if (!rthal_nmi_active || !nmi_watchdog_tick)
 		return -ENODEV;
=20
 	if (rthal_linux_nmi_tick)
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 1914)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,7 @@
+2006-12-02  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/arch/i386/nmi.c: Fix build against 2.6.19.
+
 2006-12-02  Jeff Webb <jeff.webb@domain.hid>
=20
 	* ksrc/skins/posix/syscall.c (__pse51_sem_timed_wait): Fix return


--------------040401040501010307010709--

--------------enigD328D975AA1CDC5370243814
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcWM0niDOoMHTA+kRAvdAAJ98dD2r+FckenhD4kGtctI+ECQlXgCdHLke
I2/uU6EjhKnGcWX2LfaLcnk=
=LfEd
-----END PGP SIGNATURE-----

--------------enigD328D975AA1CDC5370243814--

