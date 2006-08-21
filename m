Message-ID: <44E9EE06.8010303@domain.hid>
Date: Mon, 21 Aug 2006 11:31:50 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: xeno-load: line 182: 2794
	Floating	point	exception$suflag $* $cmdargs
References: <44E91231.8070403@domain.hid>	<44E955E0.40009@domain.hid>	<1156143410.4723.4.camel@domain.hid>	<44E9663C.2030904@domain.hid>
	<17641.43126.189924.769218@domain.hid>
In-Reply-To: <17641.43126.189924.769218@domain.hid>
Content-Type: multipart/mixed; boundary="------------040706080902040703080000"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040706080902040703080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
>
> You likely have a division by 0 because nsamples is 0. nsamples come
> from the numeric argument of the -n option, and I think you do not pass
> a numeric argument to -n, so atoi returns 0.
>
>   

Yup, thats it.

prog was getting -n -l 1000
-l is illegal option, but -n needs an arg, and -l became it, and 
converts to 0.
so no error caused by -l either !

attached patch does:

xeno-test:     drop most options passed to switchbench,, added -h
switchbench:
    - sanity check on nsamples.
    - 1st column labels on Histogram
    - compute statistics (sort of -  I couldnt get 'sqrt' to link..)



Also, I recall at one time, one of the testsuite progs was intended
to be run in either xenomai, or in plain kernel.
Is this still the case ?
Or has it been superseded, forex by latency's  -t [0-3] options ?
If it is, should xeno-test run them that way as well ?

FWIW, I always found that distinction
too mysterious to not have an explicit option, along with errors
explaining 'insufficient privilege to run in RT-mode' as necessary.


--------------040706080902040703080000
Content-Type: text/plain;
 name="patch.swbench"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.swbench"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1487)
+++ scripts/xeno-test.in	(working copy)
@@ -200,7 +200,7 @@
 	loudly ./run -- -T 120 $XENOT_SWITCHTEST '# switchtest'
     )
     (	cd `dirname $0`/../testsuite/switchbench
-	loudly ./run -- -p 10 -n -l 1000 $XENOT_SWITCHBENCH '# switchbench'
+	loudly ./run -- -h $XENOT_SWITCHBENCH '# switchbench'
     )
     (	cd `dirname $0`/../testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 $XENOT_CYCLIC '# cyclictest'
Index: src/testsuite/switchbench/switchbench.c
===================================================================
--- src/testsuite/switchbench/switchbench.c	(revision 1487)
+++ src/testsuite/switchbench/switchbench.c	(working copy)
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <math.h>
 #include <stdio.h>
 #include <string.h>
 #include <signal.h>
@@ -43,17 +44,42 @@
 	histogram[inabs < HISTOGRAM_CELLS ? inabs : HISTOGRAM_CELLS - 1]++;
 }
 
-void dump_histogram(void)
+void dump_stats(double sum, int total_hits)
 {
-       int n;
+	int n;
+	double avg, variance = 0;
 
-       for (n = 0; n < HISTOGRAM_CELLS; n++) {
-               long hits = histogram[n];
-               if (hits)
-                       fprintf(stderr, "%d - %d us: %ld\n", n, n + 1, hits);
-       }
+	avg = sum / total_hits;
+	for (n = 0; n < HISTOGRAM_CELLS; n++) {
+		long hits = histogram[n];
+		if (hits)
+			variance += hits * (n-avg) * (n-avg);
+	}
+
+	/* compute std-deviation (unbiased form) */
+	variance /= total_hits - 1;
+	// variance = sqrt(variance);
+	
+	printf("HSS| %9d| %10.3f| %10.3f\n", total_hits, avg, variance);
 }
 
+void dump_histogram(void)
+{
+	int n, total_hits = 0;
+	double sum = 0;
+	fprintf(stderr, "---|---range-|---samples\n");
+	for (n = 0; n < HISTOGRAM_CELLS; n++) {
+		long hits = histogram[n];
+		if (hits) {
+			total_hits += hits;
+			sum += n * hits;
+			fprintf(stderr, "HSD| %d - %d | %10ld\n",
+				n, n + 1, hits);
+		}
+	}
+	dump_stats(sum, total_hits);
+}
+
 void event(void *cookie)
 {
        int err;
@@ -180,8 +206,14 @@
                }
 
        if (sampling_period == 0)
-               sampling_period = 100000;       /* ns */
+               sampling_period = 100000;	/* ns */
 
+       if (nsamples <= 0) {
+	       fprintf(stderr, "disregarding -n <%lld>, using -n <100> us\n",
+		       nsamples);
+               nsamples = 100000;		/* ns */
+       }
+
        signal(SIGINT, SIG_IGN);
        signal(SIGTERM, SIG_IGN);
 

--------------040706080902040703080000--

