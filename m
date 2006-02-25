Message-ID: <4400033B.8000808@domain.hid>
Date: Sat, 25 Feb 2006 00:11:55 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Geode performance (Was: problems solved)
References: <C0244E4B.24F4%steve@domain.hid> <43FF1F62.4070102@domain.hid>
In-Reply-To: <43FF1F62.4070102@domain.hid>
Content-Type: multipart/mixed; boundary="------------050806040309010809000501"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050806040309010809000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Steven Seeger wrote:
>>> Again, the only way to make your point here would be to run the 
>>> latency test
>>> in user-space, disabling the periodic timing at configuration level 
>>> (v2.1 only),
>>> and making sure that no SMI source is active. If the results 
>>> actually show
>>> performance degradation on this board between v2.0 (which is based 
>>> on the latest fusion
>>> code) and v2.1-rc3, then your conclusion would have more weight.
>>>
>>
>>
>> Didn't we already figure out that my geode board won't run the 
>> latency tests
>> because it doesn't support aperiodic mode?
>
> No, we didn't. Geode is no different than any other x86 platform 
> Xenomai-wise, and it does obviously support the aperiodic mode; 
> actually all platforms Xenomai currently runs on do support aperiodic 
> mode, which is the fundamental one, only the periodic mode is 
> optional. When CONFIG_X86_UP_APIC is off, this mode is obtained by 
> programming the 8254 PIT in a different way than it is done for the 
> periodic one, but it's exactely the same hardware involved; the rest 
> is purely software-based. Incidentally, I'm running an MDB acquisition 
> system on a Geode 266Mhz board, right now, on my desk, just in front 
> of me, so unless I'm badly hallucinating, your board should work too.
>
FWIW, I have a geode  SC-1100  @ 266MHz, on a soekris net-4801, w 128 MB 
ram.
its a 586mmx, nearest I can tell, ive tried GeodeGX1 menu-choice too, 
never saw a difference.
The bios is *not* PM, ACPI, or APIC, best I can tell.


attached is an update to xeno-test which runs latency with -t0 -t1 -t2
I think Ive got xeno-test and xeno-test.in sync'd, that doesnt seem to 
happen
as part of the configure make process for me.

also attached are a couple short runs, is output from a run on a 15.1 
kernel patched with ipipe-120
The second run had some stderrs, which didnt make it to the logfile

RTD|         394|        7362|       24683|       0|         232|       
35433
RTD|         469|        7145|       26284|       0|         232|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         671|        6531|       17180|       0|         232|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         559|        6083|       21488|       0|         232|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         648|        7210|       25429|       0|         232|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         525|        6382|       19801|       0|         232|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|        -259|        4791|       22527|       0|        -259|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         682|        7543|       28459|       0|        -259|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|        -180|        6725|       23142|       0|        -259|       
35433
set_rtc_mmss: can't update from 58 to 8
RTT|  00:00:22  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|         266|        4974|       20690|       0|        -259|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|        -270|        7325|       28410|       0|        -270|       
35433
set_rtc_mmss: can't update from 58 to 8
RTD|         472|        7814|       27536|       0|        -270|       
35433
set_rtc_mmss: can't update from 58 to 8




--------------050806040309010809000501
Content-Type: text/plain;
 name="patch-xenotest"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-xenotest"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 591)
+++ scripts/xeno-test.in	(working copy)
@@ -3,7 +3,7 @@
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
-  runs latency and klatency tests
+  runs latency test in all 3 test-modes
   -w <number>	spawn N workloads (dd if=/dev/zero of=/dev/null) default=1
   -d <device>	used as alternate src in workload (dd if=$device ..)
 		The device must be mounted, and (unfortunately) cannot
@@ -101,14 +101,11 @@
     boxstatus
     (
 	cd ../testsuite/latency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts
 
-	[ -n "$prepost" ] && loudly $prepost
-	
-	cd ../klatency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts;
+	loudly ./run --  $opts -t0
+	loudly ./run --  $opts -t1
+	loudly ./run --  $opts -t2
+
     )
     boxstatus
 }

--------------050806040309010809000501
Content-Type: text/plain;
 name="test-2.6.15.1-ipipe-120-sk-060224.203205"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="test-2.6.15.1-ipipe-120-sk-060224.203205"

Script started on Fri Feb 24 20:32:05 2006
creating workload using dd if=/dev/hda
running ./xeno-test -T 30 -s -h

Fri Feb 24 20:32:06 MST 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: Geode by NSC
cpu family	: 5
model		: 9
model name	: Unknown
stepping	: 1
cpu MHz		: 266.700
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 534.86


Fri Feb 24 20:32:06 MST 2006
running: cat /proc/meminfo
MemTotal:       126364 kB
MemFree:         84716 kB
Buffers:            12 kB
Cached:          31316 kB
SwapCached:          0 kB
Active:          19336 kB
Inactive:        17312 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126364 kB
LowFree:         84716 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:          10792 kB
Slab:             4200 kB
CommitLimit:     63180 kB
Committed_AS:     9200 kB
PageTables:        240 kB
VmallocTotal:   909292 kB
VmallocUsed:       356 kB
VmallocChunk:   907640 kB

Fri Feb 24 20:32:06 MST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Fri Feb 24 20:32:06 MST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Fri Feb 24 20:32:06 MST 2006
running: cat /proc/ipipe/version
1.2-00

Fri Feb 24 20:32:06 MST 2006
running: generate_loads 4
dd workload started, pids 2501 2502 2503 2504

Fri Feb 24 20:32:06 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     193828          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       4853          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      60017          XT-PIC  eth0
 14:      13933          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:32:10 MST 2006
running: cat /proc/loadavg
1.46 1.26 0.67 5/38 2508

