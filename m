Message-ID: <20060905143639.53778.qmail@domain.hid>
Date: Tue, 5 Sep 2006 15:36:39 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
In-Reply-To: <44FD5D64.2080204@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-353905886-1157466999=:52963"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-core] RTAI Vs Xenomai performance
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Miguel Angel Alvarez <ma.alvarez@domain.hid>
Cc: xenomai@xenomai.org

--0-353905886-1157466999=:52963
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

HI Jan,

I am runnng the testsuite given by RTAI and Xenomai,

I need to this figures to compare on performance for
the doc to port XENOMAI on MIPS.

I see RTAI gives results in nanoseconds and XENOMAI in
microsecond, so i should say latency with Xenomai is
3000 micrsecond where as RTAI its 3000 Nanosecond ,
correct me if I am wrong. 
I have attached both testsuite reults 

Thanks In Advance 
Neelu

--- Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Miguel Angel Alvarez wrote:
> > I am also very intrerested in this kind of porting
> guidance, because I
> > have to evaluate the difficulties in porting
> Xenomai (and Adeos) into
> > Coldfire v4 (m68k) architecture.
> 
> See this posting for the Adeos part:
> 
>
https://mail.gna.org/public/adeos-main/2006-09/msg00001.html
> 
> Regarding the porting effort of Xenomai: I would
> recommend to browse
> through existing architectures, e.g. Blackfin, in
> order to asses the
> amount and complexity of services you have to deal
> with.
> 
> Jan
> 
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
--0-353905886-1157466999=:52963
Content-Type: text/plain; name="xenomia.txt"
Content-Description: 38837299-xenomia.txt
Content-Disposition: inline; filename="xenomia.txt"

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.363|       1.307|       6.443|       0|       0.363|       6.443
RTD|       0.259|      68.339|     594.219|       5|       0.259|     594.219
RTD|     500.179|      18.290|     506.059|       5|       0.259|     594.219
RTD|     500.254|      18.285|     505.818|       5|       0.259|     594.219
RTD|     500.265|      18.323|     506.288|       5|       0.259|     594.219
RTD|     500.212|      18.288|     508.575|       5|       0.259|     594.219
RTD|     500.354|      -2.511|    1129.323|      11|       0.259|    1129.323
RTD|    1100.297|     -25.688|    1108.217|      11|       0.259|    1129.323
RTD|    1100.244|     -25.686|    1108.423|      11|       0.259|    1129.323
RTD|    1100.177|     -25.686|    1108.608|      11|       0.259|    1129.323
RTD|    1100.172|      16.570|    1675.939|      16|       0.259|    1675.939
RTD|    1600.103|      -8.670|    1608.491|      16|       0.259|    1675.939
RTD|    1600.266|      -8.666|    1608.856|      16|       0.259|    1675.939
RTD|    1600.227|      -8.665|    1608.532|      16|       0.259|    1675.939
RTD|    1600.025|      -8.662|    1608.813|      16|       0.259|    1675.939
RTD|    1600.415|      29.702|    2202.194|      21|       0.259|    2202.194
RTD|    2100.416|       8.355|    2108.844|      21|       0.259|    2202.194
RTD|    2100.301|       8.355|    2108.579|      21|       0.259|    2202.194
RTD|    2100.323|       8.350|    2108.491|      21|       0.259|    2202.194
RTD|    2100.137|       8.352|    2108.733|      21|       0.259|    2202.194
RTD|    2100.402|      42.772|    2661.862|      26|       0.259|    2661.862
RTT|  00:00:22  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|    2600.325|      25.370|    2608.703|      26|       0.259|    2661.862
RTD|    2600.041|      25.371|    2608.807|      26|       0.259|    2661.862
RTD|    2600.179|      25.368|    2608.871|      26|       0.259|    2661.862
RTD|    2600.228|      38.876|    3201.108|      31|       0.259|    3201.108
RTD|    3100.178|      42.382|    3109.105|      31|       0.259|    3201.108
RTD|    3098.880|      42.348|    3108.497|      31|       0.259|    3201.108
RTD|    3098.891|      42.361|    3109.042|      31|       0.259|    3201.108
RTD|    3100.342|      42.399|    3108.477|      31|       0.259|    3201.108
RTD|    3100.263|      52.008|    3648.872|      36|       0.259|    3648.872
RTD|    3600.352|      59.412|    3608.707|      36|       0.259|    3648.872
RTD|    3600.307|      59.408|    3608.992|      36|       0.259|    3648.872
RTD|    3600.490|      59.400|    3608.473|      36|       0.259|    3648.872
RTD|    3600.300|      59.404|    3609.087|      36|       0.259|    3648.872
RTD|    3600.145|      65.078|    4192.166|      41|       0.259|    4192.166
RTD|    3748.422|      76.426|    4108.637|      41|       0.259|    4192.166
RTD|    3748.422|      76.424|    4108.577|      41|       0.259|    4192.166
RTD|    3748.422|      76.427|    4108.534|      41|       0.259|    4192.166
RTD|    3748.422|      76.423|    4108.954|      41|       0.259|    4192.166
RTD|    3748.422|      14.152|    4725.161|      47|       0.259|    4725.161
RTD|    3748.422|      32.450|    4708.704|      47|       0.259|    4725.161
RTD|    3748.422|      32.474|    4708.777|      47|       0.259|    4725.161
RTT|  00:00:43  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|    3748.422|      32.828|    4709.061|      47|       0.259|    4725.161
RTD|    3748.422|      13.545|    5283.359|      52|       0.259|    5283.359
RTD|    3748.422|      49.468|    5208.796|      52|       0.259|    5283.359
RTD|    3748.422|      49.476|    5208.802|      52|       0.259|    5283.359
RTD|    3748.422|      49.515|    5206.228|      52|       0.259|    5283.359
RTD|    3748.422|      49.675|    5209.012|      52|       0.259|    5283.359
RTD|    3748.422|      26.429|    5804.913|      57|       0.259|    5804.913
RTD|    3748.422|      66.488|    5706.163|      57|       0.259|    5804.913
RTD|    3748.422|      66.476|    5704.432|      57|       0.259|    5804.913
RTD|    3748.422|      66.498|    5709.131|      57|       0.259|    5804.913
RTD|    3748.422|      66.489|    5708.325|      57|       0.259|    5804.913
RTD|    3748.422|      39.510|    6266.696|      62|       0.259|    6266.696
RTD|    3748.422|     -77.488|    6208.753|      62|       0.259|    6266.696
RTD|    3748.422|     -77.498|    6208.562|      62|       0.259|    6266.696
RTD|    3748.422|     -77.530|    6208.813|      62|       0.259|    6266.696
RTD|    3748.422|      58.445|    6825.149|      68|       0.259|    6825.149
RTD|    3748.422|      39.918|    6809.005|      68|       0.259|    6825.149
RTD|    3748.422|      39.602|    6808.807|      68|       0.259|    6825.149
RTD|    3748.422|      39.536|    6808.430|      68|       0.259|    6825.149
RTD|    3748.422|      39.530|    6809.025|      68|       0.259|    6825.149
RTD|    3748.422|     -12.254|    7323.088|      73|       0.259|    7323.088
RTT|  00:01:04  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|    3748.422|      56.557|    7308.648|      73|       0.259|    7323.088
RTD|    3748.422|      56.561|    7309.114|      73|       0.259|    7323.088
RTD|    3748.422|      56.821|    7309.103|      73|       0.259|    7323.088
RTD|    3748.422|      56.553|    7308.802|      73|       0.259|    7323.088
---|------------|------------|------------|--------|-------------------------
RTS|       0.259|      29.107|    7323.088|      73|    00:01:08/00:01:08


