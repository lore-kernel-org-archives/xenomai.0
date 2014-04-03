From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 3 Apr 2014 09:46:47 -0400
Message-ID: <20140403134647.GL17765@csclub.uwaterloo.ca>
References: <20140402023531.GE17765@csclub.uwaterloo.ca>
 <533BB83F.5040301@xenomai.org>
 <20140402132401.GF17765@csclub.uwaterloo.ca>
 <533C100A.7050501@xenomai.org>
 <20140402134017.GG17765@csclub.uwaterloo.ca>
 <20140402134133.GH17765@csclub.uwaterloo.ca>
 <20140402134609.GI17765@csclub.uwaterloo.ca>
 <533C1709.3090305@xenomai.org>
 <20140402143809.GJ17765@csclub.uwaterloo.ca>
 <533C21A0.30502@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533C21A0.30502@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Apr 02, 2014 at 04:41:36PM +0200, Gilles Chanteperdrix wrote:
> It will run the whole LTP testsuite twice, this should last a few
> hours. If one test gets stuck (like mallocstress with some versions
> of gcc), simply kill it, and LTP will continue. I have been running
> a modified version of LTP 2008 since, well, 2008, and have
> reinstalled a more recent version only recently and did not test if
> the changes I made over time to the 2008 version were still needed.