Fri Feb 24 20:32:12 MST 2006
running: top -bn1c
top - 20:32:12 up 13 min,  1 user,  load average: 1.74, 1.32, 0.70
Tasks:  40 total,   5 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s): 32.8% us, 48.7% sy,  0.0% ni, 18.0% id,  0.2% wa,  0.0% hi,  0.3% si
Mem:    126364k total,    52836k used,    73528k free,    10368k buffers
Swap:        0k total,        0k used,        0k free,    31316k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2503 root      19   0  1588  388  316 R 32.9  0.3   0:01.90 dd if /dev/hda of  
 2502 root      19   0  1584  384  316 R 20.8  0.3   0:00.52 dd if /dev/hda of  
 2501 root      19   0  1584  384  316 R 17.3  0.3   0:01.51 dd if /dev/hda of  
 2504 root      19   0  1584  384  316 R 17.3  0.3   0:01.94 dd if /dev/hda of  
 2512 root      15   0  2132  920  736 R  8.7  0.7   0:00.18 top -bn1c          
    1 root      16   0  1584  520  452 S  0.0  0.4   0:01.73 init [3]           

Fri Feb 24 20:32:12 MST 2006
running: ./run -- -h -T 30 -s -h -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       24518|       35909|       52335|       0|       24518|       52335
RTD|       24495|       36096|       52414|       0|       24495|       52414
RTD|       24979|       34105|       54023|       0|       24495|       54023
RTD|       24596|       36025|       52050|       0|       24495|       54023
RTD|       25170|       37060|       52729|       0|       24495|       54023
RTD|       26081|       36951|       54180|       0|       24495|       54180
RTD|       25013|       36212|       54015|       0|       24495|       54180
RTD|       24698|       35939|       53175|       0|       24495|       54180
RTD|       24945|       36017|       52448|       0|       24495|       54180
RTD|       24293|       33667|       52819|       0|       24293|       54180
RTD|       24799|       35061|       51976|       0|       24293|       54180
RTD|       24574|       36261|       52677|       0|       24293|       54180
RTD|       24596|       36377|       52414|       0|       24293|       54180
RTD|       24551|       36306|       53933|       0|       24293|       54180
RTD|       24473|       35980|       52043|       0|       24293|       54180
RTD|       24686|       36572|       52369|       0|       24293|       54180
RTD|       24495|       34615|       59643|       0|       24293|       59643
RTD|       24731|       35148|       52425|       0|       24293|       59643
RTD|       25058|       36906|       57709|       0|       24293|       59643
RTD|       25620|       36914|       53303|       0|       24293|       59643
RTD|       24698|       36265|       51841|       0|       24293|       59643
RTT|  00:00:22  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       24360|       33487|       52009|       0|       24293|       59643
RTD|       24619|       37030|       52797|       0|       24293|       59643
RTD|       24540|       36715|       60659|       0|       24293|       60659
RTD|       24866|       36771|       53273|       0|       24293|       60659
RTD|       24641|       36059|       57382|       0|       24293|       60659
RTD|       24473|       35429|       52392|       0|       24293|       60659
RTD|       25058|       36239|       54011|       0|       24293|       60659
RTD|       24349|       35988|       57045|       0|       24293|       60659
---|--param|----range-|--samples
HSD|    min|  24 - 25 |       23
HSD|    min|  25 - 26 |        5
HSD|    min|  26 - 27 |        1
---|--param|----range-|--samples
HSD|    avg|  24 - 25 |      295
HSD|    avg|  25 - 26 |     6756
HSD|    avg|  26 - 27 |    16731
HSD|    avg|  27 - 28 |    14647
HSD|    avg|  28 - 29 |     4401
HSD|    avg|  29 - 30 |     3544
HSD|    avg|  30 - 31 |     8383
HSD|    avg|  31 - 32 |    11476
HSD|    avg|  32 - 33 |     7288
HSD|    avg|  33 - 34 |     6268
HSD|    avg|  34 - 35 |    14306
HSD|    avg|  35 - 36 |    34888
HSD|    avg|  36 - 37 |    43960
HSD|    avg|  37 - 38 |    31494
HSD|    avg|  38 - 39 |    21370
HSD|    avg|  39 - 40 |    15936
HSD|    avg|  40 - 41 |    14656
HSD|    avg|  41 - 42 |    14941
HSD|    avg|  42 - 43 |    12106
HSD|    avg|  43 - 44 |     7975
HSD|    avg|  44 - 45 |     3411
HSD|    avg|  45 - 46 |      758
HSD|    avg|  46 - 47 |      429
HSD|    avg|  47 - 48 |      797
HSD|    avg|  48 - 49 |     1067
HSD|    avg|  49 - 50 |     1160
HSD|    avg|  50 - 51 |      669
HSD|    avg|  51 - 52 |      161
HSD|    avg|  52 - 53 |       39
HSD|    avg|  53 - 54 |        5
HSD|    avg|  54 - 55 |        5
HSD|    avg|  57 - 58 |        3
HSD|    avg|  59 - 60 |        1
HSD|    avg|  60 - 61 |        1
---|--param|----range-|--samples
HSD|    max|  51 - 52 |        2
HSD|    max|  52 - 53 |       14
HSD|    max|  53 - 54 |        4
HSD|    max|  54 - 55 |        4
HSD|    max|  57 - 58 |        3
HSD|    max|  59 - 60 |        1
HSD|    max|  60 - 61 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|     24.241|      0.511
HSS|    avg|    299927|     35.385|      5.021
HSS|    max|        29|     53.379|      2.352
---|------------|------------|------------|--------|-------------------------
RTS|       24293|       35883|       60659|       0|    00:00:30/00:00:30