Switches:

*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|        2927|        2994|       10480|           0



On running of xeno-test

Tue Sep  5 18:27:07 IST 2006
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 9
cpu MHz         : 2667.789
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni monitor ds_cpl tm2 cid cx16 xtpr lahf_lm
bogomips        : 5338.98


Tue Sep  5 18:27:07 IST 2006
running: cat /proc/meminfo
MemTotal:      1262752 kB
MemFree:       1020400 kB
Buffers:         14696 kB
Cached:         128676 kB
SwapCached:          0 kB
Active:         127424 kB
Inactive:        80736 kB
HighTotal:      360384 kB
HighFree:       160704 kB
LowTotal:       902368 kB
LowFree:        859696 kB
SwapTotal:     2200864 kB
SwapFree:      2200864 kB
Dirty:             112 kB
Writeback:           0 kB
Mapped:          95612 kB
Slab:            20076 kB
CommitLimit:   2832240 kB
Committed_AS:   216124 kB
PageTables:       1952 kB
VmallocTotal:   114680 kB
VmallocUsed:      4040 kB
VmallocChunk:   109084 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

Tue Sep  5 18:27:07 IST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Tue Sep  5 18:27:07 IST 2006
running: cat /proc/ipipe/version
1.2-01

Tue Sep  5 18:27:07 IST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Tue Sep  5 18:27:07 IST 2006
running: generate_loads 1
dd workload started, pids 3047

