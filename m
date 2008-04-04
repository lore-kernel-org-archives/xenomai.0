Message-ID: <47F606AE.6080800@domain.hid>
Date: Fri, 04 Apr 2008 12:45:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>
	<47F5E57C.6020309@domain.hid>
In-Reply-To: <47F5E57C.6020309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6A88E85F476FB514DCCEBF4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6A88E85F476FB514DCCEBF4
Content-Type: multipart/mixed;
 boundary="------------030600030800030201070201"

This is a multi-part message in MIME format.
--------------030600030800030201070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> This patch may do the trick: it uses the inverted tsc-to-ns function=
=20
>>>> instead of the frequency-based one. Be warned, it is totally=20
>>>> untested inside Xenomai, I just ran it in a user space test program.=
=20
>>>> But it may give an idea.
>>>
>>> Your patch needed two minor corrections (ns instead of ts in=20
>>> functions xnarch_ns_to_tsc()) in order to compile. A short run (30=20
>>> minutes) of latency -t1 seems to prove your bug-fix: There seems to=20
>>> be no drift.
>>
>> That's good to hear.
>>
>>> If I got your patch correctly, it doesn't make xnarch_tsc_to_ns more =

>>> precise but introduces a new function xnarch_ns_to_tsc() which is=20
>>> also less precise than the generic xnarch_ns_to_tsc(), right?
>>
>> Yes. It is now precisely the inverse imprecision, so to say. :)
>>
>>> So isn't there still the danger of getting wrong values when calling =

>>> xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
>>
>> Only if the user decides to implement his own conversion. Xenomai with=
=20
>> all its skins and both in kernel and user space should always run=20
>> through the xnarch_* path.
>=20
> OK, would you commit the patch?

Will do unless someone else has concerns. Gilles, Philippe? ARM and=20
Blackfin then need to be fixed similarly, full patch attached.

Jan

--------------030600030800030201070201
Content-Type: text/x-patch;
 name="fixup-scaled-ns2tsc-conversion.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fixup-scaled-ns2tsc-conversion.patch"

---
 ChangeLog                        |    7 +++++++
 include/asm-arm/bits/init.h      |    3 ++-
 include/asm-arm/bits/pod.h       |    7 +++++++
 include/asm-blackfin/bits/init.h |    3 ++-
 include/asm-blackfin/bits/pod.h  |    7 +++++++
 include/asm-x86/bits/init_32.h   |    3 ++-
 include/asm-x86/bits/init_64.h   |    3 ++-
 include/asm-x86/bits/pod_32.h    |    7 +++++++
 include/asm-x86/bits/pod_64.h    |    7 +++++++
 9 files changed, 43 insertions(+), 4 deletions(-)

Index: b/include/asm-x86/bits/init_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/bits/init_32.h
+++ b/include/asm-x86/bits/init_32.h
@@ -73,7 +73,7 @@ int xnarch_calibrate_sched(void)
=20
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
=20
 	err =3D rthal_init();
@@ -89,6 +89,7 @@ static inline int xnarch_init(void)
=20
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide =3D 1 << xnarch_tsc_shift;
=20
 	err =3D xnarch_calibrate_sched();
=20
Index: b/include/asm-x86/bits/init_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/bits/init_64.h
+++ b/include/asm-x86/bits/init_64.h
@@ -70,7 +70,7 @@ int xnarch_calibrate_sched(void)
=20
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
=20
 	err =3D rthal_init();
@@ -86,6 +86,7 @@ static inline int xnarch_init(void)
=20
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide =3D 1 << xnarch_tsc_shift;
=20
 	err =3D xnarch_calibrate_sched();
=20
Index: b/include/asm-x86/bits/pod_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/bits/pod_32.h
+++ b/include/asm-x86/bits/pod_32.h
@@ -25,6 +25,7 @@
=20
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
=20
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -32,6 +33,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
=20
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>
=20
Index: b/include/asm-x86/bits/pod_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/bits/pod_64.h
+++ b/include/asm-x86/bits/pod_64.h
@@ -24,6 +24,7 @@
=20
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
=20
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -31,6 +32,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
=20
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>
=20
Index: b/include/asm-arm/bits/init.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-arm/bits/init.h
+++ b/include/asm-arm/bits/init.h
@@ -67,7 +67,7 @@ int xnarch_calibrate_sched(void)
=20
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
=20
 	err =3D rthal_init();
@@ -77,6 +77,7 @@ static inline int xnarch_init(void)
=20
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide =3D 1 << xnarch_tsc_shift;
=20
 	err =3D xnarch_calibrate_sched();
=20
Index: b/include/asm-arm/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-arm/bits/pod.h
+++ b/include/asm-arm/bits/pod.h
@@ -25,6 +25,7 @@
=20
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
=20
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -32,6 +33,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
=20
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
=20
 void xnpod_welcome_thread(struct xnthread *, int);
Index: b/include/asm-blackfin/bits/init.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-blackfin/bits/init.h
+++ b/include/asm-blackfin/bits/init.h
@@ -66,7 +66,7 @@ int xnarch_calibrate_sched(void)
=20
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
=20
 	__ipipe_irq_tail_hook =3D (unsigned long)&xnpod_schedule_deferred;
@@ -84,6 +84,7 @@ static inline int xnarch_init(void)
=20
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide =3D 1 << xnarch_tsc_shift;
=20
 	err =3D xnarch_calibrate_sched();
=20
Index: b/include/asm-blackfin/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-blackfin/bits/pod.h
+++ b/include/asm-blackfin/bits/pod.h
@@ -22,6 +22,7 @@
=20
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
=20
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -29,6 +30,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
=20
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
=20
 void xnpod_welcome_thread(struct xnthread *, int);
Index: b/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,10 @@
+2008-04-04  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/asm-*/{pod.h,init.h}: Introduce arch-specific
+	xnarch_ns_to_tsc as inverse of mul-shift xnarch_tsc_to_ns instead
+	of converting back via CPU frequency. Avoids drifts between large
+	calculated versus measured dates.
+
 2008-04-02  Philippe Gerum  <rpm@xenomai.org>
=20
 	* include/asm-generic/bits/mlock_alert.h:

--------------030600030800030201070201--

--------------enigB6A88E85F476FB514DCCEBF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9gayniDOoMHTA+kRAqUjAJ98Z7VEtm9NDAGBWsynju3Fgn+vZgCfTZ0Q
VJDCN/PE4h2we2OjElB7Qww=
=oZWX
-----END PGP SIGNATURE-----

--------------enigB6A88E85F476FB514DCCEBF4--

