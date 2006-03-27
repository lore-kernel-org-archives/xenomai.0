Message-ID: <44280C96.1030608@domain.hid>
Date: Mon, 27 Mar 2006 11:02:30 -0500
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040700080406070705080201"
Subject: [Xenomai-core] errors to console when running xeno-test (latency -t
	1)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040700080406070705080201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hello xenophiles,

Im getting errors to the console when running latency -t 1.
they also appear in dmesg output

RTD|      16.615|      32.201|      44.845|       0|      14.054|      
45.621
[  917.477135] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      15.832|      32.166|      44.756|       0|      14.054|      
45.621
[  918.476991] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      14.542|      32.206|      44.098|       0|      14.054|      
45.621
[  919.476834] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      14.669|      32.172|      44.248|       0|      14.054|      
45.621
[  920.476706] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      15.326|      32.175|      43.045|       0|      14.054|      
45.621
[  921.476535] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      15.048|      32.216|      44.695|       0|      14.054|      
45.621
[  922.476384] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      15.344|      32.220|      52.680|       0|      14.054|      
52.680
[  923.476234] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      16.360|      32.206|      43.913|       0|      14.054|      
52.680
[  924.476085] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      14.384|      32.211|      44.275|       0|      14.054|      
52.680
[  925.475933] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      14.883|      32.181|      43.601|       0|      14.054|      
52.680
[  926.475783] invalid use of FPU in Xenomai context at 0xb7e488bc
RTD|      14.684|      32.199|      44.587|       0|      14.054|      
52.680

Ive attached a logfile, written by xeno-test.  Hopefully it has enough 
detail
for you to diagnose my problem ;-)