Tue Sep  5 18:27:08 IST 2006
running: cat /proc/interrupts
           CPU0
  0:      65493          XT-PIC  timer
  1:        446          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          3          XT-PIC  ehci_hcd:usb1
  5:          1          XT-PIC  SiS SI7012
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi, ohci_hcd:usb4
 10:       5785          XT-PIC  ohci_hcd:usb2
 11:        502          XT-PIC  ohci_hcd:usb3, ohci1394, eth0
 12:        110          XT-PIC  i8042
 14:      10595          XT-PIC  ide0
NMI:          0
ERR:          0

Tue Sep  5 18:27:08 IST 2006
running: cat /proc/loadavg
0.09 0.29 0.15 4/111 3051

Tue Sep  5 18:27:08 IST 2006
running: top -bn1c
top - 18:27:08 up 4 min,  2 users,  load average: 0.09, 0.29, 0.15
Tasks:  93 total,   2 running,  91 sleeping,   0 stopped,   0 zombie
Cpu(s):  9.3% us,  4.2% sy,  0.2% ni, 75.5% id, 10.9% wa,  0.0% hi,  0.0% si
Mem:   1262752k total,   242980k used,  1019772k free,    14728k buffers
Swap:  2200864k total,        0k used,  2200864k free,   128736k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3047 root      25   0  3612  416  352 R 98.9  0.0   0:00.84 dd if /dev/zero of /dev/null
 3054 root      15   0  2016  880  688 R  2.0  0.1   0:00.01 top -bn1c
    1 root      16   0  1744  568  488 S  0.0  0.0   0:01.51 init [5]

Tue Sep  5 18:27:08 IST 2006
running: ./run -- -q -s -T 120 -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
running quietly for 120 seconds
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|     99.000|      0.000
HSS|    avg|   1199808|     99.000|      0.000
HSS|    max|       119|     99.000|      0.000
---|------------|------------|------------|--------|-------------------------
RTS|     599.762|     -12.757|   13588.819|     129|    00:02:00/00:02:00

Tue Sep  5 18:29:12 IST 2006
running: ./run -- -q -s -T 120 -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Tue Sep  5 18:29:14 IST 2006
running: ./run -- -q -s -T 120 -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Tue Sep  5 18:29:17 IST 2006
running: cat /proc/interrupts
           CPU0
  0:      97807          XT-PIC  timer
  1:        446          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          3          XT-PIC  ehci_hcd:usb1
  5:          1          XT-PIC  SiS SI7012
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi, ohci_hcd:usb4
 10:       7275          XT-PIC  ohci_hcd:usb2
 11:        688          XT-PIC  ohci_hcd:usb3, ohci1394, eth0
 12:        110          XT-PIC  i8042
 14:      11930          XT-PIC  ide0
NMI:          0
ERR:          0

Tue Sep  5 18:29:17 IST 2006
running: cat /proc/loadavg
1.16 0.66 0.31 4/111 3328

