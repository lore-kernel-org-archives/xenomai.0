Message-ID: <44DCAE6B.4010608@domain.hid>
Date: Fri, 11 Aug 2006 10:20:59 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44DBCCD3.5070505@domain.hid> <44DC2B80.1020403@domain.hid>
In-Reply-To: <44DC2B80.1020403@domain.hid>
Content-Type: multipart/mixed; boundary="------------010306090609030502020905"
Subject: [Xenomai-core] [patches] 1-bundle-email-spelling-help
	2-rfc-add-newer-bench-tests
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
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010306090609030502020905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Jim Cromie wrote:
>   
>> im trying to inline this patch,
>> pls let me know if its still ws fouled
>> (in thunderbird, cp from svn diff |less, preformat b4 paste)
>>
>>
>>
>>
>> Index: CREDITS
>> ===================================================================
>> --- CREDITS     (revision 1412)
>> +++ CREDITS     (working copy)
>> @@ -43,7 +43,7 @@
>> D: the map.
>>
>> N: Jim Cromie
>> -E: jcromie@domain.hid
>> +E: jim.cromie@domain.hid
>> D: Comprehensive statistics collection for the testsuite.
>> D: Validation test script. Various script fixes and sanitization.
>>     
>
> Obviously damaged, at least here on the list (leading single whitespace
> missing in unmodified lines). This also applies to your second patch.
>
> The required steps with Thunderbird are: 1. start a new mail or reply as
> HTML (bah!), 2. set the text style of everything to preformat, 3. switch
> back to "Plain Text Only" under Options/Format. Hope somebody will once
> hack a plugin for disabling line wrapping on demand without this dance...
>
>   
<marge-simpson-voice>  HRMM
maybe copy-src is the factor - Ive had luck my way (which yours sounds like)
when cpying the diff from an emacs window.

No Matter  ( machts nichts, or after americanization,  MoxNix  )
attachments are easier anyway, and RPM seems not to care either way.

So, 2 patches:

1- bundle: email, Kconfig spelling, switchbench print in us, not ns.
issues :
- switchbench segfaults(iirc) for me - both before and after patch,
so its not tested - and printf format purposely not tweaked, so as
to give someone else the itch ;-)


2 -  add newer benchmark tests to xeno-test  RFC
- irqbench (all 4 ways)
- switchbench - segfaults
- switchtest
by the way, could we get renames ? 
    switch{,bench,test}/switch.c
    is just unnecessarily confusing !

issues :
- are tests ready to add ?  perhaps, if optional ?
- config dependence ignored
    we have no guarantee of .config availability (or do we?)
- XENOT_*  for tool(*) specific option setting from env
        warrants better prefix, but XENOTEST_TOPTS_* seemed too much

thanks
-jimc

--------------010306090609030502020905
Content-Type: text/plain;
 name="diff.bundle"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.bundle"

Index: src/testsuite/switchbench/switch.c
===================================================================
--- src/testsuite/switchbench/switch.c	(revision 1416)
+++ src/testsuite/switchbench/switch.c	(working copy)
@@ -38,8 +38,9 @@
 
 static inline void add_histogram(long addval)
 {
-       long inabs = rt_timer_tsc2ns(addval >= 0 ? addval : -addval) / 1000;  /* usec steps */
-       histogram[inabs < HISTOGRAM_CELLS ? inabs : HISTOGRAM_CELLS - 1]++;
+	/* usec steps */
+	long inabs = rt_timer_tsc2ns(addval >= 0 ? addval : -addval) / 1000;
+	histogram[inabs < HISTOGRAM_CELLS ? inabs : HISTOGRAM_CELLS - 1]++;
 }
 
 void dump_histogram(void)
@@ -134,10 +135,10 @@
        printf("RTH|%12s|%12s|%12s|%12s\n",
                       "lat min", "lat avg", "lat max", "lost");
 