Fri Feb 24 20:33:10 MST 2006
running: ./run -- -h -T 30 -s -h -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       11489|       25459|       35936|       0|       11489|       35936
RTD|       11354|       25246|       35294|       0|       11354|       35936
RTD|       11342|       24759|       35962|       0|       11342|       35962
RTD|       11241|       22104|       41271|       0|       11241|       41271
RTD|       11927|       26422|       34466|       0|       11241|       41271
RTD|       11736|       25321|       35568|       0|       11241|       41271
RTD|       11567|       22417|       34882|       0|       11241|       41271
RTD|       11466|       25230|       34327|       0|       11241|       41271
RTD|       11792|       26401|       36802|       0|       11241|       41271
RTD|       11545|       25838|       35786|       0|       11241|       41271
RTD|       11444|       23467|       35714|       0|       11241|       41271
RTD|       11522|       23535|       36592|       0|       11241|       41271
RTD|       11264|       24780|       34507|       0|       11241|       41271
RTD|       11016|       25575|       36948|       0|       11016|       41271
RTD|       11354|       24830|       38268|       0|       11016|       41271
RTD|       11511|       24947|       35598|       0|       11016|       41271
RTD|       11219|       24788|       37458|       0|       11016|       41271
RTD|       11489|       25173|       36254|       0|       11016|       41271
RTD|       11354|       22270|       40829|       0|       11016|       41271
RTD|       11736|       25615|       34331|       0|       11016|       41271
RTD|       11219|       25585|       38939|       0|       11016|       41271
RTT|  00:00:22  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       11691|       23312|       36427|       0|       11016|       41271
RTD|       11444|       23097|       34968|       0|       11016|       41271
RTD|       11579|       25287|       36352|       0|       11016|       41271
RTD|       11657|       24944|       34541|       0|       11016|       41271
RTD|       10780|       24749|       36183|       0|       10780|       41271
RTD|       11567|       25289|       39468|       0|       10780|       41271
RTD|       11579|       25062|       33971|       0|       10780|       41271
RTD|       11455|       24564|       41462|       0|       10780|       41462
---|--param|----range-|--samples
HSD|    min|  10 - 11 |        1
HSD|    min|  11 - 12 |       28
---|--param|----range-|--samples
HSD|    avg|  10 - 11 |        1
HSD|    avg|  11 - 12 |      236
HSD|    avg|  12 - 13 |     3339
HSD|    avg|  13 - 14 |    11029
HSD|    avg|  14 - 15 |    12559
HSD|    avg|  15 - 16 |     9363
HSD|    avg|  16 - 17 |     5350
HSD|    avg|  17 - 18 |     9591
HSD|    avg|  18 - 19 |    11013
HSD|    avg|  19 - 20 |     7944
HSD|    avg|  20 - 21 |     5799
HSD|    avg|  21 - 22 |     2204
HSD|    avg|  22 - 23 |     2373
HSD|    avg|  23 - 24 |     5685
HSD|    avg|  24 - 25 |    12507
HSD|    avg|  25 - 26 |    24235
HSD|    avg|  26 - 27 |    36380
HSD|    avg|  27 - 28 |    47654
HSD|    avg|  28 - 29 |    43793
HSD|    avg|  29 - 30 |    23994
HSD|    avg|  30 - 31 |    12354
HSD|    avg|  31 - 32 |     5722
HSD|    avg|  32 - 33 |     2241
HSD|    avg|  33 - 34 |      618
HSD|    avg|  34 - 35 |       99
HSD|    avg|  35 - 36 |       21
HSD|    avg|  36 - 37 |        8
HSD|    avg|  37 - 38 |        4
HSD|    avg|  38 - 39 |        3
HSD|    avg|  39 - 40 |        2
HSD|    avg|  40 - 41 |        1
HSD|    avg|  41 - 42 |        2
---|--param|----range-|--samples
HSD|    max|  33 - 34 |        1
HSD|    max|  34 - 35 |        7
HSD|    max|  35 - 36 |        7
HSD|    max|  36 - 37 |        7
HSD|    max|  37 - 38 |        1
HSD|    max|  38 - 39 |        2
HSD|    max|  39 - 40 |        1
HSD|    max|  40 - 41 |        1
HSD|    max|  41 - 42 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|     10.966|      0.186
HSS|    avg|    296124|     24.148|      5.273
HSS|    max|        29|     35.931|      2.137
---|------------|------------|------------|--------|-------------------------
RTS|       10780|       24691|       41462|       0|    00:00:30/00:00:30