Tue Sep  5 18:29:17 IST 2006
running: top -bn1c
top - 18:29:17 up 6 min,  2 users,  load average: 1.16, 0.66, 0.31
Tasks:  93 total,   3 running,  90 sleeping,   0 stopped,   0 zombie
Cpu(s): 14.7% us, 27.3% sy,  0.1% ni, 50.6% id,  7.3% wa,  0.0% hi,  0.0% si
Mem:   1262752k total,   243360k used,  1019392k free,    14872k buffers
Swap:  2200864k total,        0k used,  2200864k free,   128740k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3047 root      25   0  3612  416  352 R 81.4  0.0   2:06.50 dd if /dev/zero of /dev/null
 2618 root      15   0 54092  16m 5720 S  3.3  1.3   0:06.12 /usr/X11R6/bin/X :0 -audit 0 -auth /var/gdm/:0.Xauth -nolisten t 3331 root      18   0  2012  876  688 R  1.6  0.1   0:00.01 top -bn1c










--0-353905886-1157466999=:52963
Content-Type: text/plain; name="rtai.txt"
Content-Description: 3713255956-rtai.txt
Content-Disposition: inline; filename="rtai.txt"



RTAI:

user latency 


## RTAI latency calibration tool ##
# period = 100000 (ns)
# average time = 1 (s)
# use the FPU
# start the timer
# timer_mode is oneshot

RTAI Testsuite - USER latency (all data in nanoseconds)
2006/09/4 19:11:02
RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   overruns
RTD|       -834|       -834|       5027|       7268|       7268|          0
RTD|       -789|       -834|       5025|       8958|       8958|          0
RTD|       -842|       -842|       5086|     550048|     550048|          5
RTD|       -806|       -842|       5041|       9873|     550048|          5
RTD|       -838|       -842|       5026|       9668|     550048|          5
RTD|       -827|       -842|       5025|      10043|     550048|          5
RTD|       -854|       -854|       5083|     577792|     577792|         10
RTD|       -843|       -854|       5045|       7826|     577792|         10
RTD|       -828|       -854|       5034|       9880|     577792|         10
RTD|       -828|       -854|       5040|       9803|     577792|         10
RTD|       -851|       -854|       5029|       9789|     577792|         10
RTD|       -858|       -858|       5088|     624081|     624081|         16
RTD|       -847|       -858|       5050|      10844|     624081|         16
RTD|       -848|       -858|       5038|      11987|     624081|         16
RTD|       -837|       -858|       5017|       9703|     624081|         16
RTD|       -847|       -858|       5035|       9597|     624081|         16
RTD|       -856|       -858|       5092|     565679|     624081|         21
RTD|       -837|       -858|       5037|       9312|     624081|         21
RTD|       -849|       -858|       5039|       9095|     624081|         21
RTD|       -845|       -858|       5032|       6944|     624081|         21
RTD|       -793|       -858|       5037|       9427|     624081|         21
2006/09/4 19:11:22
RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   overruns
RTD|       -834|       -858|       5104|     670192|     670192|         27
RTD|       -823|       -858|       5023|       9994|     670192|         27
RTD|       -843|       -858|       5036|       7234|     670192|         27
RTD|       -790|       -858|       5031|       7278|     670192|         27
RTD|       -853|       -858|       5079|     555364|     670192|         32
RTD|       -843|       -858|       5031|       7755|     670192|         32
RTD|       -806|       -858|       5035|       8324|     670192|         32
RTD|       -840|       -858|       5044|       7924|     670192|         32
RTD|       -847|       -858|       5035|       8338|     670192|         32
RTD|       -821|       -858|       5093|     583296|     670192|         37
RTD|       -799|       -858|       5032|       9944|     670192|         37
RTD|       -847|       -858|       5034|       7712|     670192|         37
RTD|       -837|       -858|       5043|       6900|     670192|         37
RTD|       -803|       -858|       5036|       9563|     670192|         37
RTD|       -826|       -858|       5098|     624773|     670192|         43
RTD|       -804|       -858|       5034|      10006|     670192|         43
RTD|       -842|       -858|       5040|       8195|     670192|         43
RTD|       -857|       -858|       5030|       8998|     670192|         43
RTD|       -826|       -858|       5088|     559181|     670192|         48
RTD|       -827|       -858|       5034|       9261|     670192|         48
RTD|       -801|       -858|       5028|       7763|     670192|         48
2006/09/4 19:11:43
RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   overruns
RTD|       -790|       -858|       5031|      12652|     670192|         48
RTD|       -820|       -858|       5035|       9856|     670192|         48
RTD|       -858|       -858|       5086|     568499|     670192|         53
RTD|       -858|       -858|       5086|     568499|     670192|         53

