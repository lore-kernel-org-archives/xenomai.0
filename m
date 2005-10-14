Message-ID: <25291.193.52.24.125.1129321138.squirrel@domain.hid>
Date: Fri, 14 Oct 2005 22:18:58 +0200 (CEST)
Subject: [Fwd: Re: [Xenomai-help] Xenomai -> PPC]
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi:

thanks for the help. This is a short report of that happen.

I run the /testsuite/latency/run test

dmesg reports the correct loading of modules

.....
Adeos: Domain Xenomai registered.
Xenomai: hal/ppc loaded.
Xenomai: real-time nucleus v2.0 (Surfing With The Alien) loaded.
Xenomai: starting native API services.

[root@domain.hid latency]# ./run
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
RTT|  00:00:01
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -13020|      -12152|        6076|       0|      -13020|
     6076 RTD|      -13075|      -12098|       10199|       0|
-13075|       10199 RTD|      -13020|      -12044|        1736|       0|
    -13075|       10199 RTD|      -12966|      -12152|       19151|
0|      -13075|       19151 RTD|      -13020|      -12152|       10633|
    0|      -13075|       19151 RTD|      -12966|      -12152|
15950|       0|      -13075|       19151 RTD|      -13020|      -12152|
     5913|       0|      -13075|       19151 RTD|      -13020|
-12152|       15679|       0|      -13075|       19151 RTD|      -12912|
    -12152|       10633|       0|      -13075|       19151 RTD|
-13020|      -12152|        8626|       0|      -13075|       19151 RTD|
    -12858|      -12152|       14865|       0|      -13075|       19151
RTD|      -13075|      -12152|       11067|       0|      -13075|
19151 RTD|      -12966|      -12152|        4286|       0|      -13075|
    19151 RTD|      -13020|      -12152|        9657|       0|
-13075|       19151 RTD|      -13020|      -12152|       10308|       0|
    -13075|       19151 RTD|      -13020|      -12152|       -4774|
0|      -13075|       19151 RTD|      -13020|      -12152|       13400|
    0|      -13075|       19151 RTD|      -13020|      -12152|
4557|       0|      -13075|       19151 RTD|      -12966|      -12152|
    7703|       0|      -13075|       19151 RTD|      -13020|
-12152|       10036|       0|      -13075|       19151 RTD|      -13020|
    -12152|       12532|       0|      -13075|       19151 RTT|  00:00:22
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -13020|      -12152|       -4014|       0|      -13075|
    19151 RTD|      -12966|      -12152|        5154|       0|
-13075|       19151 RTD|      -13020|      -12152|       10308|       0|
    -13075|       19151 RTD|      -12912|      -12152|       10199|
0|      -13075|       19151 RTD|      -12966|      -12152|        2332|
    0|      -13075|       19151 RTD|      -13075|      -12152|
6727|       0|      -13075|       19151 RTD|      -13075|      -12152|
   -1681|       0|      -13075|       19151 RTD|      -13075|
-12152|        1302|       0|      -13075|       19151 RTD|      -13020|
    -12098|       15407|       0|      -13075|       19151 RTD|
-13020|      -12098|       15353|       0|      -13075|       19151 RTD|
    -12749|      -12098|        3200|       0|      -13075|       19151
RTD|      -12641|      -12044|       10145|       0|      -13075|
19151 RTD|      -13020|      -12152|       13563|       0|      -13075|
    19151 RTD|      -12641|      -12152|        6022|       0|
-13075|       19151 RTD|      -13020|      -12152|        4177|       0|
    -13075|       19151 RTD|      -13020|      -12098|        9277|
0|      -13075|       19151 RTD|      -13183|      -12098|       15733|
    0|      -13183|       19151 RTD|      -12966|      -11664|
3146|       0|      -13183|       19151 RTD|      -13020|      -11990|
    8951|       0|      -13183|       19151 RTD|      -12966|
-12098|       16764|       0|      -13183|       19151 RTD|      -13020|
    -12044|        9006|       0|      -13183|       19151 RTT|  00:00:43
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -13020|      -12207|       -2712|       0|      -13183|
    19151 RTD|      -13183|      -12044|       -1139|       0|
-13183|       19151 RTD|      -12966|      -12044|        7758|       0|
    -13183|       19151 RTD|      -13020|      -11827|        4394|
0|      -13183|       19151 RTD|      -13075|      -12044|        9982|
    0|      -13183|       19151 RTD|      -12695|      -11935|
14539|       0|      -13183|       19151 RTD|      -12966|      -12044|
     8409|       0|      -13183|       19151 RTD|      -12641|
-11827|       11284|       0|      -13183|       19151 RTD|      -12912|
    -11555|       12315|       0|      -13183|       19151 RTD|
-12641|      -11176|       -1139|       0|      -13183|       19151 RTD|
    -13075|      -11881|       -6076|       0|      -13183|       19151
RTD|      -13020|      -11664|       -2495|       0|      -13183|
19151 RTD|      -13129|      -11610|        6401|       0|      -13183|
    19151 RTD|      -12966|      -11718|       -2332|       0|
-13183|       19151 RTD|      -13020|      -12207|        9657|       0|
    -13183|       19151 RTD|      -13020|      -12044|        2278|
0|      -13183|       19151 RTD|      -13075|      -11935|       11773|
    0|      -13183|       19151 RTD|      -13075|      -11990|
