From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 29 Nov 2006 16:17:25 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FSabFY+MuQw+DIp"
Message-Id: <E1GpRBe-0001FR-Mq@domain.hid>
Subject: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--Boundary-00=_FSabFY+MuQw+DIp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the current implementation of ipipe_tsc2ns for ARM does not compile (undefined 
reference to `__udivdi3'). The attached patch fixes that.

--
Sebastian

--Boundary-00=_FSabFY+MuQw+DIp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ipipe-arm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-arm.patch"

--- ipipe/v2.6/common/include/asm-arm/ipipe.h	2006-11-29 16:06:33.000000000 +0100
+++ ipipe.work/v2.6/common/include/asm-arm/ipipe.h	2006-11-29 16:08:30.000000000 +0100
@@ -124,7 +124,12 @@ extern void __ipipe_mach_demux_irq(unsig
 #define __ipipe_read_timebase()		__ipipe_mach_get_tsc()
 
 #define ipipe_cpu_freq()	(HZ * __ipipe_mach_ticks_per_jiffy)
-#define ipipe_tsc2ns(t)		(((t) * 1000) / (ipipe_cpu_freq() / 1000000))
+#define ipipe_tsc2ns(t) \
+({ \
+	unsigned long long delta = (t)*1000; \
+	do_div(delta, ipipe_cpu_freq() / 1000000 + 1); \
+	(unsigned long)delta; \
+})
 
 /* Private interface -- Internal use only */
 

--Boundary-00=_FSabFY+MuQw+DIp--