>>> S = 98.696, EXECTIME = NAN


user-switches

Wait for it ...


FOR 10 TASKS: TIME 17 (ms), SUSP/RES SWITCHES 20000, SWITCH TIME 877 (ns)

FOR 10 TASKS: TIME 19 (ms), SEM SIG/WAIT SWITCHES 20000, SWITCH TIME 966 (ns)

Kern latency

RTAI Testsuite - UP preempt (all data in nanoseconds)
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2063|        3099|        5696|       10659|        4350
RTD|       -2144|        3147|        5696|       10659|        4350
RTD|       -2144|        3305|        5696|       10659|        4350
RTD|       -2144|        3259|        5696|       10659|        4350
RTD|       -2144|        3285|        5696|       10659|        4350
RTD|       -2144|        3292|        5696|       10659|        4350
RTD|       -2144|        3247|        5696|       10659|        4350
RTD|       -2144|        3299|        5696|       10659|        4350
RTD|       -2152|        3216|        5696|       10659|        4350
RTD|       -2152|        3319|        5696|       10659|        4350
RTD|       -2152|        3228|        5696|       10659|        4350
RTD|       -2152|        3344|        5696|       10659|        4350
RTD|       -2152|        3203|        5696|       10659|        4350
RTD|       -2152|        3351|        5696|       10659|        4350
RTD|       -2152|        3208|        5696|       10659|        4350
RTD|       -2152|        3287|        5696|       10659|        4350
RTD|       -2152|        3225|        5696|       10659|        4350
RTD|       -2152|        3307|        5696|       10659|        4350
RTD|       -2152|        3249|        5696|       10659|        4350
RTD|       -2152|        3291|        5696|       10659|        4350
RTD|       -2152|        5160|      564697|      199721|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3243|      564697|      199721|      166231
RTD|       -2152|        3291|      564697|      199721|      166231
RTD|       -2152|        3256|      564697|      199721|      166231
RTD|       -2152|        3317|      564697|      199721|      166231
RTD|       -2152|        3216|      564697|      199721|      166231
RTD|       -2152|        3376|      564697|      199721|      166231
RTD|       -2152|        3209|      564697|      199721|      166231
RTD|       -2152|        3302|      564697|      199721|      166231
RTD|       -2152|        3251|      564697|      199721|      166231
RTD|       -2152|        3305|      564697|      199721|      166231
RTD|       -2152|        3230|      564697|      199721|      166231
RTD|       -2152|        3271|      564697|      199721|      166231
RTD|       -2152|        3301|      564697|      199721|      166231
RTD|       -2152|        3247|      564697|      199721|      166231
RTD|       -2152|        3281|      564697|      199721|      166231
RTD|       -2152|        3261|      564697|      199721|      166231
RTD|       -2152|        2991|      564697|      199721|      166231
RTD|       -2152|        3144|      564697|      199721|      166231
RTD|       -2152|        3248|      564697|      199721|      166231
RTD|       -2152|        3187|      564697|      199721|      166231
RTD|       -2152|        3296|      564697|      199721|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3200|      564697|      199721|      166231
RTD|       -2152|        3309|      564697|      199721|      166231
RTD|       -2152|        3191|      564697|      199721|      166231
RTD|       -2152|        3255|      564697|      199721|      166231
RTD|       -2152|        3207|      564697|      199721|      166231
RTD|       -2152|        3276|      564697|      199721|      166231
RTD|       -2152|        3254|      564697|      199721|      166231
RTD|       -2152|        3229|      564697|      199721|      166231
RTD|       -2152|        3294|      564697|      199721|      166231
RTD|       -2152|        3164|      564697|      199721|      166231
RTD|       -2152|        3296|      564697|      199721|      166231
RTD|       -2152|        3163|      564697|      199721|      166231
RTD|       -2152|        3286|      564697|      199721|      166231
RTD|       -2152|        3112|      564697|      199721|      166231
RTD|       -2152|        3265|      564697|      199721|      166231
RTD|       -2152|        3151|      564697|      199721|      166231
RTD|       -2152|        3193|      564697|      199721|      166231
RTD|       -2152|        3121|      564697|      199721|      166231
RTD|       -2152|        3237|      564697|      199721|      166231
RTD|       -2152|        3155|      564697|      199721|      166231
RTD|       -2152|        3150|      564697|      199721|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3267|      564697|      199721|      166231
RTD|       -2152|        3103|      564697|      199721|      166231
RTD|       -2152|        3222|      564697|      199721|      166231
RTD|       -2152|        3136|      564697|      199721|      166231
RTD|       -2152|        5376|      612767|      199759|      166231
RTD|       -2152|        3047|      612767|      199759|      166231
RTD|       -2152|        3227|      612767|      199759|      166231
RTD|       -2152|        3199|      612767|      199759|      166231
RTD|       -2152|        3329|      612767|      199759|      166231
RTD|       -2152|        3264|      612767|      199759|      166231
RTD|       -2152|        3285|      612767|      199759|      166231
RTD|       -2152|        3261|      612767|      199759|      166231
RTD|       -2152|        3275|      612767|      199759|      166231
RTD|       -2152|        3331|      612767|      199759|      166231
RTD|       -2152|        3210|      612767|      199759|      166231
RTD|       -2152|        3327|      612767|      199759|      166231
RTD|       -2152|        3222|      612767|      199759|      166231
RTD|       -2152|        3343|      612767|      199759|      166231
RTD|       -2152|        3191|      612767|      199759|      166231
RTD|       -2152|        3334|      612767|      199759|      166231
RTD|       -2152|        3211|      612767|      199759|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3328|      612767|      199759|      166231
RTD|       -2152|        3227|      612767|      199759|      166231
RTD|       -2152|        3310|      612767|      199759|      166231
RTD|       -2152|        3291|      612767|      199759|      166231
RTD|       -2152|        3278|      612767|      199759|      166231
RTD|       -2152|        3286|      612767|      199759|      166231
RTD|       -2152|        3235|      612767|      199759|      166231
RTD|       -2152|        3299|      612767|      199759|      166231
RTD|       -2152|        3209|      612767|      199759|      166231
RTD|       -2152|        3337|      612767|      199759|      166231
RTD|       -2152|        3192|      612767|      199759|      166231
RTD|       -2152|        3352|      612767|      199759|      166231
RTD|       -2152|        3205|      612767|      199759|      166231
RTD|       -2152|        3341|      612767|      199759|      166231
RTD|       -2152|        3207|      612767|      199759|      166231
RTD|       -2152|        3304|      612767|      199759|      166231
RTD|       -2152|        3230|      612767|      199759|      166231
RTD|       -2152|        3272|      612767|      199759|      166231
RTD|       -2152|        3274|      612767|      199759|      166231
RTD|       -2152|        3249|      612767|      199759|      166231
RTD|       -2152|        3324|      612767|      199759|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3109|      612767|      199759|      166231
RTD|       -2152|        3141|      612767|      199759|      166231
RTD|       -2152|        3183|      612767|      199759|      166231
RTD|       -2152|        3291|      612767|      199759|      166231
RTD|       -2152|        3168|      612767|      199759|      166231
RTD|       -2152|        3302|      612767|      199759|      166231
RTD|       -2152|        3189|      612767|      199759|      166231
RTD|       -2152|        3275|      612767|      199759|      166231
RTD|       -2152|        3167|      612767|      199759|      166231
RTD|       -2152|        5084|      612767|      199759|      166231
RTD|       -2152|        3220|      612767|      199759|      166231
RTD|       -2152|        3236|      612767|      199759|      166231
RTD|       -2152|        3252|      612767|      199759|      166231
RTD|       -2152|        3209|      612767|      199759|      166231
RTD|       -2152|        3239|      612767|      199759|      166231
RTD|       -2152|        3161|      612767|      199759|      166231
RTD|       -2152|        3258|      612767|      199759|      166231
RTD|       -2152|        3097|      612767|      199759|      166231
RTD|       -2152|        3340|      612767|      199759|      166231
RTD|       -2152|        3104|      612767|      199759|      166231
RTD|       -2152|        3280|      612767|      199759|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3160|      612767|      199759|      166231
RTD|       -2152|        3227|      612767|      199759|      166231
RTD|       -2152|        3228|      612767|      199759|      166231
RTD|       -2152|        3254|      612767|      199759|      166231
RTD|       -2152|        3228|      612767|      199759|      166231
RTD|       -2152|        3220|      612767|      199759|      166231
RTD|       -2152|        3238|      612767|      199759|      166231
RTD|       -2152|        3163|      612767|      199759|      166231
RTD|       -2152|        3287|      612767|      199759|      166231
RTD|       -2152|        3184|      612767|      199759|      166231
RTD|       -2152|        3227|      612767|      199759|      166231
RTD|       -2152|        3098|      612767|      199759|      166231
RTD|       -2152|        3325|      612767|      199759|      166231
RTD|       -2152|        3204|      612767|      199759|      166231
RTD|       -2152|        3291|      612767|      199759|      166231
RTD|       -2152|        3245|      612767|      199759|      166231
RTD|       -2152|        3301|      612767|      199759|      166231
RTD|       -2152|        3280|      612767|      199759|      166231
RTD|       -2152|        3286|      612767|      199759|      166231
RTD|       -2152|        3294|      612767|      199759|      166231
RTD|       -2152|        3231|      612767|      199759|      166231
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3295|      612767|      199759|      166231
RTD|       -2152|        3256|      612767|      199759|      166231
RTD|       -2152|        3337|      612767|      199759|      166231
RTD|       -2152|        3228|      612767|      199759|      166231
RTD|       -2152|        3338|      612767|      199759|      166231
RTD|       -2152|        3216|      612767|      199759|      166231
RTD|       -2152|        3301|      612767|      199759|      166231
RTD|       -2152|        3259|      612767|      199759|      166231
RTD|       -2152|        3284|      612767|      199759|      166231
RTD|       -2152|        3272|      612767|      199759|      166231
RTD|       -2152|        3270|      612767|      199759|      166231
RTD|       -2152|        3289|      612767|      199759|      166231
RTD|       -2152|        3247|      612767|      199759|      166231
RTD|       -2152|        3314|      612767|      199759|      166231
RTD|       -2152|        5127|      612767|      199759|      870625
RTD|       -2152|        3348|      612767|      199759|      870625
RTD|       -2152|        3192|      612767|      199759|      870625
RTD|       -2152|        3368|      612767|      199759|      870625
RTD|       -2152|        3208|      612767|      199759|      870625
RTD|       -2152|        3293|      612767|      199759|      870625
RTD|       -2152|        3234|      612767|      199759|      870625
RTH|     lat min|     lat avg|     lat max|    jit fast|    jit slow
RTD|       -2152|        3295|      612767|      199759|      870625
RTD|       -2152|        3262|      612767|      199759|      870625
RTD|       -2152|        3287|      612767|      199759|      870625
RTD|       -2152|        3296|      612767|      199759|      870625
RTD|       -2152|        3265|      612767|      199759|      870625
RTD|       -2152|        3179|      612767|      199759|      870625
RTD|       -2152|        3095|      612767|      199759|      870625
RTD|       -2152|        3303|      612767|      199759|      870625
RTD|       -2152|        3187|      612767|      199759|      870625
RTD|       -2152|        3300|      612767|      199759|      870625
RTD|       -2152|        3128|      612767|      199759|      870625
RTD|       -2152|        3334|      612767|      199759|      870625
RTD|       -2152|        3163|      612767|      199759|      870625
RTD|       -2152|        3277|      612767|      199759|      870625
RTD|       -2152|        3160|      612767|      199759|      870625
RTD|       -2152|        3258|      612767|      199759|      870625
RTD|       -2152|        3235|      612767|      199759|      870625
RTD|       -2152|        3230|      612767|      199759|      870625
RTD|       -2152|        3239|      612767|      199759|      870625
RTD|       -2152|        3239|      612767|      199759|      870625
















--0-353905886-1157466999=:52963--

