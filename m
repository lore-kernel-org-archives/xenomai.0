From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 13 Sep 2006 22:24:30 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+jGCFUMTGrlw3l/"
Message-Id: <200609132224.30762.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Add --quiet option to cyclictest
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_+jGCFUMTGrlw3l/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

cyclictest emits far too much output. The attached patched makes it honour 
the '-q/--quiet' option like all the other tests.

Could somebody please review the patch and possibly apply it?

Later I really would like to propose a common schema how to pass the most 
common options to the various tests called by xeno-test. 

Best regards in advance

-- 
Niklaus Giger

--Boundary-00=_+jGCFUMTGrlw3l/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cyclictest.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="cyclictest.diff"

Index: /mnt/data.ng/hcu/kernel/xenomai-head/src/testsuite/cyclic/cyclictest.c
===================================================================
--- /mnt/data.ng/hcu/kernel/xenomai-head/src/testsuite/cyclic/cyclictest.c	(Revision 1604)
+++ /mnt/data.ng/hcu/kernel/xenomai-head/src/testsuite/cyclic/cyclictest.c	(Arbeitskopie)
@@ -309,9 +309,9 @@
 /* Print usage information */
 static void display_help(void)
 {
-	printf("cyclictest %s\n", VERSION_STRING);
+	printf("cyclictest %s (jittertest)\n", VERSION_STRING);
 	printf("Usage:\n"
-	       "jittertest <options>\n\n"
+	       "cyclictest <options>\n\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
@@ -321,6 +321,7 @@
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+	       "-q       --quiet	   minimal output\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-t NUM   --threads=NUM     number of threads: default=1\n"
@@ -337,6 +338,7 @@
 static int max_cycles;
 static int clocksel = 0;
 static int verbose;
+static int quiet;
 static int interval = 1000;
 static int distance = 500;
 
@@ -364,10 +366,11 @@
 			{"system", no_argument, NULL, 's'},
 			{"threads", required_argument, NULL, 't'},
 			{"verbose", no_argument, NULL, 'v'},
+			{"quiet", no_argument, NULL, 'q'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "b:c:d:i:l:np:rst:v",
+		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrst:v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -379,6 +382,7 @@
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'n': use_nanosleep = MODE_CLOCK_NANOSLEEP; break;
 		case 'p': priority = atoi(optarg); break;
+		case 'q': quiet = 1; break;
 		case 'r': timermode = TIMER_RELTIME; break;	
 		case 's': use_system = MODE_SYS_OFFSET; break;
 		case 't': num_threads = atoi(optarg); break;
@@ -410,7 +414,7 @@
 	struct thread_stat *stat = par->stats;
 	
 	if (!verbose) {
-		printf("T:%2d (%5d) P:%2d I:%8ld C:%8lu Min:%8ld Act:%8ld Max:%8ld\n", 
+	 	if (!quiet) printf("T:%2d (%5d) P:%2d I:%8ld C:%8lu Min:%8ld Act:%8ld Max:%8ld\n", 
 		       index, stat->tid, par->prio, par->interval,
 		       stat->cycles, stat->min, stat->act, stat->max);
 	} else {
@@ -496,7 +500,7 @@
 			len = read(fd, &lavg, 255);
 			close(fd);
 			lavg[len-1] = 0x0;
-			printf("%s          \n\n", lavg);
+			if (!quiet) printf("%s          \n\n", lavg);
 		}
 
 		for (i = 0; i < num_threads; i++) {
@@ -509,9 +513,15 @@
 		usleep(10000);
 		if (test_shutdown || allstopped == num_threads)
 			break;
-		if (!verbose)
+		if (!verbose && !quiet)
 			printf("\033[%dA", num_threads + 2);
 	}
+	if (quiet) {
+		quiet = 0; /* Now we want to output the statistics */
+		for (i = 0; i < num_threads; i++) {
+			print_stat(&par[i], i, verbose);
+		}
+	}
 	ret = 0;
  outall:
 	test_shutdown = 1;

--Boundary-00=_+jGCFUMTGrlw3l/--

