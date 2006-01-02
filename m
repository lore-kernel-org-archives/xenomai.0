Message-ID: <43B97CEE.4030800@domain.hid>
Date: Mon, 02 Jan 2006 20:20:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] in-kernel timer benchmark -v3
References: <43B92741.8030609@domain.hid> <43B970BA.3080707@domain.hid>
In-Reply-To: <43B970BA.3080707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2B9DECC08A8A70FFC85410A"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2B9DECC08A8A70FFC85410A
Content-Type: multipart/mixed; boundary="------------010404010306050807020400"

This is a multi-part message in MIME format.
--------------010404010306050807020400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

...as a follow-up, here is a patch to fix some bugs in the new trace
triggering and to improve (from my POV) the output of this tool in some
regards.

Jan

--------------010404010306050807020400
Content-Type: text/x-patch;
 name="latency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="latency.patch"

Index: src/testsuite/latency/latency.c
===================================================================
--- src/testsuite/latency/latency.c	(Revision 345)
+++ src/testsuite/latency/latency.c	(Arbeitskopie)
@@ -39,6 +39,11 @@
 #define TIMER_HANDLER   2
 
 int test_mode = USER_TASK;
+const char *test_mode_names[] = {
+    "periodic user-mode task",
+    "in-kernel periodic task",
+    "in-kernel timer handler"
+};
 
 time_t test_start, test_end;    /* report test duration */
 int test_loops = 0;             /* outer loop count */
@@ -78,8 +83,7 @@
         return;
         }
 
-    if (freeze_threshold > 0)
-        freeze_threshold = rt_timer_ns2tsc(freeze_threshold*1000);
+    freeze_threshold = rt_timer_ns2tsc(freeze_threshold);
 
     nsamples = ONE_BILLION / period_ns;
     period_tsc = rt_timer_ns2tsc(period_ns);
@@ -122,11 +126,15 @@
             if (dt < minj) minj = dt;
             sumj += dt;
 
-            if ((freeze_threshold > 0) && (dt > freeze_threshold))
-                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_FREEZE_TRACE, freeze_threshold);
+            if (!(finished || warmup))
+                {
+                if ((freeze_threshold > 0) && (dt > freeze_threshold))
+                    rt_dev_ioctl(benchdev, RTBNCH_RTIOC_FREEZE_TRACE,
+                                 freeze_threshold);
 
-            if (!(finished || warmup) && (do_histogram || do_stats))
-                add_histogram(histogram_avg, dt);
+                if (do_histogram || do_stats)
+                    add_histogram(histogram_avg, dt);
+                }
             }
 
         if(!warmup)
@@ -173,8 +181,6 @@
             return;
             }
 
-        printf("== Test mode: periodic userspace task\n");
-
     } else {
         struct rtbnch_timerconfig   config;
 
@@ -196,13 +202,13 @@
             fprintf(stderr,"latency: failed to start in-kernel timer benchmark, code %d\n",err);
             return;
             }
-
-        printf("== Test mode: in-kernel %s\n",
-               (test_mode == TIMER_HANDLER) ? "timer handler" : "periodic task");
     }
 
     time(&start);
 
+    if (WARMUP_TIME)
+        printf("warming up...\n");
+
     if (quiet)
         fprintf(stderr, "running quietly for %d seconds\n", test_duration);
 
@@ -256,8 +262,9 @@
                 time_t now, dt;
                 time(&now);
                 dt = now - start - WARMUP_TIME;
-                printf("RTT|  %.2ld:%.2ld:%.2ld\n",
-                       dt / 3600,(dt / 60) % 60,dt % 60);
+                printf("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period)\n",
+                       dt / 3600,(dt / 60) % 60,dt % 60,
+                       test_mode_names[test_mode],period_ns / 1000);
                 printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
                        "-----lat min","-----lat avg","-----lat max","-overrun",
                        "----lat best","---lat worst");
@@ -469,7 +476,7 @@
 
             case 'f':
 
-                freeze_threshold = atoi(optarg);
+                freeze_threshold = atoi(optarg)*1000;
                 break;
 
             default:
@@ -520,7 +527,10 @@
 
     setlinebuf(stdout);
 
-    printf("== Sampling period: %Ld us\n",period_ns / 1000);
+    printf("== Sampling period: %Ld us\n"
+           "== Test mode: %s\n",
+           period_ns / 1000,
+           test_mode_names[test_mode]);
 
     mlockall(MCL_CURRENT|MCL_FUTURE);
 

--------------010404010306050807020400--

--------------enigC2B9DECC08A8A70FFC85410A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuXzuniDOoMHTA+kRAr+vAJ94ewd9O7m3alpTYbCwo62mOI9hzwCeIea5
QnAg1mUcj6K8JA2gxjYhFEY=
=9tCS
-----END PGP SIGNATURE-----

--------------enigC2B9DECC08A8A70FFC85410A--