So a run using ltp 2013/09 took about 19 hours.   Some ltp tests failed
(I think they required features I don't have, or too much memory).

Here is the end of the run:

RTH|---------cpu|ctx switches|-------total
RTD|           1|       16599|  1064555712
RTD|     -0.514|      2.327|      4.857|       0|     0|     -1.140|     10.811
RTD|           0|         964|    63476136
'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
RTD|           0|       16616|  1050643816
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
PRETTY_NAME="Debian GNU/Linux 7 (wheezy)"
NAME="Debian GNU/Linux"
VERSION_ID="7"
VERSION="7 (wheezy)"
ID=debian
ANSI_COLOR="1;31"
HOME_URL="http://www.debian.org/"
SUPPORT_URL="http://www.debian.org/support/"
BUG_REPORT_URL="http://bugs.debian.org/"
Linux omap5 3.12-1-dra7xx #1 SMP PREEMPT Debian 3.12.14-0.1 (2014-03-24) armv7l GNU/Linux
RTD|           1|       16760|  1064572472
 
RTD|     -0.840|      2.326|      4.694|       0|     0|     -1.140|     10.811
RTD|           1|        1033|    63435838
Gnu C                  gcc (Debian 4.6.3-14) 4.6.3
RTD|           0|        1033|    63477169
Gnu make               3.81
util-linux             linux 2.20.1
mount                  linux 2.20.1 (with libblkid and selinux support)
RTD|           0|       16377|  1050660193
modutils               9
e2fsprogs              1.42.5
RTD|           1|       16870|  1064589342
RTD|     -0.677|      2.365|      4.368|       0|     0|     -1.140|     10.811
RTD|           1|         970|    63436808
PPP                    2.4.5
RTD|           0|        1035|    63478204
RTD|           0|       16449|  1050676642
Linux C Library        > libc.2.13
Dynamic linker (ldd)   2.13
RTD|           1|       16667|  1064606009
RTD|     -0.678|      2.343|      4.856|       0|     0|     -1.140|     10.811
RTD|           1|        1031|    63437839
Procps                 3.3.3
RTD|           0|         968|    63479172
Net-tools              1.60
iproute2              iproute2-ss120521
Kbd                    1.15.3
RTD|           0|       15909|  1050692551
Sh-utils               8.13
Modules Loaded         xeno_rtipc xeno_switchtest xeno_timerbench xeno_posix xeno_rtdm xeno_native xeno_nucleus ipv6 xhci_hcd dwc3 omap_aes ahci_platform phy_omap_usb2 phy_omap_pipe3 phy_omap_control dwc3_omap omap_des rtc_m41t80

free reports:
             total       used       free     shared    buffers     cached
Mem:       1528608     318704    1209904          0      64520      53200
-/+ buffers/cache:     200984    1327624
Swap:            0          0          0

/proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 2 (v7l)
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 2

processor       : 1
model name      : ARMv7 Processor rev 2 (v7l)
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 2

Hardware        : Generic DRA7XX (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000
RTD|           1|       16356|  1064622365
RTD|     -0.678|      2.363|      5.019|       0|     0|     -1.140|     10.811
RTD|           1|         970|    63438809
RTD|           0|         968|    63480140
RTD|           0|       15974|  1050708525
RTD|     -0.678|      2.326|      6.321|       0|     0|     -1.140|     10.811
RTD|           1|       16615|  1064638980
RTD|           1|         966|    63439775
RTT|  18:21:49
RTH|---------cpu|ctx switches|-------total
RTD|           0|        1031|    63481171
RTD|           0|       16665|  1050725190
RTT|  18:21:09  (in-kernel timer handler, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.353|      2.369|      4.530|       0|     0|     -1.140|     10.811
RTD|           1|       16856|  1064655836
RTD|           1|        1031|    63440806
RTD|           0|        1035|    63482206
RTD|           0|       16466|  1050741656
RTD|     -0.841|      2.319|      4.693|       0|     0|     -1.140|     10.811
RTD|           1|       16561|  1064672397
RTD|           1|         970|    63441776
RTD|           0|        1035|    63483241
10240+0 records in
10240+0 records out
10240000 bytes (10 MB) copied, 3.46131 s, 3.0 MB/s
RTD|           0|       16603|  1050758259
COMMAND:    /mnt/bin/ltp-pan  -e -S   -a 14348     -n 14348  -p  -f /tmp/ltp-bDTE95Zhcm/alltests -l /mnt/results/LTP_RUN_ON-2014_Apr_03-04h_06m_46s.log  -C /mnt/output/LTP_RUN_ON-2014_Apr_03-04h_06m_46s.failed
LOG File: /mnt/results/LTP_RUN_ON-2014_Apr_03-04h_06m_46s.log
FAILED COMMAND File: /mnt/output/LTP_RUN_ON-2014_Apr_03-04h_06m_46s.failed
Running tests.......
RTD|           1|       16577|  1064688974
RTD|     -0.842|      2.361|      5.669|       0|     0|     -1.140|     10.811
<<<test_start>>>
tag=tcore01 stime=1396512415
cmdline="tcore.sh"
contacts=""
analysis=exit
<<<test_output>>>
RTD|           1|        1031|    63442807
RTD|           0|        1035|    63484276
RTD|           0|       15708|  1050773967
Test Tcore patch 
/mnt/testcases/bin/tcore.sh: 72: cd: can't cd to /lib/i686
RTD|           1|       16410|  1064705384
RTD|     -0.353|      2.310|      5.180|       0|     0|     -1.140|     10.811
RTD|           1|        1035|    63443842
RTD|           0|         970|    63485246
RTD|           0|       16473|  1050790440
RTD|           1|       16492|  1064721876
RTD|     -0.842|      2.342|      5.017|       0|     0|     -1.140|     10.811
RTD|           1|         970|    63444812
RTD|           0|        1031|    63486277
RTT|  18:21:55
RTH|---------cpu|ctx switches|-------total
RTD|           0|       16457|  1050806897
RTD|           1|       16764|  1064738640
RTD|     -0.679|      2.305|      5.180|       0|     0|     -1.140|     10.811
RTD|           1|        1031|    63445843
RTD|           0|       16229|  1050823126
RTD|           0|        1035|    63487312
RTD|           1|       16329|  1064754969
RTD|     -0.680|      2.347|      4.529|       0|     0|     -1.140|     10.811
Test whether we can generate the needed core file
FAIL
/mnt/testcases/bin/tcore.sh: 88: cd: can't cd to /lib/i686
RTD|           1|        1035|    63446878
Test whether the core support bt,fpu and threads commands 
/mnt/testcases/bin/tcore.sh: 128: /mnt/testcases/bin/tcore.sh: expect: not found
RTD|           0|         970|    63488282
RTD|           0|       16151|  1050839277
/mnt/testcases/bin/tcore.sh: 51: exit: Illegal number: -122
RTD|           1|       16538|  1064771507
RTD|     -0.517|      2.300|      5.017|       0|     0|     -1.140|     10.811
RTD|           1|        1035|    63447913
RTD|           0|       16536|  1050855813
RTD|           0|        1031|    63489313
RTD|           1|       16549|  1064788056
RTD|     -0.843|      2.355|      6.156|       0|     0|     -1.140|     10.811
RTD|           1|         968|    63448881
RTD|           0|       16430|  1050872243
RTD|           0|         970|    63490283
RTD|           1|       16785|  1064804841
RTD|     -0.681|      2.297|      4.365|       0|     0|     -1.140|     10.811
RTD|           1|        1033|    63449914
RTD|           0|       16356|  1050888599
RTD|           0|        1031|    63491314
RTD|           1|       16789|  1064821630
RTD|     -0.518|      2.333|      5.504|       0|     0|     -1.140|     10.811
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=2 corefile=no
cutime=1 cstime=8
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20130904

       ###############################################################

            Done executing testcases.
            LTP Version:  20130904
       ###############################################################

RTD|           0|       16466|  1050905065
RTT|  18:22:01
RTH|---------cpu|ctx switches|-------total
RTD|           1|        1035|    63450949
RTD|           0|         968|    63492282
RTD|     -0.681|      2.284|      5.341|       0|     0|     -1.140|     10.811
RTD|           1|       16531|  1064838161
RTD|           0|       16448|  1050921513
RTD|           1|         970|    63451919
RTD|           0|        1033|    63493315
RTD|           1|       16894|  1064855055
RTD|     -0.518|      2.335|      4.690|       0|     0|     -1.140|     10.811
RTD|           0|       16510|  1050938023
RTD|           1|        1031|    63452950
RTD|           0|        1035|    63494350
RTD|     -0.519|      2.326|      5.178|       0|     0|     -1.140|     10.811
RTD|           1|       16719|  1064871774
RTD|           0|       16004|  1050954027
RTD|           1|        1035|    63453985
RTD|           0|        1035|    63495385
RTD|     -0.519|      2.294|      4.364|       0|     0|     -1.140|     10.811
RTD|           1|       16473|  1064888247
RTD|           0|       16180|  1050970207
RTD|           1|         966|    63454951
RTD|           0|        1035|    63496420
RTT|  18:22:05
RTH|---------cpu|ctx switches|-------total
RTD|           1|       16993|  1064905240
RTD|     -0.845|      2.264|      5.015|       0|     0|     -1.140|     10.811
RTD|           0|       16282|  1050986489
RTD|           1|         970|    63455921
RTD|     -0.682|      2.312|      5.177|       0|     0|     -1.140|     10.811
RTD|           1|       16733|  1064921973
RTD|           0|        1035|    63497455
RTD|           0|       16265|  1051002754
RTD|           1|         966|    63456887
Killed
Load script terminated, terminating checked scripts
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -1.140|      2.280|     10.811|       0|     0|    18:21:26/18:21:26
RTD|           0|         795|    63498250
RTD|           0|        4654|  1051007408
RTD|           1|       14862|  1064936835
RTD|           1|         134|    63457021
pipe_in: /tmp/xeno-test-in-9751

I am guessing that looks successful.

fork13 -i 1000000 takes a VERY long time.  I think that test is worth
adjusting a bit.

-- 
Len Sorensen

