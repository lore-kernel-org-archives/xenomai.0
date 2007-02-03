Message-ID: <45C4CBB2.9040409@domain.hid>
Date: Sat, 03 Feb 2007 18:51:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm over x86_64
References: <200702031313.20104.paul_c@domain.hid> <45C4A580.3000904@domain.hid>
	<1170517558.8282.4.camel@domain.hid>
In-Reply-To: <1170517558.8282.4.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3EF7EA6E08E247671190681"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3EF7EA6E08E247671190681
Content-Type: multipart/mixed; boundary="------------070506090601060809010707"

This is a multi-part message in MIME format.
--------------070506090601060809010707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2007-02-03 at 16:08 +0100, Jan Kiszka wrote:
>=20
>> But first I need some build environment. A quick shot ended here when
>> trying to configure a patch and prepared 2.6.19 kernel:
>>
>> # make ARCH=3Dx86_64 CC=3D"gcc -m64" oldconfig
>> ...
>> init/Kconfig:572: can't open file "arch/x86_64/xenomai/Kconfig"
>>
>> Anyone any idea? Is something missing, or is the prepare script broken=
?
>=20
> It's a bit early for building the x86_64 stack; you may want to fix the=

> compilation issues over ppc64 or ia64. I'm working on the missing x86_6=
4
> bits (task switching and a few other details) before even starting to
> fix the build issues.
>=20

OK, I'm just lacking cross-compilers for other 64-bit archs.

Anyway, here is a first patch for the signedness/width issue of RTDM
IOCTLs. It unfortunately slightly breaks the driver API, but it looks
like it's required for 64-bit support (no IOCTL based on _IOR or _IOWR
should be accepted ATM).

Whoever has a full 64-bit environment is welcome to build and run this
(e.g. using xeno_timerbench). Feedback welcome. Will then commit this
chunk. Meanwhile I'm going to meditate about what to do /wrt 2.3...

Jan

--------------070506090601060809010707
Content-Type: text/plain;
 name="rtdm-ioctl64-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-ioctl64-fix.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(Revision 2106)
+++ include/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -198,7 +198,7 @@ typedef
 typedef
     int     (*rtdm_ioctl_handler_t)  (struct rtdm_dev_context   *context=
,
                                       rtdm_user_info_t          *user_in=
fo,
-                                      int                       request,=

+                                      unsigned int              request,=

                                       void                      *arg);
=20
 /**
Index: ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/core.c	(Revision 2106)
+++ ksrc/skins/rtdm/core.c	(Arbeitskopie)
@@ -403,9 +403,9 @@ int _rtdm_ioctl(rtdm_user_info_t *user_i
     arg =3D va_arg(args, void *);
     va_end(args);
=20
-    MAJOR_FUNCTION_WRAPPER_TH(ioctl, request, arg);
+    MAJOR_FUNCTION_WRAPPER_TH(ioctl, (unsigned int)request, arg);
=20
-    if (unlikely(ret < 0) && request =3D=3D RTIOC_DEVICE_INFO) {
+    if (unlikely(ret < 0) && (unsigned int)request =3D=3D RTIOC_DEVICE_I=
NFO) {
         struct rtdm_device *dev =3D context->device;
         struct rtdm_device_info dev_info;
=20
Index: ksrc/drivers/serial/16550A.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/serial/16550A.c	(Revision 2106)
+++ ksrc/drivers/serial/16550A.c	(Arbeitskopie)
@@ -550,7 +550,8 @@ int rt_16550_close(struct rtdm_dev_conte
=20
=20
 int rt_16550_ioctl(struct rtdm_dev_context *context,
-                   rtdm_user_info_t *user_info, int request, void *arg)
+                   rtdm_user_info_t *user_info,
+                   unsigned int request, void *arg)
 {
     struct rt_16550_context *ctx;
     int                     err =3D 0;
Index: ksrc/drivers/can/rtcan_raw.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/rtcan_raw.c	(Revision 2106)
+++ ksrc/drivers/can/rtcan_raw.c	(Arbeitskopie)
@@ -412,7 +412,8 @@ static int rtcan_raw_setsockopt(struct r
=20
=20
 int rtcan_raw_ioctl(struct rtdm_dev_context *context,
-		    rtdm_user_info_t *user_info, int request, void *arg)
+		    rtdm_user_info_t *user_info,
+		    unsigned int request, void *arg)
 {
     int ret =3D 0;
=20
Index: ksrc/drivers/testing/timerbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/testing/timerbench.c	(Revision 2106)
+++ ksrc/drivers/testing/timerbench.c	(Arbeitskopie)
@@ -234,7 +234,8 @@ int rt_tmbench_close(struct rtdm_dev_con
=20
=20
 int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
-                         rtdm_user_info_t *user_info, int request, void =
*arg)
+                         rtdm_user_info_t *user_info,
+                         unsigned int request, void *arg)
 {
     struct rt_tmbench_context   *ctx;
     int                         err =3D 0;
@@ -413,7 +414,8 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
=20
=20
 int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
-                        rtdm_user_info_t *user_info, int request, void *=
arg)
+                        rtdm_user_info_t *user_info,
+                        unsigned int request, void *arg)
 {
     struct rt_tmbench_context   *ctx;
     int                         err =3D 0;
Index: ksrc/drivers/testing/switchtest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/testing/switchtest.c	(Revision 2106)
+++ ksrc/drivers/testing/switchtest.c	(Arbeitskopie)
@@ -389,7 +389,7 @@ static int rtswitch_close(struct rtdm_de
=20
 static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
                               rtdm_user_info_t *user_info,
-                              int request,
+                              unsigned int request,
                               void *arg)
 {
 	rtswitch_context_t *ctx =3D (rtswitch_context_t *) context->dev_private=
;
@@ -492,7 +492,7 @@ static int rtswitch_ioctl_nrt(struct rtd
=20
 static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
                              rtdm_user_info_t *user_info,
-                             int request,
+                             unsigned int request,
                              void *arg)
 {
 	rtswitch_context_t *ctx =3D (rtswitch_context_t *) context->dev_private=
;
Index: ksrc/drivers/testing/irqbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/testing/irqbench.c	(Revision 2106)
+++ ksrc/drivers/testing/irqbench.c	(Arbeitskopie)
@@ -237,8 +237,8 @@ static int rt_irqbench_close(struct rtdm
 }
=20
 static int rt_irqbench_ioctl_nrt(struct rtdm_dev_context *context,
-				 rtdm_user_info_t *user_info, int request,
-				 void *arg)
+				 rtdm_user_info_t *user_info,
+				 unsigned int request, void *arg)
 {
 	struct rt_irqbench_context *ctx;
 	struct rttst_irqbench_config config_buf;
@@ -435,8 +435,8 @@ static int rt_irqbench_ioctl_nrt(struct=20
 }
=20
 static int rt_irqbench_ioctl_rt(struct rtdm_dev_context *context,
-				rtdm_user_info_t *user_info, int request,
-				void *arg)
+				rtdm_user_info_t *user_info,
+				unsigned int request, void *arg)
 {
 	struct rt_irqbench_context *ctx;
 	int err =3D 0;

--------------070506090601060809010707--

--------------enigE3EF7EA6E08E247671190681
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFxMuzniDOoMHTA+kRAmwrAJ0TM9UxXlOYCi7PmT6oPD1vIchZnQCeLKNz
5moEMQFiBeBnVNenZqA/+UI=
=HXVc
-----END PGP SIGNATURE-----

--------------enigE3EF7EA6E08E247671190681--

