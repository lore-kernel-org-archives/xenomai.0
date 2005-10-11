Message-ID: <434BCC9E.5070109@domain.hid>
Date: Tue, 11 Oct 2005 17:30:54 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080608000703080900030704"
Subject: [Xenomai-core] PATCH: fix ppc64 calibration
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

This is a multi-part message in MIME format.
--------------080608000703080900030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The old calibration value was from some ancient ppc32 embedded board, I 
guess. This reflects the awesome power of them ppc64 boxen better :)

-- Heikki Lindholm

--------------080608000703080900030704
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-ppc64-calibration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-ppc64-calibration.patch"

diff -Nru xenomai/include/nucleus/asm-ppc64/calibration.h xenomai-dev/include/nucleus/asm-ppc64/calibration.h
--- xenomai/include/nucleus/asm-ppc64/calibration.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-dev/include/nucleus/asm-ppc64/calibration.h	2005-10-11 17:10:11.000000000 +0300
@@ -32,7 +32,7 @@
 #define __sched_latency CONFIG_XENO_HW_SCHED_LATENCY
 #else
 
-#define __sched_latency 18500
+#define __sched_latency 1000
 
 #endif /* CONFIG_XENO_HW_SCHED_LATENCY */
 

--------------080608000703080900030704--