Fri Feb 24 20:34:15 MST 2006
running: ./run -- -h -T 30 -s -h -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         664|        6277|       16783|       0|         664|       16783
RTD|         428|        6491|       17368|       0|         428|       17368
RTD|         720|        5915|       33900|       0|         428|       33900
RTD|         750|        6722|       20544|       0|         428|       33900
RTD|         821|        6958|       25343|       0|         428|       33900
RTD|         540|        5927|       25017|       0|         428|       33900
RTD|         503|        6178|       24578|       0|         428|       33900
RTD|         784|        7118|       23588|       0|         428|       33900
RTD|         536|        6658|       20386|       0|         428|       33900
RTD|         638|        6389|       23746|       0|         428|       33900
RTD|         720|        6467|       24027|       0|         428|       33900
RTD|         641|        6559|       20615|       0|         428|       33900
RTD|         638|        5743|       24353|       0|         428|       33900
RTD|         593|        6258|       33843|       0|         428|       33900
RTD|         664|        7178|       20244|       0|         428|       33900
RTD|         368|        6409|       25141|       0|         368|       33900
RTD|         754|        6178|       24342|       0|         368|       33900
RTD|         885|        6560|       24083|       0|         368|       33900
RTD|         866|        7463|       24218|       0|         368|       33900
RTD|         788|        6029|       19258|       0|         368|       33900
RTD|         439|        5224|       23371|       0|         368|       33900
RTT|  00:00:22  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       -1275|        5606|       24391|       0|       -1275|       33900
RTD|         480|        6927|       25969|       0|       -1275|       33900
RTD|         540|        6528|       20300|       0|       -1275|       33900
RTD|         626|        7295|       28095|       0|       -1275|       33900
RTD|         559|        6663|       27559|       0|       -1275|       33900
RTD|         559|        6932|       29460|       0|       -1275|       33900
RTD|         761|        5913|       23637|       0|       -1275|       33900
RTD|         784|        6927|       28054|       0|       -1275|       33900
---|--param|----range-|--samples
HSD|    min|   0 -  1 |       28
HSD|    min|   1 -  2 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |      371
HSD|    avg|   1 -  2 |    16714
HSD|    avg|   2 -  3 |    43661
HSD|    avg|   3 -  4 |    36495
HSD|    avg|   4 -  5 |    12135
HSD|    avg|   5 -  6 |     3711
HSD|    avg|   6 -  7 |    12141
HSD|    avg|   7 -  8 |    48270
HSD|    avg|   8 -  9 |    62581
HSD|    avg|   9 - 10 |    43581
HSD|    avg|  10 - 11 |    16895
HSD|    avg|  11 - 12 |     2961
HSD|    avg|  12 - 13 |      201
HSD|    avg|  13 - 14 |       61
HSD|    avg|  14 - 15 |       32
HSD|    avg|  15 - 16 |       26
HSD|    avg|  16 - 17 |       20
HSD|    avg|  17 - 18 |       17
HSD|    avg|  18 - 19 |        8
HSD|    avg|  19 - 20 |        9
HSD|    avg|  20 - 21 |       14
HSD|    avg|  22 - 23 |        3
HSD|    avg|  23 - 24 |        6
HSD|    avg|  24 - 25 |        7
HSD|    avg|  25 - 26 |        4
HSD|    avg|  27 - 28 |        1
HSD|    avg|  28 - 29 |        2
HSD|    avg|  29 - 30 |        2
HSD|    avg|  33 - 34 |        2
---|--param|----range-|--samples
HSD|    max|  16 - 17 |        1
HSD|    max|  17 - 18 |        1
HSD|    max|  19 - 20 |        1
HSD|    max|  20 - 21 |        5
HSD|    max|  23 - 24 |        4
HSD|    max|  24 - 25 |        7
HSD|    max|  25 - 26 |        4
HSD|    max|  27 - 28 |        1
HSD|    max|  28 - 29 |        2
HSD|    max|  29 - 30 |        1
HSD|    max|  33 - 34 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|      0.034|      0.186
HSS|    avg|    299931|      5.974|      2.933
HSS|    max|        29|     23.793|      4.021
---|------------|------------|------------|--------|-------------------------
RTS|       -1275|        6465|       33900|       0|    00:00:30/00:00:30

Fri Feb 24 20:35:21 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     241551          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       5848          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      66215          XT-PIC  eth0
 14:     407445          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:35:21 MST 2006
running: cat /proc/loadavg
5.01 3.05 1.48 5/38 2836

Fri Feb 24 20:35:21 MST 2006
running: top -bn1c
top - 20:35:22 up 16 min,  1 user,  load average: 4.93, 3.07, 1.49
Tasks:  40 total,   5 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s): 28.6% us, 56.4% sy,  0.0% ni, 14.5% id,  0.1% wa,  0.0% hi,  0.3% si
Mem:    126364k total,   123840k used,     2524k free,   103808k buffers
Swap:        0k total,        0k used,        0k free,     7724k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2501 root      21   0  1584  384  316 R 31.4  0.3   0:43.18 dd if /dev/hda of  
 2502 root      21   0  1584  384  316 R 19.2  0.3   0:45.26 dd if /dev/hda of  
 2503 root      20   0  1588  388  316 R 19.2  0.3   0:48.73 dd if /dev/hda of  
 2504 root      25   0  1584  384  316 R 17.4  0.3   0:43.20 dd if /dev/hda of  
 2840 root      15   0  2132  920  736 R 10.5  0.7   0:00.18 top -bn1c          
   91 root      15   0     0    0    0 D  1.7  0.0   0:03.62 [kswapd0]          

Script done on Fri Feb 24 20:35:22 2006

--------------050806040309010809000501
Content-Type: text/plain;
 name="test-2.6.15.1-ipipe-120-sk-060224.203541"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="test-2.6.15.1-ipipe-120-sk-060224.203541"

Script started on Fri Feb 24 20:35:41 2006
creating workload using dd if=/dev/hda
running ./xeno-test -T 30 -s -h

Fri Feb 24 20:35:41 MST 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: Geode by NSC
cpu family	: 5
model		: 9
model name	: Unknown
stepping	: 1
cpu MHz		: 266.700
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 534.86


Fri Feb 24 20:35:41 MST 2006
running: cat /proc/meminfo
MemTotal:       126364 kB
MemFree:          3104 kB
Buffers:        103680 kB
Cached:           8156 kB
SwapCached:          0 kB
Active:          70940 kB
Inactive:        46208 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126364 kB
LowFree:          3104 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          10784 kB
Slab:             5324 kB
CommitLimit:     63180 kB
Committed_AS:     9188 kB
PageTables:        240 kB
VmallocTotal:   909292 kB
VmallocUsed:       356 kB
VmallocChunk:   907640 kB

Fri Feb 24 20:35:41 MST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Fri Feb 24 20:35:41 MST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Fri Feb 24 20:35:42 MST 2006
running: cat /proc/ipipe/version
1.2-00

Fri Feb 24 20:35:42 MST 2006
running: generate_loads 4
dd workload started, pids 2886 2887 2888 2889