-       printf("RTD|%12Ld|%12Ld|%12Ld|%12lld\n",
-                      rt_timer_tsc2ns(minjitter),
-                      rt_timer_tsc2ns(avgjitter),
-                      rt_timer_tsc2ns(maxjitter), lost);
+       printf("RTD|%12.3f|%12.3f|%12.3f|%12lld\n",
+                      rt_timer_tsc2ns(minjitter) / 1000,
+                      rt_timer_tsc2ns(avgjitter) / 1000,
+                      rt_timer_tsc2ns(maxjitter) / 1000, lost);
 
        if (do_histogram)
                dump_histogram();
Index: CREDITS
===================================================================
--- CREDITS	(revision 1416)
+++ CREDITS	(working copy)
@@ -43,7 +43,7 @@
 D: the map.
 
 N: Jim Cromie
-E: jcromie@domain.hid
+E: jim.cromie@domain.hid
 D: Comprehensive statistics collection for the testsuite.
 D: Validation test script. Various script fixes and sanitization.
 
Index: ksrc/arch/i386/Kconfig
===================================================================
--- ksrc/arch/i386/Kconfig	(revision 1416)
+++ ksrc/arch/i386/Kconfig	(working copy)
@@ -67,13 +67,13 @@
         and hence may not be altered.
 
         For this reason, Xenomai contains code to detect chipsets using
-        SMIs and optionnaly activate some workarounds to stop SMIs.
+        SMIs and optionally activate some workarounds to stop SMIs.
         
-        Enabling this option will cause Xenomai not to try and detect whether 
+        Enabling this option prevents Xenomai from detecting whether 
         your hardware use SMIs. This option is mostly useful if you know
         that your system does not use SMIs and really want to size Xenomai 
         modules down. The detection code has no run-time space overhead,
-        only disk-space overhead.
+        and a tiny memory footprint (<200 bytes on x86)
 
 config XENO_HW_SMI_DETECT
         bool
@@ -98,7 +98,7 @@
         and hence may not be altered.
 
         For this reason, Xenomai contains code to detect chipsets using
-        SMIs and optionnaly activate some workarounds to stop SMIs.
+        SMIs and optionally activate some workarounds to stop SMIs.
         Enabling this option cause those workarounds to be activated.
 
 if XENO_HW_SMI_WORKAROUND

--------------010306090609030502020905
Content-Type: text/plain;
 name="diff.xt-add-benchs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.xt-add-benchs"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1416)
+++ scripts/xeno-test.in	(working copy)
@@ -190,16 +192,30 @@
     boxstatus
     (
         cd `dirname $0`/../testsuite/latency
-	loudly ./run --  $opts -t0
-	loudly ./run --  $opts -t1
-	loudly ./run --  $opts -t2
+	loudly ./run -- $XENOT_LAT $opts -t0 '# latency'
+	loudly ./run -- $XENOT_LAT $opts -t1 '# latency'
+	loudly ./run -- $XENOT_LAT $opts -t2 '# latency'
     )
+
     (	cd `dirname $0`/../testsuite/switch
-	loudly ./run --  '# switch'
+	loudly ./run --  $XENOT_SWITCH '# switch'
     )
+    (	cd `dirname $0`/../testsuite/switchbench
+	loudly ./run -- -p 10 -n -l 1000 $XENOT_SWITCHBENCH '# switchbench'
+    )
+    (	cd `dirname $0`/../testsuite/switchtest
+	loudly ./run -- -n $XENOT_SWITCHTEST '# switchtest'
+    )
+
     (	cd `dirname $0`/../testsuite/cyclic
-	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
+	loudly ./run -- -p 10 -n -l 1000  $XENOT_CYCLIC '# cyclictest'
     )
+    (	cd `dirname $0`/../testsuite/irqbench
+	loudly ./run -- -P 10 $XENOT_IRQBENCH -t0 '# irqbench user'
+	loudly ./run -- -P 10 $XENOT_IRQBENCH -t1 '# irqbench kernel'
+	loudly ./run -- -P 10 $XENOT_IRQBENCH -t2 '# irqbench irq-handler'
+	loudly ./run -- -P 10 $XENOT_IRQBENCH -t3 '# irqbench hard-irq-handler'
+    )
     boxstatus
     cleanup_load
 }

--------------010306090609030502020905--

