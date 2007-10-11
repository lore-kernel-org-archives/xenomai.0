Message-ID: <470E1FF3.6010606@domain.hid>
Date: Thu, 11 Oct 2007 15:06:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040302030203010303020300"
Subject: [Adeos-main] [PATCH 2/4] tracer: tune defaults
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------040302030203010303020300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Set more common default values for the back-trace length and the tracer
verbosity.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------040302030203010303020300
Content-Type: text/x-patch;
 name="tune-tracer-defaults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tune-tracer-defaults.patch"

---
 kernel/ipipe/tracer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22.9/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.22.9.orig/kernel/ipipe/tracer.c
+++ linux-2.6.22.9/kernel/ipipe/tracer.c
@@ -43,7 +43,7 @@
 
 #define IPIPE_DEFAULT_PRE_TRACE     10
 #define IPIPE_DEFAULT_POST_TRACE    10
-#define IPIPE_DEFAULT_BACK_TRACE    30
+#define IPIPE_DEFAULT_BACK_TRACE    100
 
 #define IPIPE_DELAY_NOTE            1000  /* in nanoseconds */
 #define IPIPE_DELAY_WARN            10000 /* in nanoseconds */
@@ -127,7 +127,7 @@ static IPIPE_DEFINE_SPINLOCK(global_path
 static int pre_trace = IPIPE_DEFAULT_PRE_TRACE;
 static int post_trace = IPIPE_DEFAULT_POST_TRACE;
 static int back_trace = IPIPE_DEFAULT_BACK_TRACE;
-static int verbose_trace;
+static int verbose_trace = 1;
 static unsigned long trace_overhead;
 
 static DEFINE_MUTEX(out_mutex);



--------------040302030203010303020300--