Fri Feb 24 20:35:46 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     247945          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       8260          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      67792          XT-PIC  eth0
 14:     427861          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:35:47 MST 2006
running: cat /proc/loadavg
4.04 2.99 1.50 5/38 2893

Fri Feb 24 20:35:49 MST 2006
running: top -bn1c
top - 20:35:50 up 16 min,  1 user,  load average: 4.04, 2.99, 1.50
Tasks:  40 total,   6 running,  34 sleeping,   0 stopped,   0 zombie
Cpu(s): 28.0% us, 55.7% sy,  0.0% ni, 15.9% id,  0.1% wa,  0.0% hi,  0.3% si
Mem:    126364k total,   123432k used,     2932k free,   103392k buffers
Swap:        0k total,        0k used,        0k free,     7896k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2889 root      19   0  1584  384  316 R 27.3  0.3   0:02.24 dd if /dev/hda of  
 2886 root      19   0  1584  380  316 R 25.6  0.3   0:02.15 dd if /dev/hda of  
 2888 root      19   0  1584  384  316 R 18.8  0.3   0:02.60 dd if /dev/hda of  
 2887 root      20   0  1588  380  316 R 17.1  0.3   0:00.40 dd if /dev/hda of  
 2897 root      15   0  2132  920  736 R  8.5  0.7   0:00.16 top -bn1c          
    1 root      16   0  1584  520  452 S  0.0  0.4   0:01.94 init [3]           

Fri Feb 24 20:35:50 MST 2006
running: ./run -- -h -T 30 -s -h -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       22403|       34319|       55103|       0|       22403|       55103
RTD|       21886|       33967|       54653|       0|       21886|       55103
RTD|       22302|       33959|       57499|       0|       21886|       57499
RTD|       21897|       34296|       54293|       0|       21886|       57499
RTD|       22437|       32230|       54473|       0|       21886|       57499
RTD|       22257|       34413|       56756|       0|       21886|       57499
RTD|       22324|       34401|       54664|       0|       21886|       57499
RTD|       22313|       34851|       56587|       0|       21886|       57499
RTD|       22122|       34113|       55688|       0|       21886|       57499
RTD|       15643|       31169|       54169|       1|       15643|       57499
RTD|       22200|       34233|       54585|       1|       15643|       57499
RTD|       22437|       35545|       55058|       1|       15643|       57499
RTD|       22830|       34866|       55215|       1|       15643|       57499
RTD|       22032|       34315|       55451|       1|       15643|       57499
RTD|       22189|       33292|       55046|       1|       15643|       57499
RTD|       21942|       34420|       56025|       1|       15643|       57499
RTD|       21751|       32133|       54923|       1|       15643|       57499
RTD|       23427|       34056|       56014|       1|       15643|       57499
RTD|       23235|       34694|       55710|       1|       15643|       57499
RTD|       23258|       35268|       55665|       1|       15643|       57499
RTD|       21863|       32287|       54855|       1|       15643|       57499
RTT|  00:00:22  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       21368|       33693|       55406|       1|       15643|       57499
RTD|       22954|       35260|       55530|       1|       15643|       57499
RTD|       22965|       35035|       55984|       1|       15643|       57499
RTD|       21863|       30701|       55485|       1|       15643|       57499
RTD|       21706|       34859|       56644|       1|       15643|       57499
RTD|       21908|       34165|       54821|       1|       15643|       57499
RTD|       21211|       35121|       54934|       1|       15643|       57499
RTD|       22054|       32197|       54720|       1|       15643|       57499
---|--param|----range-|--samples
HSD|    min|  15 - 16 |        1
HSD|    min|  21 - 22 |       10
HSD|    min|  22 - 23 |       15
HSD|    min|  23 - 24 |        3
---|--param|----range-|--samples
HSD|    avg|  15 - 16 |        1
HSD|    avg|  21 - 22 |       44
HSD|    avg|  22 - 23 |     1402
HSD|    avg|  23 - 24 |     7032
HSD|    avg|  24 - 25 |    11547
HSD|    avg|  25 - 26 |    18291
HSD|    avg|  26 - 27 |     6537
HSD|    avg|  27 - 28 |     3726
HSD|    avg|  28 - 29 |     6993
HSD|    avg|  29 - 30 |     9605
HSD|    avg|  30 - 31 |     8735
HSD|    avg|  31 - 32 |     7038
HSD|    avg|  32 - 33 |    11988
HSD|    avg|  33 - 34 |    31772
HSD|    avg|  34 - 35 |    43253
HSD|    avg|  35 - 36 |    34593
HSD|    avg|  36 - 37 |    24983
HSD|    avg|  37 - 38 |    18046
HSD|    avg|  38 - 39 |    14429
HSD|    avg|  39 - 40 |    12344
HSD|    avg|  40 - 41 |     9784
HSD|    avg|  41 - 42 |     7628
HSD|    avg|  42 - 43 |     3653
HSD|    avg|  43 - 44 |      733
HSD|    avg|  44 - 45 |      122
HSD|    avg|  45 - 46 |      324
HSD|    avg|  46 - 47 |      884
HSD|    avg|  47 - 48 |     1284
HSD|    avg|  48 - 49 |      881
HSD|    avg|  49 - 50 |      596
HSD|    avg|  50 - 51 |      501
HSD|    avg|  51 - 52 |      409
HSD|    avg|  52 - 53 |      327
HSD|    avg|  53 - 54 |      251
HSD|    avg|  54 - 55 |      148
HSD|    avg|  55 - 56 |       32
HSD|    avg|  56 - 57 |        7
HSD|    avg|  57 - 58 |        1
---|--param|----range-|--samples
HSD|    max|  54 - 55 |       11
HSD|    max|  55 - 56 |       12
HSD|    max|  56 - 57 |        5
HSD|    max|  57 - 58 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|     21.517|      1.405
HSS|    avg|    299924|     33.446|      5.184
HSS|    max|        29|     54.862|      0.833
---|------------|------------|------------|--------|-------------------------
RTS|       15643|       33940|       57499|       1|    00:00:30/00:00:30