(actually, there are probably trivial additions to xeno-test that
would enhance the info it provides for debugging purposes
forex:  it currently greps XENO out of /proc/config.gz,
if you identify other CONFIG_* items that are worth collecting,
I'll add them. ( PREEMPT, MUTEX, ...).
Or it can just cat /proc/config.gz to the log, and get everything.


Also, my brand new 2.6.16-ipipe-121 kernel took quite a long time to boot.
Ive seen this intermittently thru 2.6.1[45]-* series, mostly in -mm*, 
-rc* too (I think)
but have never isolated any cause.  So its probably my setup somehow...


At some risk of running on too long, Ive noticed an oddity in dmesg output:
do these large timestamps b4 zeroing matter ?

soekris:/usr/xenomai/bin# dmesg |more
[17179569.184000] Linux version 2.6.16-ipipe-121-sk 
(jimc@domain.hid) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) 
#4 Sun Mar 26 20:07:17 EST 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
[17179569.184000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[17179569.184000] 128MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 32768
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
[17179569.184000]   Normal zone: 28672 pages, LIFO batch:7
[17179569.184000]   HighMem zone: 0 pages, LIFO batch:0
[17179569.184000] DMI not present or invalid.
[17179569.184000] Allocating PCI resources starting at 10000000 (gap: 
08000000:f7f00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: console=ttyS0,115200n81 
root=/dev/nfs nfsroot=192.168.42.1:/nfshost/truck 
nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5 initrd=initrd-2.6.16-ipipe-121-sk.img  
BOOT_IMAGE=vmlinuz-2.6.16-ipipe-121-sk
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 1024 (order: 10, 16384 bytes)
[    0.000000] Detected 266.696 MHz processor.
[   20.833323] Using tsc for high-res timesource
[   20.833436] I-pipe 1.2-01: pipeline enabled.
[   20.833781] Console: colour dummy device 80x25
[   20.956810] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[   20.966149] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[   21.009759] Memory: 126112k/131072k available (1602k kernel code, 
4540k reserved, 741k data, 120k init, 0k highmem)


--------------040700080406070705080201
Content-Type: text/plain;
 name="test-2.6.16-ipipe-121-sk-060326.174000"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="test-2.6.16-ipipe-121-sk-060326.174000"

Script started on Sun Mar 26 17:40:00 2006
running ./xeno-test -T 60 -h -s -l 0

Sun Mar 26 17:40:01 PST 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: Geode by NSC
cpu family	: 5
model		: 9
model name	: Unknown
stepping	: 1
cpu MHz		: 266.696
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 536.58


Sun Mar 26 17:40:01 PST 2006
running: cat /proc/meminfo
MemTotal:       126264 kB
MemFree:         96900 kB
Buffers:             8 kB
Cached:          16168 kB
SwapCached:          0 kB
Active:          17240 kB
Inactive:         5168 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126264 kB
LowFree:         96900 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:          12944 kB
Slab:             4744 kB
CommitLimit:     63132 kB
Committed_AS:    11156 kB
PageTables:        248 kB
VmallocTotal:   909292 kB
VmallocUsed:       900 kB
VmallocChunk:   907632 kB

Sun Mar 26 17:40:01 PST 2006
running: zgrep XENO /proc/config.gz
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_SECURITY_ACCESS=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
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
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set
CONFIG_XENO_HW_FPU=y
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set
CONFIG_XENO_SKIN_NATIVE=y
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
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=m
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
CONFIG_XENO_SKIN_RTAI=m
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=m
CONFIG_XENO_SKIN_UVM=m
CONFIG_XENO_DRIVERS_16550A=m
CONFIG_XENO_DRIVERS_TIMERBENCH=m

Sun Mar 26 17:40:02 PST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Sun Mar 26 17:40:02 PST 2006
running: cat /proc/ipipe/Linux_stats
> STALL TIME:
CPU0       5508577  (__ipipe_test_and_stall_root+0x0)
> PROPAGATION TIME:
IRQ         CPU0
  0:     10059274
  3:        14962
  4:      9832850
  8:         5400
 10:      7499258
 11:      9789913
 14:        16142
 32:       278235
 33:       608097

Sun Mar 26 17:40:02 PST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0: grabbed
irq1-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Sun Mar 26 17:40:02 PST 2006
running: cat /proc/ipipe/Xenomai_stats
> STALL TIME:
CPU0         63973  (__ipipe_sync_stage+0xeb)
> PROPAGATION TIME:
IRQ         CPU0
  0:        43820
 34:         8928

Sun Mar 26 17:40:02 PST 2006
running: cat /proc/ipipe/version
1.2-01

Sun Mar 26 17:40:03 PST 2006
running: generate_loads 1
dd workload started, pids 2267

Sun Mar 26 17:40:03 PST 2006
running: cat /proc/interrupts
           CPU0       
  0:     199783          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       2969          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      48080          XT-PIC  eth0
 11:     528514          XT-PIC  ndiswrapper
 14:         31          XT-PIC  ide0
NMI:          0 
ERR:          0

Sun Mar 26 17:40:04 PST 2006
running: cat /proc/loadavg
0.08 0.22 0.24 2/39 2271

Sun Mar 26 17:40:05 PST 2006
running: top -bn1c
top - 17:40:06 up 13 min,  1 user,  load average: 0.23, 0.25, 0.25
Tasks:  41 total,   2 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  6.2% us, 37.9% sy,  0.0% ni, 54.7% id,  0.2% wa,  0.0% hi,  0.9% si
Mem:    126264k total,    29888k used,    96376k free,        8k buffers
Swap:        0k total,        0k used,        0k free,    16168k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2267 root      19   0  1720  496  400 R 64.9  0.4   0:02.29 dd if /dev/zero of 
 2275 root      16   0  2264 1004  768 R 23.8  0.8   0:00.52 top -bn1c          
    1 root      16   0  1956  660  564 S  0.0  0.5   0:04.45 init [3]           

Sun Mar 26 17:40:06 PST 2006
running: ./run -- -T 60 -h -s -l 0 -t0
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTD|      25.748|      40.878|      53.315|       0|      25.748|      53.315
RTD|      22.756|      40.810|      53.675|       0|      22.756|      53.675
RTD|      28.601|      40.908|      64.309|       0|      22.756|      64.309
RTD|      27.956|      41.252|      68.227|       0|      22.756|      68.227
RTD|      26.303|      40.937|      61.313|       0|      22.756|      68.227
RTD|      24.736|      40.709|      54.069|       0|      22.756|      68.227
RTD|      21.927|      41.020|      62.625|       0|      21.927|      68.227
RTD|      29.835|      41.091|      60.450|       0|      21.927|      68.227
RTD|      29.153|      41.005|      69.839|       0|      21.927|      69.839
RTD|      25.665|      40.698|      56.431|       0|      21.927|      69.839
RTD|      22.711|      40.915|      65.719|       0|      21.927|      69.839
RTD|      29.734|      40.825|      67.031|       0|      21.927|      69.839
RTD|      30.034|      41.136|      65.111|       0|      21.927|      69.839
RTD|      26.967|      40.810|      64.481|       0|      21.927|      69.839
RTD|      23.029|      40.844|      53.364|       0|      21.927|      69.839
RTD|      21.785|      40.971|      59.532|       0|      21.785|      69.839
RTD|      29.520|      41.252|      66.150|       0|      21.785|      69.839
RTD|      27.803|      40.881|      69.149|       0|      21.785|      69.839
RTD|      26.194|      40.904|      65.921|       0|      21.785|      69.839
RTD|      21.893|      40.791|      72.978|       0|      21.785|      72.978
RTD|      30.424|      41.106|      59.149|       0|      21.785|      72.978
RTD|      29.797|      41.354|      63.705|       0|      21.785|      72.978
RTD|      26.517|      40.922|      59.982|       0|      21.785|      72.978
RTD|      22.126|      40.728|      67.740|       0|      21.785|      72.978
RTD|      25.249|      41.027|      56.671|       0|      21.785|      72.978
RTD|      28.354|      41.215|      66.386|       0|      21.785|      72.978
RTD|      28.470|      41.024|      66.952|       0|      21.785|      72.978
RTD|      25.395|      40.623|      81.568|       0|      21.785|      81.568
RTD|      22.819|      40.915|      59.513|       0|      21.785|      81.568
RTD|      29.314|      41.095|      66.210|       0|      21.785|      81.568
RTD|      29.228|      41.106|      62.610|       0|      21.785|      81.568
RTD|      25.939|      40.615|      66.926|       0|      21.785|      81.568
RTD|      21.590|      40.889|      65.321|       0|      21.590|      81.568
RTD|      27.390|      41.065|      52.902|       0|      21.590|      81.568
RTD|      29.070|      41.234|      68.602|       0|      21.590|      81.568
RTD|      26.993|      41.039|      66.930|       0|      21.590|      81.568
RTD|      25.373|      40.746|      62.805|       0|      21.590|      81.568
RTD|      23.063|      40.964|      61.335|       0|      21.590|      81.568
RTD|      29.681|      41.065|      64.567|       0|      21.590|      81.568
RTD|      29.044|      41.151|      61.110|       0|      21.590|      81.568
RTD|      26.007|      40.889|      66.060|       0|      21.590|      81.568
RTD|      22.512|      40.701|      66.153|       0|      21.590|      81.568
RTD|      31.575|      41.072|      65.066|       0|      21.590|      81.568
RTD|      30.019|      41.339|      66.532|       0|      21.590|      81.568
RTD|      27.019|      40.840|      66.806|       0|      21.590|      81.568
RTD|      25.178|      40.713|      63.694|       0|      21.590|      81.568
RTD|      22.793|      40.922|      65.149|       0|      21.590|      81.568
RTD|      30.367|      40.986|      65.928|       0|      21.590|      81.568
RTD|      29.280|      40.990|      65.910|       0|      21.590|      81.568
RTD|      25.238|      40.799|      64.339|       0|      21.590|      81.568
RTD|      22.557|      40.859|      55.606|       0|      21.590|      81.568
RTD|      31.282|      41.065|      65.089|       0|      21.590|      81.568
RTD|      30.371|      41.376|      66.622|       0|      21.590|      81.568
RTD|      26.370|      40.975|      65.928|       0|      21.590|      81.568
RTD|      24.799|      40.829|      65.640|       0|      21.590|      81.568
RTD|      21.848|      40.952|      67.417|       0|      21.590|      81.568
RTD|      30.379|      41.264|      66.885|       0|      21.590|      81.568
RTD|      29.280|      40.964|      67.170|       0|      21.590|      81.568
RTD|      25.733|      40.893|      65.576|       0|      21.590|      81.568
---|--param|----range-|--samples
HSD|    min|  21 - 22 |        5
HSD|    min|  22 - 23 |        7
HSD|    min|  23 - 24 |        2
HSD|    min|  24 - 25 |        2
HSD|    min|  25 - 26 |        9
HSD|    min|  26 - 27 |        7
HSD|    min|  27 - 28 |        4
HSD|    min|  28 - 29 |        3
HSD|    min|  29 - 30 |       12
HSD|    min|  30 - 31 |        6
HSD|    min|  31 - 32 |        2
---|--param|----range-|--samples
HSD|    avg|  21 - 22 |        5
HSD|    avg|  22 - 23 |       40
HSD|    avg|  23 - 24 |       75
HSD|    avg|  24 - 25 |       95
HSD|    avg|  25 - 26 |      178
HSD|    avg|  26 - 27 |      467
HSD|    avg|  27 - 28 |     1076
HSD|    avg|  28 - 29 |     1482
HSD|    avg|  29 - 30 |     1280
HSD|    avg|  30 - 31 |     1510
HSD|    avg|  31 - 32 |     2199
HSD|    avg|  32 - 33 |     2378
HSD|    avg|  33 - 34 |     1841
HSD|    avg|  34 - 35 |     1082
HSD|    avg|  35 - 36 |     1107
HSD|    avg|  36 - 37 |     2452
HSD|    avg|  37 - 38 |     7112
HSD|    avg|  38 - 39 |    15319
HSD|    avg|  39 - 40 |    69264
HSD|    avg|  40 - 41 |   161981
HSD|    avg|  41 - 42 |   212428
HSD|    avg|  42 - 43 |    83423
HSD|    avg|  43 - 44 |    16504
HSD|    avg|  44 - 45 |     9205
HSD|    avg|  45 - 46 |     2768
HSD|    avg|  46 - 47 |      452
HSD|    avg|  47 - 48 |      154
HSD|    avg|  48 - 49 |       57
HSD|    avg|  49 - 50 |       64
HSD|    avg|  50 - 51 |       65
HSD|    avg|  51 - 52 |       73
HSD|    avg|  52 - 53 |      103
HSD|    avg|  53 - 54 |       78
HSD|    avg|  54 - 55 |      133
HSD|    avg|  55 - 56 |      382
HSD|    avg|  56 - 57 |      872
HSD|    avg|  57 - 58 |     1072
HSD|    avg|  58 - 59 |      742
HSD|    avg|  59 - 60 |      186
HSD|    avg|  60 - 61 |       41
HSD|    avg|  61 - 62 |       31
HSD|    avg|  62 - 63 |        7
HSD|    avg|  63 - 64 |        5
HSD|    avg|  64 - 65 |        5
HSD|    avg|  65 - 66 |       15
HSD|    avg|  66 - 67 |       14
HSD|    avg|  67 - 68 |        5
HSD|    avg|  68 - 69 |        3
HSD|    avg|  69 - 70 |        2
HSD|    avg|  72 - 73 |        1
HSD|    avg|  81 - 82 |        1
---|--param|----range-|--samples
HSD|    max|  52 - 53 |        1
HSD|    max|  53 - 54 |        3
HSD|    max|  54 - 55 |        1
HSD|    max|  55 - 56 |        1
HSD|    max|  56 - 57 |        2
HSD|    max|  59 - 60 |        4
HSD|    max|  60 - 61 |        1
HSD|    max|  61 - 62 |        3
HSD|    max|  62 - 63 |        3
HSD|    max|  63 - 64 |        2
HSD|    max|  64 - 65 |        4
HSD|    max|  65 - 66 |       12
HSD|    max|  66 - 67 |       12
HSD|    max|  67 - 68 |        4
HSD|    max|  68 - 69 |        2
HSD|    max|  69 - 70 |        2
HSD|    max|  72 - 73 |        1
HSD|    max|  81 - 82 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        59|     26.136|      3.054
HSS|    avg|    599834|     40.465|      2.413
HSS|    max|        59|     63.492|      5.066
---|------------|------------|------------|--------|-------------------------
RTS|      21.590|      40.960|      81.568|       0|    00:01:00/00:01:00

Sun Mar 26 17:41:22 PST 2006
running: ./run -- -T 60 -h -s -l 0 -t1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTD|      18.350|      32.283|      44.468|       0|      18.350|      44.468
RTD|      14.369|      32.117|      44.639|       0|      14.369|      44.639
RTD|      15.622|      32.214|      43.577|       0|      14.369|      44.639
RTD|      14.883|      32.125|      44.332|       0|      14.369|      44.639
RTD|      14.054|      32.196|      45.621|       0|      14.054|      45.621
RTD|      14.711|      32.030|      44.539|       0|      14.054|      45.621
RTD|      16.615|      32.201|      44.845|       0|      14.054|      45.621
RTD|      15.832|      32.166|      44.756|       0|      14.054|      45.621
RTD|      14.542|      32.206|      44.098|       0|      14.054|      45.621
RTD|      14.669|      32.172|      44.248|       0|      14.054|      45.621
RTD|      15.326|      32.175|      43.045|       0|      14.054|      45.621
RTD|      15.048|      32.216|      44.695|       0|      14.054|      45.621
RTD|      15.344|      32.220|      52.680|       0|      14.054|      52.680
RTD|      16.360|      32.206|      43.913|       0|      14.054|      52.680
RTD|      14.384|      32.211|      44.275|       0|      14.054|      52.680
RTD|      14.883|      32.181|      43.601|       0|      14.054|      52.680
RTD|      14.684|      32.199|      44.587|       0|      14.054|      52.680
RTD|      14.182|      32.199|      43.990|       0|      14.054|      52.680
RTD|      15.749|      32.193|      44.503|       0|      14.054|      52.680
RTD|      13.638|      32.194|      44.740|       0|      13.638|      52.680
RTD|      14.238|      32.171|      45.034|       0|      13.638|      52.680
RTD|      15.198|      32.218|      43.556|       0|      13.638|      52.680
RTD|      15.314|      32.219|      44.245|       0|      13.638|      52.680
RTD|      13.946|      32.168|      43.408|       0|      13.638|      52.680
RTD|      14.658|      32.173|      45.205|       0|      13.638|      52.680
RTD|      14.291|      32.161|      44.223|       0|      13.638|      52.680
RTD|      15.138|      32.145|      61.836|       0|      13.638|      61.836
RTD|      14.354|      32.039|      44.338|       0|      13.638|      61.836
RTD|      14.887|      32.204|      44.413|       0|      13.638|      61.836
RTD|      14.913|      32.174|      44.488|       0|      13.638|      61.836
RTD|      15.322|      32.183|      44.626|       0|      13.638|      61.836
RTD|      14.572|      32.180|      44.403|       0|      13.638|      61.836
RTD|      14.261|      32.214|      44.230|       0|      13.638|      61.836
RTD|      15.715|      32.175|      44.941|       0|      13.638|      61.836
RTD|      14.572|      32.198|      44.347|       0|      13.638|      61.836
RTD|      14.126|      32.149|      45.243|       0|      13.638|      61.836
RTD|      15.907|      32.132|      44.377|       0|      13.638|      61.836
RTD|      15.483|      32.205|      43.897|       0|      13.638|      61.836
RTD|      13.878|      32.153|      44.017|       0|      13.638|      61.836
RTD|      15.502|      32.195|      43.303|       0|      13.638|      61.836
RTD|      14.561|      32.170|      44.415|       0|      13.638|      61.836
RTD|      15.611|      32.171|      45.610|       0|      13.638|      61.836
RTD|      14.669|      32.208|      43.940|       0|      13.638|      61.836
RTD|      14.324|      32.199|      44.060|       0|      13.638|      61.836
RTD|      15.329|      32.195|      44.353|       0|      13.638|      61.836
RTD|      16.233|      32.140|      44.248|       0|      13.638|      61.836
RTD|      14.504|      32.193|      44.815|       0|      13.638|      61.836
RTD|      15.071|      32.193|      44.833|       0|      13.638|      61.836
RTD|      14.152|      32.215|      45.160|       0|      13.638|      61.836
RTD|      15.011|      32.141|      44.386|       0|      13.638|      61.836
RTD|      16.038|      32.196|      44.287|       0|      13.638|      61.836
RTD|      14.287|      32.164|      44.035|       0|      13.638|      61.836
RTD|      14.594|      32.140|      44.061|       0|      13.638|      61.836
RTD|      14.384|      32.202|      44.776|       0|      13.638|      61.836
RTD|      14.872|      32.222|      43.990|       0|      13.638|      61.836
RTD|      14.707|      31.934|      44.206|       0|      13.638|      61.836
RTD|      13.788|      32.188|      43.195|       0|      13.638|      61.836
RTD|      14.186|      32.186|      43.597|       0|      13.638|      61.836
RTD|      14.943|      32.197|      45.492|       0|      13.638|      61.836
---|--param|----range-|--samples
HSD|    min|  13 - 14 |        4
HSD|    min|  14 - 15 |       32
HSD|    min|  15 - 16 |       18
HSD|    min|  16 - 17 |        4
HSD|    min|  18 - 19 |        1
---|--param|----range-|--samples
HSD|    avg|  13 - 14 |        4
HSD|    avg|  14 - 15 |       32
HSD|    avg|  15 - 16 |       21
HSD|    avg|  16 - 17 |       44
HSD|    avg|  17 - 18 |     1099
HSD|    avg|  18 - 19 |     2175
HSD|    avg|  19 - 20 |     2116
HSD|    avg|  20 - 21 |     5595
HSD|    avg|  21 - 22 |     6734
HSD|    avg|  22 - 23 |     2281
HSD|    avg|  23 - 24 |      571
HSD|    avg|  24 - 25 |      515
HSD|    avg|  25 - 26 |      463
HSD|    avg|  26 - 27 |      570
HSD|    avg|  27 - 28 |      722
HSD|    avg|  28 - 29 |     1054
HSD|    avg|  29 - 30 |     3982
HSD|    avg|  30 - 31 |    29099
HSD|    avg|  31 - 32 |    96142
HSD|    avg|  32 - 33 |   238931
HSD|    avg|  33 - 34 |   183339
HSD|    avg|  34 - 35 |    22579
HSD|    avg|  35 - 36 |      947
HSD|    avg|  36 - 37 |      280
HSD|    avg|  37 - 38 |      127
HSD|    avg|  38 - 39 |       79
HSD|    avg|  39 - 40 |       54
HSD|    avg|  40 - 41 |       47
HSD|    avg|  41 - 42 |       37
HSD|    avg|  42 - 43 |       50
HSD|    avg|  43 - 44 |      116
HSD|    avg|  44 - 45 |       69
HSD|    avg|  45 - 46 |        8
HSD|    avg|  52 - 53 |        1
HSD|    avg|  61 - 62 |        1
---|--param|----range-|--samples
HSD|    max|  43 - 44 |       13
HSD|    max|  44 - 45 |       37
HSD|    max|  45 - 46 |        7
HSD|    max|  52 - 53 |        1
HSD|    max|  61 - 62 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        59|     14.441|      0.856
HSS|    avg|    599884|     31.679|      2.445
HSS|    max|        59|     44.322|      2.515
---|------------|------------|------------|--------|-------------------------
RTS|      13.638|      32.176|      61.836|       0|    00:01:00/00:01:00

Sun Mar 26 17:42:35 PST 2006
running: ./run -- -T 60 -h -s -l 0 -t2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTD|       4.646|       8.327|      14.540|       0|       4.646|      14.540
RTD|       4.279|       8.319|      15.606|       0|       4.279|      15.606
RTD|       2.625|       8.284|      20.332|       0|       2.625|      20.332
RTD|       4.312|       8.357|      45.580|       0|       2.625|      45.580
RTD|       2.860|       8.292|      43.334|       0|       2.625|      45.580
RTD|       4.470|       8.333|      18.911|       0|       2.625|      45.580
RTD|       2.492|       8.280|      47.965|       0|       2.492|      47.965
RTD|       3.829|       8.359|      42.896|       0|       2.492|      47.965
RTD|       2.848|       8.319|      20.268|       0|       2.492|      47.965
RTD|       4.361|       8.320|      45.457|       0|       2.492|      47.965
RTD|       3.371|       8.322|      45.607|       0|       2.492|      47.965
RTD|       4.425|       8.319|      53.676|       0|       2.492|      53.676
RTD|       3.929|       8.381|      41.137|       0|       2.492|      53.676
RTD|       3.202|       8.396|      45.033|       0|       2.492|      53.676
RTD|       2.918|       8.332|      43.912|       0|       2.492|      53.676
RTD|       4.526|       8.374|      25.694|       0|       2.492|      53.676
RTD|       4.624|       8.335|      44.898|       0|       2.492|      53.676
RTD|       3.851|       8.338|      46.398|       0|       2.492|      53.676
RTD|       4.447|       8.338|      44.737|       0|       2.492|      53.676
RTD|       4.196|       8.325|      43.953|       0|       2.492|      53.676
RTD|       2.885|       8.325|      17.749|       0|       2.492|      53.676
RTD|       4.406|       8.330|      46.514|       0|       2.492|      53.676
RTD|       3.025|       8.353|      43.683|       0|       2.492|      53.676
RTD|       4.489|       8.345|      16.546|       0|       2.492|      53.676
RTD|       4.267|       8.345|      44.152|       0|       2.492|      53.676
RTD|       4.316|       8.339|      40.612|       0|       2.492|      53.676
RTD|       4.267|       8.301|      21.547|       0|       2.492|      53.676
RTD|       3.197|       8.330|      39.146|       0|       2.492|      53.676
RTD|       3.412|       8.353|      43.953|       0|       2.492|      53.676
RTD|       4.421|       8.341|      40.976|       0|       2.492|      53.676
RTD|       3.274|       8.316|      20.310|       0|       2.492|      53.676
RTD|       4.335|       8.389|      45.258|       0|       2.492|      53.676
RTD|       2.889|       8.330|      44.215|       0|       2.492|      53.676
RTD|       4.384|       8.339|      41.463|       0|       2.492|      53.676
RTD|       4.330|       8.342|      45.528|       0|       2.492|      53.676
RTD|       4.192|       8.355|      43.226|       0|       2.492|      53.676
RTD|       2.906|       8.332|      45.209|       0|       2.492|      53.676
RTD|       3.775|       8.358|      44.527|       0|       2.492|      53.676
RTD|       4.106|       8.369|      40.380|       0|       2.492|      53.676
RTD|       4.421|       8.352|      20.801|       0|       2.492|      53.676
RTD|       4.481|       8.331|      37.732|       0|       2.492|      53.676
RTD|       4.552|       8.350|      34.636|       0|       2.492|      53.676
RTD|       2.826|       8.363|      38.212|       0|       2.492|      53.676
RTD|       4.444|       8.341|      15.743|       0|       2.492|      53.676
RTD|       4.470|       8.327|      46.566|       0|       2.492|      53.676
RTD|       3.043|       8.354|      44.197|       0|       2.492|      53.676
RTD|       3.459|       8.347|      19.531|       0|       2.492|      53.676
RTD|       3.080|       8.332|      45.352|       0|       2.492|      53.676
RTD|       3.020|       8.327|      38.032|       0|       2.492|      53.676
RTD|       4.316|       8.333|      39.847|       0|       2.492|      53.676
RTD|       4.324|       8.324|      16.511|       0|       2.492|      53.676
RTD|       4.492|       8.344|      16.311|       0|       2.492|      53.676
RTD|       3.769|       8.308|      46.416|       0|       2.492|      53.676
RTD|       4.346|       8.291|      38.816|       0|       2.492|      53.676
RTD|       4.477|       8.350|      45.434|       0|       2.492|      53.676
RTD|       4.339|       8.350|      40.972|       0|       2.492|      53.676
RTD|       4.399|       8.348|      46.330|       0|       2.492|      53.676
RTD|       3.419|       8.364|      16.639|       0|       2.492|      53.676
RTD|       4.462|       8.335|      49.330|       0|       2.492|      53.676
---|--param|----range-|--samples
HSD|    min|   2 -  3 |        9
HSD|    min|   3 -  4 |       16
HSD|    min|   4 -  5 |       34
---|--param|----range-|--samples
HSD|    avg|   2 -  3 |       18
HSD|    avg|   3 -  4 |      157
HSD|    avg|   4 -  5 |     1338
HSD|    avg|   5 -  6 |     9591
HSD|    avg|   6 -  7 |    11652
HSD|    avg|   7 -  8 |   157502
HSD|    avg|   8 -  9 |   357158
HSD|    avg|   9 - 10 |    39338
HSD|    avg|  10 - 11 |     6314
HSD|    avg|  11 - 12 |     5617
HSD|    avg|  12 - 13 |     7003
HSD|    avg|  13 - 14 |     3393
HSD|    avg|  14 - 15 |      537
HSD|    avg|  15 - 16 |       93
HSD|    avg|  16 - 17 |       41
HSD|    avg|  17 - 18 |       21
HSD|    avg|  18 - 19 |       15
HSD|    avg|  19 - 20 |        7
HSD|    avg|  20 - 21 |        7
HSD|    avg|  21 - 22 |        6
HSD|    avg|  22 - 23 |        2
HSD|    avg|  23 - 24 |        2
HSD|    avg|  25 - 26 |        1
HSD|    avg|  34 - 35 |        1
HSD|    avg|  37 - 38 |        1
HSD|    avg|  38 - 39 |        3
HSD|    avg|  39 - 40 |        2
HSD|    avg|  40 - 41 |        4
HSD|    avg|  41 - 42 |        2
HSD|    avg|  42 - 43 |        1
HSD|    avg|  43 - 44 |        7
HSD|    avg|  44 - 45 |        7
HSD|    avg|  45 - 46 |        9
HSD|    avg|  46 - 47 |        5
HSD|    avg|  47 - 48 |        1
HSD|    avg|  49 - 50 |        1
HSD|    avg|  53 - 54 |        1
---|--param|----range-|--samples
HSD|    max|  14 - 15 |        1
HSD|    max|  15 - 16 |        2
HSD|    max|  16 - 17 |        4
HSD|    max|  17 - 18 |        1
HSD|    max|  18 - 19 |        1
HSD|    max|  19 - 20 |        1
HSD|    max|  20 - 21 |        4
HSD|    max|  21 - 22 |        1
HSD|    max|  25 - 26 |        1
HSD|    max|  34 - 35 |        1
HSD|    max|  37 - 38 |        1
HSD|    max|  38 - 39 |        3
HSD|    max|  39 - 40 |        2
HSD|    max|  40 - 41 |        4
HSD|    max|  41 - 42 |        2
HSD|    max|  42 - 43 |        1
HSD|    max|  43 - 44 |        6
HSD|    max|  44 - 45 |        6
HSD|    max|  45 - 46 |        9
HSD|    max|  46 - 47 |        5
HSD|    max|  47 - 48 |        1
HSD|    max|  49 - 50 |        1
HSD|    max|  53 - 54 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        59|      3.424|      0.747
HSS|    avg|    599858|      7.841|      1.082
HSS|    max|        59|     36.288|     11.727
---|------------|------------|------------|--------|-------------------------
RTS|       2.492|       8.337|      53.676|       0|    00:01:00/00:01:00

Sun Mar 26 17:43:48 PST 2006
running: cat /proc/interrupts
           CPU0       
  0:     255956          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       4544          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      53556          XT-PIC  eth0
 11:     530937          XT-PIC  ndiswrapper
 14:         33          XT-PIC  ide0
NMI:          0 
ERR:          0

Sun Mar 26 17:43:48 PST 2006
running: cat /proc/loadavg
1.13 0.74 0.44 2/39 2593

Sun Mar 26 17:43:49 PST 2006
running: top -bn1c
top - 17:43:50 up 17 min,  1 user,  load average: 1.12, 0.75, 0.45
Tasks:  41 total,   2 running,  39 sleeping,   0 stopped,   0 zombie
Cpu(s):  9.2% us, 47.1% sy,  0.0% ni, 42.8% id,  0.2% wa,  0.0% hi,  0.8% si
Mem:    126264k total,    30176k used,    96088k free,        8k buffers
Swap:        0k total,        0k used,        0k free,    16320k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 2267 root      25   0  1720  496  400 R 65.4  0.4   3:25.65 dd if /dev/zero of 
 2597 root      16   0  2260  996  768 R 25.4  0.8   0:00.52 top -bn1c          
    1 root      16   0  1956  660  564 S  0.0  0.5   0:04.55 init [3]           

Script done on Sun Mar 26 17:43:50 2006

--------------040700080406070705080201--

