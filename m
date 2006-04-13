Message-ID: <443E4F7D.6090103@domain.hid>
Date: Thu, 13 Apr 2006 09:17:49 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running testsuite
References: <200604131149.40706.tmarscha@domain.hid>
In-Reply-To: <200604131149.40706.tmarscha@domain.hid>
Content-Type: multipart/mixed; boundary="------------080208030904020701080808"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tobias Marschall <tmarscha@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080208030904020701080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tobias Marschall wrote:
> Hallo,
>
> I've been using rtai until now and decided to give xenomai (release 2.1) a 
> try. I followed the instructions from README.INSTALL, and everything (kernel 
> patching, compilation, etc.) went fine. Then I tried to run the latency test, 
> which failed:
>
> -----------
> /usr/xenomai/testsuite/latency $ ./run
> head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
>   

this particular error is patched, attached.





> future
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> /usr/xenomai/bin/xeno-load: line 178:  5936 Killed                  $suflag $* 
> $cmdargs
> -----------
>
> The same for "switch", the same if I call ./latency directly.
>
> Is it correct that the xeno_timerbench module is required for the latency 
> test? 
I believe that it (timerbench) is only needed for latency -t2, ICBW.
I built it as a module

> I get the same result wheter or not I load the module.
>
>   

Ive seen that Killed line before - but its been a while, I have no 
recollection...

have you tried 'run -- ' ?
the double dash insures that the following args are passed thru the script,
(so its very unlikely to matter here, but you never know ..)


heres a chunk from xeno-test on my box.
Obviously it didnt work for you, but you can re-try the running line,
see if its different than what youre currently getting.


Mon Apr 10 14:58:26 PDT 2006
running: ./run -- -T 120 -h -s -l 30 -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|      24.499|      40.854|      58.042|       0|      24.499|      
58.042
RTD|      24.746|      40.783|      57.502|       0|      24.499|      
58.042
RTD|      24.353|      40.768|      57.772|       0|      24.353|      
58.042



> What am I doing wrong?
>
>   
dunno, but I hope this is helpful til you get better answers.


> Thanks in advance and best regards,
> Tobias
>
> Some (hopefully useful) information follows:
> -----------
> /usr/xenomai/bin $ ./xeno-info
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux tobi 2.6.14 #3 PREEMPT Thu Apr 13 09:13:53 CEST 2006 i686 AMD Athlon(tm) 
> XP 1600+ AuthenticAMD GNU/Linux
>
> Gnu C                  3.3.6
> Gnu make               3.80
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.1
> e2fsprogs              1.38
> Linux C Library        2.3.5
> head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
> future
> Dynamic linker (ldd)   2.3.5
> Procps                 3.2.5
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> Modules Loaded         xeno_timerbench
> -----------
> ~ $ dmesg|grep -i xenomai
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.1 (Champagne) loaded.
> Xenomai: starting native API services.
> Xenomai: starting RTDM services.
>   

> -----------
> /usr/src/linux $ grep -3i xeno .config
> #
>   
FWIW, if you enable
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
then the xeno-test script will run that grep (ie zgrep XENO 
/proc/config.gz) for you.

there are a few additions that might be worthwhile -

 zegrep -E '^CONFIG_M|PREEMPT' pc-3/.config
CONFIG_MMU=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_M586MMX=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_MICROCODE=m
CONFIG_MII=y
CONFIG_MSDOS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_MAGIC_SYSRQ=y

I havent made them, the CONFIG_M picks up the Machine, but is perhaps 
too noisy.
THen again, MMU an MODULE_* info is useful.

--------------080208030904020701080808
Content-Type: text/plain;
 name="patch-head-n"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-head-n"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 924)
+++ scripts/xeno-test.in	(working copy)
@@ -90,7 +90,7 @@
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
     [ -n "$prepost" ] && loudly $prepost
-    loudly top -bn1c | head -$(( 12 + $workload ))
+    loudly top -bn1c | head -n $(( 12 + $workload ))
 }
 
 

--------------080208030904020701080808--

