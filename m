From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 25 Oct 2006 11:55:44 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gSzPFnFsVHrJ0hI"
Message-Id: <E1GcfU9-000153-3Q@mailer.emlix.com>
Subject: [Xenomai-core] [PATCH] Missing ; in include/asm-arm/calibration.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_gSzPFnFsVHrJ0hI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

on my quest to find the bug in the I-pipe patch for the S3C24xx (got the root 
of the problem now, information will soon follow) I detected a missing 
semicolon in xenomai/include/asm-arm/calibration.h. See attachment.

Sebastian

--Boundary-00=_gSzPFnFsVHrJ0hI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="arm_calibr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arm_calibr.patch"

Index: xenomai-svn/include/asm-arm/calibration.h
===================================================================
--- xenomai-svn/include/asm-arm/calibration.h	(Revision 1749)
+++ xenomai-svn/include/asm-arm/calibration.h	(Arbeitskopie)
@@ -28,7 +28,7 @@
 static inline unsigned long xnarch_get_sched_latency (void)
 {
 #if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
-	return CONFIG_XENO_OPT_TIMING_SCHEDLAT
+    return CONFIG_XENO_OPT_TIMING_SCHEDLAT;
 #else
     return 9500;	/* XXX sane ? */
 #endif

--Boundary-00=_gSzPFnFsVHrJ0hI--