Fri Feb 24 20:36:53 MST 2006
running: ./run -- -h -T 30 -s -h -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       10003|       23957|       42219|       0|       10003|       42219
RTD|       10689|       22961|       47150|       0|       10003|       47150
RTD|        9756|       21788|       43235|       0|        9756|       47150
RTD|       11196|       25006|       42324|       0|        9756|       47150
RTD|       11488|       25460|       42583|       0|        9756|       47150
RTD|       10498|       24214|       43179|       0|        9756|       47150
RTD|       10577|       23991|       45714|       0|        9756|       47150
RTD|       10937|       23553|       43539|       0|        9756|       47150
RTD|       10824|       23980|       42740|       0|        9756|       47150
RTD|       10712|       23755|       42178|       0|        9756|       47150
RTD|       10408|       23954|       42414|       0|        9756|       47150
RTD|       10903|       24078|       45039|       0|        9756|       47150
RTD|        9868|       21890|       44746|       0|        9756|       47150
RTD|       11477|       24125|       45575|       0|        9756|       47150
RTD|       11432|       25304|       42707|       0|        9756|       47150
RTD|       10487|       24499|       44113|       0|        9756|       47150
RTD|       10532|       20660|       46430|       0|        9756|       47150
RTD|       10476|       25468|       43719|       0|        9756|       47150
RTD|       10757|       24755|       42287|       0|        9756|       47150
RTD|       10318|       22870|       42729|       0|        9756|       47150
RTD|       10048|       23250|       42088|       0|        9756|       47150
RTT|  00:00:22  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       10397|       24776|       42740|       0|        9756|       47150
RTD|       11139|       24571|       42279|       0|        9756|       47150
RTD|       10588|       23908|       41904|       0|        9756|       47150
RTD|       10903|       23972|       42684|       0|        9756|       47150
RTD|       10284|       23762|       42883|       0|        9756|       47150
RTD|       11443|       24196|       42245|       0|        9756|       47150
RTD|       11466|       23523|       42617|       0|        9756|       47150
RTD|       11027|       24144|       47712|       0|        9756|       47712
RTD|       11184|       24034|       42628|       0|        9756|       47712
---|--param|----range-|--samples
HSD|    min|   9 - 10 |        2
HSD|    min|  10 - 11 |       19
HSD|    min|  11 - 12 |        9
---|--param|----range-|--samples
HSD|    avg|   9 - 10 |        2
HSD|    avg|  10 - 11 |      122
HSD|    avg|  11 - 12 |      596
HSD|    avg|  12 - 13 |     2635
HSD|    avg|  13 - 14 |     9571
HSD|    avg|  14 - 15 |    15653
HSD|    avg|  15 - 16 |    11973
HSD|    avg|  16 - 17 |     8793
HSD|    avg|  17 - 18 |    13341
HSD|    avg|  18 - 19 |     9352
HSD|    avg|  19 - 20 |     6651
HSD|    avg|  20 - 21 |     4120
HSD|    avg|  21 - 22 |     3716
HSD|    avg|  22 - 23 |     5224
HSD|    avg|  23 - 24 |     9697
HSD|    avg|  24 - 25 |    23295
HSD|    avg|  25 - 26 |    40964
HSD|    avg|  26 - 27 |    46949
HSD|    avg|  27 - 28 |    41781
HSD|    avg|  28 - 29 |    25332
HSD|    avg|  29 - 30 |    10931
HSD|    avg|  30 - 31 |     3039
HSD|    avg|  31 - 32 |      690
HSD|    avg|  32 - 33 |      206
HSD|    avg|  33 - 34 |      123
HSD|    avg|  34 - 35 |      118
HSD|    avg|  35 - 36 |      220
HSD|    avg|  36 - 37 |      494
HSD|    avg|  37 - 38 |      889
HSD|    avg|  38 - 39 |     1259
HSD|    avg|  39 - 40 |     1185
HSD|    avg|  40 - 41 |     1019
HSD|    avg|  41 - 42 |      379
HSD|    avg|  42 - 43 |       77
HSD|    avg|  43 - 44 |        7
HSD|    avg|  44 - 45 |        3
HSD|    avg|  45 - 46 |        5
HSD|    avg|  46 - 47 |        2
HSD|    avg|  47 - 48 |        2
---|--param|----range-|--samples
HSD|    max|  41 - 42 |        1
HSD|    max|  42 - 43 |       17
HSD|    max|  43 - 44 |        4
HSD|    max|  44 - 45 |        2
HSD|    max|  45 - 46 |        3
HSD|    max|  46 - 47 |        1
HSD|    max|  47 - 48 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        30|     10.233|      0.568
HSS|    avg|    300415|     23.372|      5.336
HSS|    max|        30|     43.000|      1.619
---|------------|------------|------------|--------|-------------------------
RTS|        9756|       23880|       47712|       0|    00:00:30/00:00:30