15136|       0|      -13183|       19151 RTD|      -13183|      -11827|
    -2983|       0|      -13183|       19151 RTD|      -13020|
-11718|      118164|       2|      -13183|      118164 RTD|      -12912|
    -11610|        3146|       2|      -13183|      118164 RTT|  00:01:04
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -12966|      -12098|        2604|       2|      -13183|
   118164 RTD|      -12966|      -12098|       -2170|       2|
-13183|      118164 RTD|      -12966|      -11881|        5045|       2|
    -13183|      118164 RTD|      -12695|      -11935|        4937|
2|      -13183|      118164 RTD|      -12966|      -11990|       -3363|
    2|      -13183|      118164 RTD|      -13020|      -12152|
9114|       2|      -13183|      118164 RTD|      -13129|      -12152|
   14919|       2|      -13183|      118164 RTD|      -13020|
-11610|       20996|       2|      -13183|      118164 RTD|      -12749|
    -11555|        2929|       2|      -13183|      118164 RTD|
-12641|      -11501|        7486|       2|      -13183|      118164 RTD|
    -12749|      -11230|       -4286|       2|      -13183|      118164
RTD|      -13020|      -11827|       10036|       2|      -13183|
118164 RTD|      -12912|      -12152|       15733|       2|      -13183|
    118164 RTD|      -13020|      -11881|       10470|       2|
-13183|      118164 RTD|      -13020|      -11990|       -2821|       2|
    -13183|      118164 RTD|      -12966|      -12044|       18663|
2|      -13183|      118164 RTD|      -12858|      -12098|        5859|
    2|      -13183|      118164 RTD|      -13020|      -11990|
9928|       2|      -13183|      118164 RTD|      -13183|      -12207|
    6944|       2|      -13183|      118164 RTD|      -13020|
-11773|        7812|       2|      -13183|      118164 RTD|      -13020|
    -11990|        8083|       2|      -13183|      118164 RTT|  00:01:25
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -13020|      -11935|        8246|       2|      -13183|
   118164 RTD|      -13075|      -11935|       14919|       2|
-13183|      118164 RTD|      -12966|      -11827|        3092|       2|
    -13183|      118164 RTD|      -13020|      -11990|       17686|
2|      -13183|      118164 RTD|      -13020|      -12098|       15028|
    2|      -13183|      118164 RTD|      -12966|      -12098|
1356|       2|      -13183|      118164 RTD|      -12966|      -12098|
    3960|       2|      -13183|      118164 RTD|      -12641|
-12098|        9657|       2|      -13183|      118164 RTD|      -13183|
    -12152|        8300|       2|      -13183|      118164 RTD|
-13020|      -12098|       12098|       2|      -13183|      118164 RTD|
    -13020|      -12098|        2549|       2|      -13183|      118164
RTD|      -13020|      -12207|       10416|       2|      -13183|
118164 RTD|      -13020|      -12098|       14811|       2|      -13183|
    118164 RTD|      -12858|      -11881|       -2387|       2|
-13183|      118164 RTD|      -13075|      -12207|         922|       2|
    -13183|      118164 RTD|      -12966|      -12152|       14214|
2|      -13183|      118164 RTD|      -13020|      -12152|       10308|
    2|      -13183|      118164 RTD|      -13020|      -12044|
2007|       2|      -13183|      118164 RTD|      -12858|      -12098|
    7758|       2|      -13183|      118164 RTD|      -12966|
-12207|        8517|       2|      -13183|      118164 RTD|      -13129|
    -12207|        3038|       2|      -13183|      118164 RTT|  00:01:46
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst RTD|      -13075|      -12044|         108|       2|      -13183|
   118164 RTD|      -12695|      -11773|       12044|       2|
-13183|      118164 RTD|      -12966|      -11881|        4286|       2|
    -13183|
118164

After a while I noticed overrun; the machine is NOT loaded (CPU load under
10%).

Then the terminal window freeze and KDE send me a pup up window:

General bug pupup window (mandriva 2005 10.2 / KDE )

Konsole application is crashed with signal 11 SIGSEV


Backtrace:

(no debugging symbols found)
Using host libthread_db library "/lib/tls/libthread_db.so.1".
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread 805578784 (LWP 6158)]
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
0x0e82ed00 in __waitpid_nocancel () from /lib/tls/libpthread.so.0
#0  0x0e82ed00 in __waitpid_nocancel () from /lib/tls/libpthread.so.0 #1
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#2  0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#3  0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#4
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#5  0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#6  0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#7
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#8  0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#9  0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#10
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#11 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#12 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#13
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#14 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#15 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#16
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#17 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#18 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#19
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#20 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#21 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#22
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#23 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#24 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#25
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#26 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#27 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#28
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#29 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#30 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#31
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4#32 0x0f7fae90 in KCrash::defaultCrashHandler ()
from /usr/lib/libkdecore.so.4#33 0x0f7fae90 in
KCrash::defaultCrashHandler () from /usr/lib/libkdecore.so.4#34
0x0f7fae90 in KCrash::defaultCrashHandler () from
/usr/lib/libkdecore.so.4

KDE suggest to contact the author of the guilty program :).

I'm sorry but I don't have more information to help you to debug.

If I repeat the test the situation is steady: after 10-60 s the terminal
hang and the KDE pop-up appear.

I will do the test in text only mode and I will report the results.

Thanks again for the help.


      Simone




