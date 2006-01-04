Message-ID: <43BBF920.80906@domain.hid>
Date: Wed, 04 Jan 2006 17:34:40 +0100
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe + latency tracing patch
References: <43B5658D.3030004@domain.hid>	<43B58FED.6070404@domain.hid>	<43B5AB49.7040704@domain.hid>	<43B5B0A1.6030409@domain.hid>
	<43B6569D.30506@domain.hid> <43BA977F.9040303@domain.hid>
In-Reply-To: <43BA977F.9040303@domain.hid>
Content-Type: multipart/mixed; boundary="------------060301040901090904070501"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060301040901090904070501
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,
As I've noticed, the tracer ist still not compeletly in the SVN trunk.
Thus it causes some problems (missing header files) while compiling the
timer Benchmark module.
Here is a small patch, which fix this problem.

Cheers
Luotao Fu

--------------060301040901090904070501
Content-Type: text/x-patch;
 name="fix_timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_timer.patch"

diff -uNr xenomai/ksrc/drivers/benchmark/timerbench.c xenomai-wd/ksrc/drivers/benchmark/timerbench.c
--- xenomai/ksrc/drivers/benchmark/timerbench.c 2006-01-04 16:22:05.000000000 +0100
+++ xenomai-wd/ksrc/drivers/benchmark/timerbench.c      2006-01-04 17:23:00.000000000 +0100
@@ -18,7 +18,9 @@

 #include <linux/module.h>
 #include <asm/semaphore.h>
-#include <linux/ipipe_trace.h>
+#ifdef CONFIG_IPIPE_TRACE
+ #include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE */

 #include <xenomai/rtdm/rtbenchmark.h>
 #include <xenomai/rtdm/rtdm_driver.h>


--------------060301040901090904070501--