Fri Feb 24 20:37:59 MST 2006
running: ./run -- -h -T 30 -s -h -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         604|        5786|       15530|       0|         604|       15530
RTD|         547|        6045|       19344|       0|         547|       19344
RTD|         232|        7997|       35433|       0|         232|       35433
RTD|         536|        6108|       21811|       0|         232|       35433
RTD|         693|        6283|       19062|       0|         232|       35433
RTD|        1335|        7236|       24702|       0|         232|       35433
RTD|         896|        6733|       27398|       0|         232|       35433
RTD|         705|        6513|       18114|       0|         232|       35433
RTD|         765|        6282|       22831|       0|         232|       35433
RTD|        1305|        7250|       22516|       0|         232|       35433
RTD|         731|        6910|       20600|       0|         232|       35433
RTD|         484|        4973|       23742|       0|         232|       35433
RTD|         394|        7362|       24683|       0|         232|       35433
RTD|         469|        7145|       26284|       0|         232|       35433
RTD|         671|        6531|       17180|       0|         232|       35433
RTD|         559|        6083|       21488|       0|         232|       35433
RTD|         648|        7210|       25429|       0|         232|       35433
RTD|         525|        6382|       19801|       0|         232|       35433
RTD|        -259|        4791|       22527|       0|        -259|       35433
RTD|         682|        7543|       28459|       0|        -259|       35433
RTD|        -180|        6725|       23142|       0|        -259|       35433
RTT|  00:00:22  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|         266|        4974|       20690|       0|        -259|       35433
RTD|        -270|        7325|       28410|       0|        -270|       35433
RTD|         472|        7814|       27536|       0|        -270|       35433
RTD|         356|        6125|       24567|       0|        -270|       35433
RTD|         765|        6185|       28635|       0|        -270|       35433
RTD|         457|        6613|       30885|       0|        -270|       35433
RTD|       -2557|        7471|       30930|       0|       -2557|       35433
RTD|         472|        6674|       28189|       0|       -2557|       35433
---|--param|----range-|--samples
HSD|    min|   0 -  1 |       26
HSD|    min|   1 -  2 |        2
HSD|    min|   2 -  3 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |      453
HSD|    avg|   1 -  2 |    14702
HSD|    avg|   2 -  3 |    41248
HSD|    avg|   3 -  4 |    38015
HSD|    avg|   4 -  5 |    13710
HSD|    avg|   5 -  6 |     4129
HSD|    avg|   6 -  7 |    13221
HSD|    avg|   7 -  8 |    38982
HSD|    avg|   8 -  9 |    52208
HSD|    avg|   9 - 10 |    49385
HSD|    avg|  10 - 11 |    24651
HSD|    avg|  11 - 12 |     3992
HSD|    avg|  12 - 13 |      342
HSD|    avg|  13 - 14 |       56
HSD|    avg|  14 - 15 |       43
HSD|    avg|  15 - 16 |       20
HSD|    avg|  16 - 17 |       18
HSD|    avg|  17 - 18 |       11
HSD|    avg|  18 - 19 |       10
HSD|    avg|  19 - 20 |       13
HSD|    avg|  20 - 21 |        3
HSD|    avg|  21 - 22 |        2
HSD|    avg|  22 - 23 |        4
HSD|    avg|  23 - 24 |        2
HSD|    avg|  24 - 25 |        3
HSD|    avg|  25 - 26 |        2
HSD|    avg|  26 - 27 |        1
HSD|    avg|  27 - 28 |        2
HSD|    avg|  28 - 29 |        4
HSD|    avg|  30 - 31 |        2
HSD|    avg|  35 - 36 |        1
---|--param|----range-|--samples
HSD|    max|  15 - 16 |        1
HSD|    max|  17 - 18 |        1
HSD|    max|  18 - 19 |        1
HSD|    max|  19 - 20 |        3
HSD|    max|  20 - 21 |        2
HSD|    max|  21 - 22 |        2
HSD|    max|  22 - 23 |        3
HSD|    max|  23 - 24 |        2
HSD|    max|  24 - 25 |        3
HSD|    max|  25 - 26 |        1
HSD|    max|  26 - 27 |        1
HSD|    max|  27 - 28 |        2
HSD|    max|  28 - 29 |        4
HSD|    max|  30 - 31 |        2
HSD|    max|  35 - 36 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|      0.138|      0.441
HSS|    avg|    295235|      6.093|      3.004
HSS|    max|        29|     23.621|      4.555
---|------------|------------|------------|--------|-------------------------
RTS|       -2557|        6588|       35433|       0|    00:00:30/00:00:30

Fri Feb 24 20:38:58 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     295848          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       9290          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      73744          XT-PIC  eth0
 14:     823581          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:38:58 MST 2006
running: cat /proc/loadavg
4.94 3.98 2.17 5/38 3221

Fri Feb 24 20:38:58 MST 2006
running: top -bn1c
top - 20:38:59 up 19 min,  1 user,  load average: 4.94, 3.98, 2.17
Tasks:  40 total,   5 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s): 24.8% us, 61.4% sy,  0.0% ni, 13.4% id,  0.1% wa,  0.0% hi,  0.3% si
Mem:    126364k total,   123964k used,     2400k free,   104732k buffers
Swap:        0k total,        0k used,        0k free,     6908k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2886 root      22   0  1584  380  316 R 31.4  0.3   0:43.38 dd if /dev/hda of  
 2888 root      25   0  1584  384  316 R 19.2  0.3   0:43.06 dd if /dev/hda of  
 2887 root      19   0  1588  380  316 R 17.4  0.3   0:45.32 dd if /dev/hda of  
 2889 root      20   0  1584  384  316 R 17.4  0.3   0:47.73 dd if /dev/hda of  
 3225 root      15   0  2128  920  736 R  7.0  0.7   0:00.15 top -bn1c          
 1462 root      16   0  3864 3864 3192 S  1.7  3.1   0:01.11 /usr/sbin/ntpd -p  

Script done on Fri Feb 24 20:38:59 2006

--------------050806040309010809000501
Content-Type: text/plain;
 name="test-2.6.15.1-ipipe-120-sk-060224.203913"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="test-2.6.15.1-ipipe-120-sk-060224.203913"

Script started on Fri Feb 24 20:39:13 2006
creating workload using dd if=/dev/hda
running ./xeno-test -T 30 -s -q

