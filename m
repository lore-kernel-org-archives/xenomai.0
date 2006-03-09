From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
MIME-Version: 1.0
Date: Thu, 9 Mar 2006 01:30:09 +0100
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Rc3DEpsCdRRhn06"
Message-Id: <200603090130.09536.Sebastian.Smolorz@domain.hid>
Subject: [Xenomai-core] [PATCH] Small doc fix for rtbenchmark.h
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

--Boundary-00=_Rc3DEpsCdRRhn06
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan,

here is a fix for the following doxygen warning:

xenomai/include/rtdm/rtbenchmark.h:146: Warning: end of file while inside a 
group

Sebastian

--Boundary-00=_Rc3DEpsCdRRhn06
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rtbench.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtbench.patch"

--- xenomai/include/rtdm/rtbenchmark.h	2006-03-09 01:13:40.000000000 +0100
+++ rtbenchmark.h	2006-03-09 01:13:24.000000000 +0100
@@ -138,6 +138,7 @@ typedef struct rtbnch_trace_special {
 
 #define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
     _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
+/** @} */
 
 /** @} */
 

--Boundary-00=_Rc3DEpsCdRRhn06--