Fri Feb 24 20:39:14 MST 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: Geode by NSC
cpu family	: 5
model		: 9
model name	: Unknown
stepping	: 1
cpu MHz		: 266.700
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 534.86


Fri Feb 24 20:39:14 MST 2006
running: cat /proc/meminfo
MemTotal:       126364 kB
MemFree:          2912 kB
Buffers:        104732 kB
Cached:           7292 kB
SwapCached:          0 kB
Active:          73456 kB
Inactive:        43896 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126364 kB
LowFree:          2912 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          10800 kB
Slab:             5316 kB
CommitLimit:     63180 kB
Committed_AS:     9200 kB
PageTables:        240 kB
VmallocTotal:   909292 kB
VmallocUsed:       356 kB
VmallocChunk:   907640 kB

Fri Feb 24 20:39:14 MST 2006
running: zgrep XENO /proc/config.gz
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_SYS_HEAPSZ=128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_WATCHDOG is not set
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_HW_FPU=y
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_OPT_NATIVE_INTR=y
CONFIG_XENO_SKIN_POSIX=m
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=m
# CONFIG_XENO_SKIN_UVM is not set
CONFIG_XENO_DRIVERS_16550A=m
CONFIG_XENO_DRIVERS_TIMERBENCH=m

Fri Feb 24 20:39:14 MST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Fri Feb 24 20:39:14 MST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Fri Feb 24 20:39:14 MST 2006
running: cat /proc/ipipe/version
1.2-00

Fri Feb 24 20:39:14 MST 2006
running: generate_loads 4
dd workload started, pids 3276 3277 3278 3279

Fri Feb 24 20:39:14 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     300499          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:      11962          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      75304          XT-PIC  eth0
 14:     836693          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:39:16 MST 2006
running: cat /proc/loadavg
4.01 3.82 2.15 5/38 3283

Fri Feb 24 20:39:17 MST 2006
running: top -bn1c
top - 20:39:19 up 20 min,  1 user,  load average: 4.01, 3.82, 2.15
Tasks:  40 total,   5 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s): 24.5% us, 60.8% sy,  0.0% ni, 14.3% id,  0.1% wa,  0.0% hi,  0.3% si
Mem:    126364k total,   123532k used,     2832k free,   104068k buffers
Swap:        0k total,        0k used,        0k free,     7292k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 3278 root      16   0  1584  388  316 R 46.3  0.3   0:00.31 dd if /dev/hda of  
 3279 root      16   0  1584  384  316 R 35.1  0.3   0:00.31 dd if /dev/hda of  
 3287 root      15   0  2132  916  736 R  8.0  0.7   0:00.13 top -bn1c          
    1 root      16   0  1584  520  452 S  0.0  0.4   0:02.04 init [3]           
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 [ksoftirqd/0]      
    3 root      RT   0     0    0    0 S  0.0  0.0   0:00.17 [watchdog/0]       

Fri Feb 24 20:39:22 MST 2006
running: ./run -- -T 30 -s -q -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
warming up...
running quietly for 30 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|     24.931|      0.593
HSS|    avg|    299931|     36.095|      4.858
HSS|    max|        29|     48.172|      1.834
---|------------|------------|------------|--------|-------------------------
RTS|       24686|       36591|       54743|       0|    00:00:30/00:00:30

Fri Feb 24 20:40:30 MST 2006
running: ./run -- -T 30 -s -q -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
warming up...
running quietly for 30 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|     10.621|      0.561
HSS|    avg|    299927|     24.502|      5.391
HSS|    max|        29|     36.034|      1.700
---|------------|------------|------------|--------|-------------------------
RTS|        9051|       25004|       43127|       0|    00:00:30/00:00:30

Fri Feb 24 20:41:32 MST 2006
running: ./run -- -T 30 -s -q -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
warming up...
running quietly for 30 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        29|      0.138|      0.351
HSS|    avg|    299546|      6.504|      3.066
HSS|    max|        29|     17.793|      1.656
---|------------|------------|------------|--------|-------------------------
RTS|         379|        6999|       20975|       0|    00:00:30/00:00:30

Fri Feb 24 20:42:33 MST 2006
running: cat /proc/interrupts
           CPU0       
  0:     349639          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:      12178          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      81429          XT-PIC  eth0
 14:    1247037          XT-PIC  ide0
NMI:          0 
ERR:          0

Fri Feb 24 20:42:33 MST 2006
running: cat /proc/loadavg
5.09 4.52 2.74 5/38 3611

Fri Feb 24 20:42:33 MST 2006
running: top -bn1c
top - 20:42:34 up 23 min,  1 user,  load average: 5.09, 4.52, 2.74
Tasks:  40 total,   5 running,  35 sleeping,   0 stopped,   0 zombie
Cpu(s): 23.2% us, 64.1% sy,  0.0% ni, 12.3% id,  0.1% wa,  0.0% hi,  0.3% si
Mem:    126364k total,   124000k used,     2364k free,   104816k buffers
Swap:        0k total,        0k used,        0k free,     6900k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 3277 root      25   0  1584  384  316 R 29.4  0.3   0:51.05 dd if /dev/hda of  
 3278 root      25   0  1584  388  316 R 22.4  0.3   0:43.78 dd if /dev/hda of  
 3276 root      19   0  1584  384  316 R 17.3  0.3   0:41.32 dd if /dev/hda of  
 3279 root      20   0  1584  384  316 R 15.5  0.3   0:46.45 dd if /dev/hda of  
 3615 root      16   0  2128  920  736 R 15.5  0.7   0:00.19 top -bn1c          
    4 root      10  -5     0    0    0 S  3.5  0.0   0:01.08 [events/0]         

Script done on Fri Feb 24 20:42:34 2006

--------------050806040309010809000501--

