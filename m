Message-ID: <OF0AD08B39.2057B561-ONC12574B9.00291268-C12574B9.0035A8A3@domain.hid>
From: juergen.lanner@domain.hid
Date: Wed, 3 Sep 2008 11:45:36 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFE2ADFBA94F88f9e8a93df938690918c4EBBFE2ADFBA94F8"
Content-Disposition: inline
Subject: [Xenomai-help] question concerning xeno-test, latency, cyclic
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

--0__=4EBBFE2ADFBA94F88f9e8a93df938690918c4EBBFE2ADFBA94F8
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi!

I set up my box with xenomai 2.4.4 but I doubt that I was fully success=
ful
doing so.
At least I have problems understanding the outputs of the test suite
programs.

running xeno-test I get the following output (see below for full output=
)
...
something died a 8938 or
something died a 8938 or
...
What does it mean? What might be the problem?

Concerning latency:  I get funny values as well:
viper@domain.hid$ latency/run -p500
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 500 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

worst
RTD|      29.333|     248.914|  274651.310|     878|      29.333|
274651.310
RTD|      29.333|     166.780|  164809.727|    1426|      29.333|
274651.310
RTD|      29.333|     222.095|  164803.022|    2193|      29.333|
274651.310
RTD|      29.333|     139.123|  109882.649|    2631|      29.333|
274651.310
RTD|      29.333|     304.228|  274651.310|    3729|      29.333|
274651.310
RTD|    -470.172|  107252.707| -704900.898|  280993|    -470.172|
-704900.898
RTD|      29.333|     358.704|  274651.310|  282310|    -470.172|
-704900.898
RTD|      29.333|     386.361|  219726.747|  283737|    -470.172|
-704900.898
RTD|      29.333|     139.123|  109885.164|  284175|    -470.172|
-704900.898
RTD|      29.333|     139.123|  109882.649|  284613|    -470.172|
-704900.898
RTD|      29.333|     358.704|  274651.310|  285930|    -470.172|
-704900.898
RTD|      29.333|     194.438|  164803.022|  286588|    -470.172|
-704900.898
RTD|      29.333|     414.018|  274652.148|  288125|    -470.172|
-704900.898
RTD|      29.333|     331.885|  219726.747|  289332|    -470.172|
-704900.898

A max latency of some 100ms seems quite large to me, or am I getting
something wrong?
What do negative values mean here (latency best)?

Running cyclic freezes my box completely:
It gives me some output before.
viper@domain.hid$ cyclic/run -p 80 -t =
5 -n
*
*
* Type ^C to stop this application.
*
*
5.16 5.10 4.93 6/193 9476

T: 0 ( 9472) P:80 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:
0 Max:-1000000
T: 1 ( 9473) P:79 I:    1500 C:       0 Min: 1000000 Act:       0 Avg:
0 Max:-1000000
T: 2 ( 9474) P:78 I:    2000 C:       0 Min: 1000000 Act:       0 Avg:
0 Max:-1000000
T: 3 ( 9475) P:77 I:    2500 C:       0 Min: 1000000 Act:       0 Avg:
0 Max:-1000000
T: 4 ( 9476) P:76 I:    3000 C:       0 Min: 1000000 Act:       0 Avg:
0 Max:-1000000


I assume there Is something weird with my setup.
Can you give me some hint where to start searching, please?

Thanks a lot.

Juergen











here is the full output of xeno-test:

xeno-test: started
withBusybox is 0
xeno-test: running tests

Wed Sep  3 11:01:52 CEST 2008
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
        --version=3D"2.4.4"
        --cc=3D"gcc"
        --arch=3D"x86"
        --prefix=3D"/usr/xenomai"
        --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTR=
ANT
-D__XENO__"
        --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
        --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include=
/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --posix-ldflags=3D"-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
        --library-dir=3D"/usr/xenomai/lib"

Wed Sep  3 11:01:52 CEST 2008
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux viper5 2.6.25.11-xe #1 SMP Fri Aug 29 07:47:16 CEST 2008 i686
GNU/Linux

Gnu C                  4.2.3
Gnu make               3.81
util-linux             ng 2.13.1)
mount                  ng 2.13.1)
module-init-tools      3.3-pre11
e2fsprogs              1.40.8
PPP                    2.4.4
Linux C Library        > libc.2.7
Dynamic linker (ldd)   2.7
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               6.10
Modules Loaded         e1000e af_packet rfcomm l2cap bluetooth i915 drm=

ppdev ipv6 iptable_filter ip_tables x_tables dm_crypt crypto_blkcipher
dm_mod lp parport_pc parport serio_raw psmouse iTCO_wdt iTCO_vendor_sup=
port
shpchp pci_hotplug intel_agp agpgart evdev ext3 jbd mbcache sg sd_mod
pata_jmicron floppy ahci ata_piix ata_generic libata ehci_hcd uhci_hcd =
skge
scsi_mod usbcore fuse

Wed Sep  3 11:01:54 CEST 2008
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          4300  @ 1.80GHz
stepping        : 2
cpu MHz         : 1795.536
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx1=
6
xtpr lahf_lm
bogomips        : 3593.49
clflush size    : 64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          4300  @ 1.80GHz
stepping        : 2
cpu MHz         : 1795.536
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx1=
6
xtpr lahf_lm
bogomips        : 3591.27
clflush size    : 64


Wed Sep  3 11:01:54 CEST 2008
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
16c62e2579214d8da356a8085a11bac1  /proc/cpuinfo
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
CONFIG_IPIPE_COMPAT=3Dy
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
CONFIG_PM_DEBUG=3Dy
# CONFIG_PM_VERBOSE is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_SLEEP_SMP=3Dy
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_STD_PARTITION=3D""
# CONFIG_ACPI is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Wed Sep  3 11:01:55 CEST 2008
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A.L..
   4:  A.L..
   5:  A.L..
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A.L..
  11:  A....
  12:  A....
  13:  A.L..
  14:  A....
  15:  A....
  16:  A....
  17:  A....
  18:  A....
  19:  A....
  20:  A....
  21:  A....
  22:  A....
  23:  A....
  24:  A....
  25:  A....
  26:  A....
  27:  A....
  28:  A....
  29:  A....
  30:  A....
  31:  A....
  32:  A....
  33:  A....
  34:  A....
  35:  A....
  36:  A....
  37:  A....
  38:  A....
  39:  A....
  40:  A....
  41:  A....
  42:  A....
  43:  A....
  44:  A....
  45:  A....
  46:  A....
  47:  A....
  48:  A....
  49:  A....
  50:  A....
  51:  A....
  52:  A....
  53:  A....
  54:  A....
  55:  A....
  56:  A....
  57:  A....
  58:  A....
  59:  A....
  60:  A....
  61:  A....
  62:  A....
  63:  A....
  64:  A....
  65:  A....
  66:  A....
  67:  A....
  68:  A....
  69:  A....
  70:  A....
  71:  A....
  72:  A....
  73:  A....
  74:  A....
  75:  A....
  76:  A....
  77:  A....
  78:  A....
  79:  A....
  80:  A....
  81:  A....
  82:  A....
  83:  A....
  84:  A....
  85:  A....
  86:  A....
  87:  A....
  88:  A....
  89:  A....
  90:  A....
  91:  A....
  92:  A....
  93:  A....
  94:  A....
  95:  A....
  96:  A....
  97:  A....
  98:  A....
  99:  A....
 100:  A....
 101:  A....
 102:  A....
 103:  A....
 104:  A....
 105:  A....
 106:  A....
 107:  A....
 108:  A....
 109:  A....
 110:  A....
 111:  A....
 112:  A....
 113:  A....
 114:  A....
 115:  A....
 116:  A....
 117:  A....
 118:  A....
 119:  A....
 120:  A....
 121:  A....
 122:  A....
 123:  A....
 124:  A....
 125:  A....
 126:  A....
 127:  A....
 128:  A....
 129:  A....
 130:  A....
 131:  A....
 132:  A....
 133:  A....
 134:  A....
 135:  A....
 136:  A....
 137:  A....
 138:  A....
 139:  A....
 140:  A....
 141:  A....
 142:  A....
 143:  A....
 144:  A....
 145:  A....
 146:  A....
 147:  A....
 148:  A....
 149:  A....
 150:  A....
 151:  A....
 152:  A....
 153:  A....
 154:  A....
 155:  A....
 156:  A....
 157:  A....
 158:  A....
 159:  A....
 160:  A....
 161:  A....
 162:  A....
 163:  A....
 164:  A....
 165:  A....
 166:  A....
 167:  A....
 168:  A....
 169:  A....
 170:  A....
 171:  A....
 172:  A....
 173:  A....
 174:  A....
 175:  A....
 176:  A....
 177:  A....
 178:  A....
 179:  A....
 180:  A....
 181:  A....
 182:  A....
 183:  A....
 184:  A....
 185:  A....
 186:  A....
 187:  A....
 188:  A....
 189:  A....
 190:  A....
 191:  A....
 192:  A....
 193:  A....
 194:  A....
 195:  A....
 196:  A....
 197:  A....
 198:  A....
 199:  A....
 200:  A....
 201:  A....
 202:  A....
 203:  A....
 204:  A....
 205:  A....
 206:  A....
 207:  A....
 208:  A....
 209:  A....
 210:  A....
 211:  A....
 212:  A....
 213:  A....
 214:  A....
 215:  A....
 216:  A....
 217:  A....
 218:  A....
 219:  A....
 220:  A....
 221:  A....
 222:  A....
 223:  A....
 224:  A....
 230:  A....
 231:  A....
 232:  A....
 233:  A....
 234:  GS...
 236:  A....
 237:  A....
 238:  A....
 239:  A....
 240:  A....
 256:  G...V
 257:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Wed Sep  3 11:01:55 CEST 2008
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
 230:  W....
 233:  W..X.
 234:  GS...
 258:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Wed Sep  3 11:01:55 CEST 2008
running: cat /proc/ipipe/version
2.0-09

Wed Sep  3 11:01:55 CEST 2008
running: generate_loads 1
dd workload started, pids 8938 stored in /var/lock/xeno-test.8798.pids
 8938 pts/4    00:00:00 xeno-test
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
something died a 8938 or
^C

=

--0__=4EBBFE2ADFBA94F88f9e8a93df938690918c4EBBFE2ADFBA94F8
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hi!</font><br>
<br>
<font face=3D"Arial">I set up my box with xenomai 2.4.4 but I doubt tha=
t I was fully successful doing so.</font><br>
<font face=3D"Arial">At least I have problems understanding the outputs=
 of the test suite programs.</font><br>
<br>
<font face=3D"Arial">running xeno-test I get the following output (see =
below for full output)</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">What does it mean? What might be the problem?</fon=
t><br>
<br>
<font face=3D"Arial">Concerning latency:  I get funny values as well:</=
font><br>
<font face=3D"Arial">viper@domain.hid$=
 latency/run -p500</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">=3D=3D Sampling period: 500 us</font><br>
<font face=3D"Arial">=3D=3D Test mode: periodic user-mode task</font><b=
r>
<font face=3D"Arial">=3D=3D All results in microseconds</font><br>
<font face=3D"Arial">warming up...</font><br>
<font face=3D"Arial">RTT|  00:00:01  (periodic user-mode task, 500 us p=
eriod, priority 99)</font><br>
<font face=3D"Arial">RTH|-----lat min|-----lat avg|-----lat max|-overru=
n|----lat best|---lat worst</font><br>
<font face=3D"Arial">RTD|      29.333|     248.914|  274651.310|     87=
8|      29.333|  274651.310</font><br>
<font face=3D"Arial">RTD|      29.333|     166.780|  164809.727|    142=
6|      29.333|  274651.310</font><br>
<font face=3D"Arial">RTD|      29.333|     222.095|  164803.022|    219=
3|      29.333|  274651.310</font><br>
<font face=3D"Arial">RTD|      29.333|     139.123|  109882.649|    263=
1|      29.333|  274651.310</font><br>
<font face=3D"Arial">RTD|      29.333|     304.228|  274651.310|    372=
9|      29.333|  274651.310</font><br>
<font face=3D"Arial">RTD|    -470.172|  107252.707| -704900.898|  28099=
3|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     358.704|  274651.310|  28231=
0|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     386.361|  219726.747|  28373=
7|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     139.123|  109885.164|  28417=
5|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     139.123|  109882.649|  28461=
3|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     358.704|  274651.310|  28593=
0|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     194.438|  164803.022|  28658=
8|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     414.018|  274652.148|  28812=
5|    -470.172| -704900.898</font><br>
<font face=3D"Arial">RTD|      29.333|     331.885|  219726.747|  28933=
2|    -470.172| -704900.898</font><br>
<br>
<font face=3D"Arial">A max latency of some 100ms seems quite large to m=
e, or am I getting something wrong?</font><br>
<font face=3D"Arial">What do negative values mean here (latency best)? =
</font><br>
<br>
<font face=3D"Arial">Running cyclic freezes my box completely:</font><b=
r>
<font face=3D"Arial">It gives me some output before.</font><br>
<font face=3D"Arial">viper@domain.hid$=
 cyclic/run -p 80 -t 5 -n</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">5.16 5.10 4.93 6/193 9476</font><br>
<br>
<font face=3D"Arial">T: 0 ( 9472) P:80 I:    1000 C:       0 Min: 10000=
00 Act:       0 Avg:       0 Max:-1000000</font><br>
<font face=3D"Arial">T: 1 ( 9473) P:79 I:    1500 C:       0 Min: 10000=
00 Act:       0 Avg:       0 Max:-1000000</font><br>
<font face=3D"Arial">T: 2 ( 9474) P:78 I:    2000 C:       0 Min: 10000=
00 Act:       0 Avg:       0 Max:-1000000</font><br>
<font face=3D"Arial">T: 3 ( 9475) P:77 I:    2500 C:       0 Min: 10000=
00 Act:       0 Avg:       0 Max:-1000000</font><br>
<font face=3D"Arial">T: 4 ( 9476) P:76 I:    3000 C:       0 Min: 10000=
00 Act:       0 Avg:       0 Max:-1000000</font><br>
<br>
<br>
<font face=3D"Arial">I assume there Is something weird with my setup.</=
font><br>
<font face=3D"Arial">Can you give me some hint where to start searching=
, please?</font><br>
<br>
<font face=3D"Arial">Thanks a lot.</font><br>
<br>
<font face=3D"Arial">Juergen</font><br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<font face=3D"Arial">here is the full output of xeno-test:</font><br>
<br>
<font face=3D"Arial">xeno-test: started</font><br>
<font face=3D"Arial">withBusybox is 0</font><br>
<font face=3D"Arial">xeno-test: running tests</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:52 CEST 2008</font><br>
<font face=3D"Arial">running: /usr/xenomai/bin/xeno-config --verbose</f=
ont><br>
<font face=3D"Arial">xeno-config --verbose</font><br>
<font face=3D"Arial">        --version=3D&quot;2.4.4&quot;</font><br>
<font face=3D"Arial">        --cc=3D&quot;gcc&quot;</font><br>
<font face=3D"Arial">        --arch=3D&quot;x86&quot;</font><br>
<font face=3D"Arial">        --prefix=3D&quot;/usr/xenomai&quot;</font>=
<br>
<font face=3D"Arial">        --xeno-cflags=3D&quot;-I/usr/xenomai/inclu=
de -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;</font><br>
<font face=3D"Arial">        --xeno-ldflags=3D&quot;-L/usr/xenomai/lib =
-lpthread &quot;</font><br>
<font face=3D"Arial">        --posix-cflags=3D&quot;-I/usr/xenomai/incl=
ude -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__&=
quot;</font><br>
<font face=3D"Arial">        --posix-ldflags=3D&quot;-Wl,@/usr/xenomai/=
lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lrt &quot=
;</font><br>
<font face=3D"Arial">        --library-dir=3D&quot;/usr/xenomai/lib&quo=
t;</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:52 CEST 2008</font><br>
<font face=3D"Arial">running: /usr/xenomai/bin/xeno-info</font><br>
<font face=3D"Arial">If some fields are empty or look unusual you may h=
ave an old version.</font><br>
<font face=3D"Arial">Compare to the current minimal requirements in Doc=
umentation/Changes.</font><br>
<br>
<font face=3D"Arial">Linux viper5 2.6.25.11-xe #1 SMP Fri Aug 29 07:47:=
16 CEST 2008 i686 GNU/Linux</font><br>
<br>
<font face=3D"Arial">Gnu C                  4.2.3</font><br>
<font face=3D"Arial">Gnu make               3.81</font><br>
<font face=3D"Arial">util-linux             ng 2.13.1)</font><br>
<font face=3D"Arial">mount                  ng 2.13.1)</font><br>
<font face=3D"Arial">module-init-tools      3.3-pre11</font><br>
<font face=3D"Arial">e2fsprogs              1.40.8</font><br>
<font face=3D"Arial">PPP                    2.4.4</font><br>
<font face=3D"Arial">Linux C Library        &gt; libc.2.7</font><br>
<font face=3D"Arial">Dynamic linker (ldd)   2.7</font><br>
<font face=3D"Arial">Procps                 3.2.7</font><br>
<font face=3D"Arial">Net-tools              1.60</font><br>
<font face=3D"Arial">Console-tools          0.2.3</font><br>
<font face=3D"Arial">Sh-utils               6.10</font><br>
<font face=3D"Arial">Modules Loaded         e1000e af_packet rfcomm l2c=
ap bluetooth i915 drm ppdev ipv6 iptable_filter ip_tables x_tables dm_c=
rypt crypto_blkcipher dm_mod lp parport_pc parport serio_raw psmouse iT=
CO_wdt iTCO_vendor_support shpchp pci_hotplug intel_agp agpgart evdev e=
xt3 jbd mbcache sg sd_mod pata_jmicron floppy ahci ata_piix ata_generic=
 libata ehci_hcd uhci_hcd skge scsi_mod usbcore fuse</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:54 CEST 2008</font><br>
<font face=3D"Arial">running: cat /proc/cpuinfo</font><br>
<font face=3D"Arial">processor       : 0</font><br>
<font face=3D"Arial">vendor_id       : GenuineIntel</font><br>
<font face=3D"Arial">cpu family      : 6</font><br>
<font face=3D"Arial">model           : 15</font><br>
<font face=3D"Arial">model name      : Intel(R) Core(TM)2 CPU          =
4300  @ 1.80GHz</font><br>
<font face=3D"Arial">stepping        : 2</font><br>
<font face=3D"Arial">cpu MHz         : 1795.536</font><br>
<font face=3D"Arial">cache size      : 2048 KB</font><br>
<font face=3D"Arial">physical id     : 0</font><br>
<font face=3D"Arial">siblings        : 2</font><br>
<font face=3D"Arial">core id         : 0</font><br>
<font face=3D"Arial">cpu cores       : 2</font><br>
<font face=3D"Arial">fdiv_bug        : no</font><br>
<font face=3D"Arial">hlt_bug         : no</font><br>
<font face=3D"Arial">f00f_bug        : no</font><br>
<font face=3D"Arial">coma_bug        : no</font><br>
<font face=3D"Arial">fpu             : yes</font><br>
<font face=3D"Arial">fpu_exception   : yes</font><br>
<font face=3D"Arial">cpuid level     : 10</font><br>
<font face=3D"Arial">wp              : yes</font><br>
<font face=3D"Arial">flags           : fpu vme de pse tsc msr pae mce c=
x8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse s=
se2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor d=
s_cpl est tm2 ssse3 cx16 xtpr lahf_lm</font><br>
<font face=3D"Arial">bogomips        : 3593.49</font><br>
<font face=3D"Arial">clflush size    : 64</font><br>
<br>
<font face=3D"Arial">processor       : 1</font><br>
<font face=3D"Arial">vendor_id       : GenuineIntel</font><br>
<font face=3D"Arial">cpu family      : 6</font><br>
<font face=3D"Arial">model           : 15</font><br>
<font face=3D"Arial">model name      : Intel(R) Core(TM)2 CPU          =
4300  @ 1.80GHz</font><br>
<font face=3D"Arial">stepping        : 2</font><br>
<font face=3D"Arial">cpu MHz         : 1795.536</font><br>
<font face=3D"Arial">cache size      : 2048 KB</font><br>
<font face=3D"Arial">physical id     : 0</font><br>
<font face=3D"Arial">siblings        : 2</font><br>
<font face=3D"Arial">core id         : 1</font><br>
<font face=3D"Arial">cpu cores       : 2</font><br>
<font face=3D"Arial">fdiv_bug        : no</font><br>
<font face=3D"Arial">hlt_bug         : no</font><br>
<font face=3D"Arial">f00f_bug        : no</font><br>
<font face=3D"Arial">coma_bug        : no</font><br>
<font face=3D"Arial">fpu             : yes</font><br>
<font face=3D"Arial">fpu_exception   : yes</font><br>
<font face=3D"Arial">cpuid level     : 10</font><br>
<font face=3D"Arial">wp              : yes</font><br>
<font face=3D"Arial">flags           : fpu vme de pse tsc msr pae mce c=
x8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse s=
se2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts pni monitor d=
s_cpl est tm2 ssse3 cx16 xtpr lahf_lm</font><br>
<font face=3D"Arial">bogomips        : 3591.27</font><br>
<font face=3D"Arial">clflush size    : 64</font><br>
<br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:54 CEST 2008</font><br>
<font face=3D"Arial">running: md5sum /proc/cpuinfo # cpuinfo fingerprin=
t</font><br>
<font face=3D"Arial">16c62e2579214d8da356a8085a11bac1  /proc/cpuinfo</f=
ont><br>
<font face=3D"Arial">CONFIG_PREEMPT_NOTIFIERS=3Dy</font><br>
<font face=3D"Arial"># CONFIG_PREEMPT_NONE is not set</font><br>
<font face=3D"Arial">CONFIG_PREEMPT_VOLUNTARY=3Dy</font><br>
<font face=3D"Arial"># CONFIG_PREEMPT is not set</font><br>
<font face=3D"Arial">CONFIG_IPIPE=3Dy</font><br>
<font face=3D"Arial">CONFIG_IPIPE_DOMAINS=3D4</font><br>
<font face=3D"Arial">CONFIG_IPIPE_COMPAT=3Dy</font><br>
<font face=3D"Arial">CONFIG_PM=3Dy</font><br>
<font face=3D"Arial">CONFIG_PM_LEGACY=3Dy</font><br>
<font face=3D"Arial">CONFIG_PM_DEBUG=3Dy</font><br>
<font face=3D"Arial"># CONFIG_PM_VERBOSE is not set</font><br>
<font face=3D"Arial"># CONFIG_PM_TRACE_RTC is not set</font><br>
<font face=3D"Arial">CONFIG_PM_SLEEP_SMP=3Dy</font><br>
<font face=3D"Arial">CONFIG_PM_SLEEP=3Dy</font><br>
<font face=3D"Arial">CONFIG_PM_STD_PARTITION=3D&quot;&quot;</font><br>
<font face=3D"Arial"># CONFIG_ACPI is not set</font><br>
<font face=3D"Arial"># CONFIG_CPU_FREQ is not set</font><br>
<font face=3D"Arial"># CONFIG_IPIPE_DEBUG is not set</font><br>
<font face=3D"Arial"># CONFIG_DEBUG_SPINLOCK is not set</font><br>
<font face=3D"Arial"># CONFIG_DEBUG_SPINLOCK_SLEEP is not set</font><br=
>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:55 CEST 2008</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/Linux</font><br>
<font face=3D"Arial">       +----- Handling ([A]ccepted, [G]rabbed, [W]=
ired, [D]iscarded)</font><br>
<font face=3D"Arial">       |+---- Sticky</font><br>
<font face=3D"Arial">       ||+--- Locked</font><br>
<font face=3D"Arial">       |||+-- Exclusive</font><br>
<font face=3D"Arial">       ||||+- Virtual</font><br>
<font face=3D"Arial">[IRQ]  |||||</font><br>
<font face=3D"Arial">   0:  A....</font><br>
<font face=3D"Arial">   1:  A....</font><br>
<font face=3D"Arial">   2:  A....</font><br>
<font face=3D"Arial">   3:  A.L..</font><br>
<font face=3D"Arial">   4:  A.L..</font><br>
<font face=3D"Arial">   5:  A.L..</font><br>
<font face=3D"Arial">   6:  A....</font><br>
<font face=3D"Arial">   7:  A....</font><br>
<font face=3D"Arial">   8:  A....</font><br>
<font face=3D"Arial">   9:  A....</font><br>
<font face=3D"Arial">  10:  A.L..</font><br>
<font face=3D"Arial">  11:  A....</font><br>
<font face=3D"Arial">  12:  A....</font><br>
<font face=3D"Arial">  13:  A.L..</font><br>
<font face=3D"Arial">  14:  A....</font><br>
<font face=3D"Arial">  15:  A....</font><br>
<font face=3D"Arial">  16:  A....</font><br>
<font face=3D"Arial">  17:  A....</font><br>
<font face=3D"Arial">  18:  A....</font><br>
<font face=3D"Arial">  19:  A....</font><br>
<font face=3D"Arial">  20:  A....</font><br>
<font face=3D"Arial">  21:  A....</font><br>
<font face=3D"Arial">  22:  A....</font><br>
<font face=3D"Arial">  23:  A....</font><br>
<font face=3D"Arial">  24:  A....</font><br>
<font face=3D"Arial">  25:  A....</font><br>
<font face=3D"Arial">  26:  A....</font><br>
<font face=3D"Arial">  27:  A....</font><br>
<font face=3D"Arial">  28:  A....</font><br>
<font face=3D"Arial">  29:  A....</font><br>
<font face=3D"Arial">  30:  A....</font><br>
<font face=3D"Arial">  31:  A....</font><br>
<font face=3D"Arial">  32:  A....</font><br>
<font face=3D"Arial">  33:  A....</font><br>
<font face=3D"Arial">  34:  A....</font><br>
<font face=3D"Arial">  35:  A....</font><br>
<font face=3D"Arial">  36:  A....</font><br>
<font face=3D"Arial">  37:  A....</font><br>
<font face=3D"Arial">  38:  A....</font><br>
<font face=3D"Arial">  39:  A....</font><br>
<font face=3D"Arial">  40:  A....</font><br>
<font face=3D"Arial">  41:  A....</font><br>
<font face=3D"Arial">  42:  A....</font><br>
<font face=3D"Arial">  43:  A....</font><br>
<font face=3D"Arial">  44:  A....</font><br>
<font face=3D"Arial">  45:  A....</font><br>
<font face=3D"Arial">  46:  A....</font><br>
<font face=3D"Arial">  47:  A....</font><br>
<font face=3D"Arial">  48:  A....</font><br>
<font face=3D"Arial">  49:  A....</font><br>
<font face=3D"Arial">  50:  A....</font><br>
<font face=3D"Arial">  51:  A....</font><br>
<font face=3D"Arial">  52:  A....</font><br>
<font face=3D"Arial">  53:  A....</font><br>
<font face=3D"Arial">  54:  A....</font><br>
<font face=3D"Arial">  55:  A....</font><br>
<font face=3D"Arial">  56:  A....</font><br>
<font face=3D"Arial">  57:  A....</font><br>
<font face=3D"Arial">  58:  A....</font><br>
<font face=3D"Arial">  59:  A....</font><br>
<font face=3D"Arial">  60:  A....</font><br>
<font face=3D"Arial">  61:  A....</font><br>
<font face=3D"Arial">  62:  A....</font><br>
<font face=3D"Arial">  63:  A....</font><br>
<font face=3D"Arial">  64:  A....</font><br>
<font face=3D"Arial">  65:  A....</font><br>
<font face=3D"Arial">  66:  A....</font><br>
<font face=3D"Arial">  67:  A....</font><br>
<font face=3D"Arial">  68:  A....</font><br>
<font face=3D"Arial">  69:  A....</font><br>
<font face=3D"Arial">  70:  A....</font><br>
<font face=3D"Arial">  71:  A....</font><br>
<font face=3D"Arial">  72:  A....</font><br>
<font face=3D"Arial">  73:  A....</font><br>
<font face=3D"Arial">  74:  A....</font><br>
<font face=3D"Arial">  75:  A....</font><br>
<font face=3D"Arial">  76:  A....</font><br>
<font face=3D"Arial">  77:  A....</font><br>
<font face=3D"Arial">  78:  A....</font><br>
<font face=3D"Arial">  79:  A....</font><br>
<font face=3D"Arial">  80:  A....</font><br>
<font face=3D"Arial">  81:  A....</font><br>
<font face=3D"Arial">  82:  A....</font><br>
<font face=3D"Arial">  83:  A....</font><br>
<font face=3D"Arial">  84:  A....</font><br>
<font face=3D"Arial">  85:  A....</font><br>
<font face=3D"Arial">  86:  A....</font><br>
<font face=3D"Arial">  87:  A....</font><br>
<font face=3D"Arial">  88:  A....</font><br>
<font face=3D"Arial">  89:  A....</font><br>
<font face=3D"Arial">  90:  A....</font><br>
<font face=3D"Arial">  91:  A....</font><br>
<font face=3D"Arial">  92:  A....</font><br>
<font face=3D"Arial">  93:  A....</font><br>
<font face=3D"Arial">  94:  A....</font><br>
<font face=3D"Arial">  95:  A....</font><br>
<font face=3D"Arial">  96:  A....</font><br>
<font face=3D"Arial">  97:  A....</font><br>
<font face=3D"Arial">  98:  A....</font><br>
<font face=3D"Arial">  99:  A....</font><br>
<font face=3D"Arial"> 100:  A....</font><br>
<font face=3D"Arial"> 101:  A....</font><br>
<font face=3D"Arial"> 102:  A....</font><br>
<font face=3D"Arial"> 103:  A....</font><br>
<font face=3D"Arial"> 104:  A....</font><br>
<font face=3D"Arial"> 105:  A....</font><br>
<font face=3D"Arial"> 106:  A....</font><br>
<font face=3D"Arial"> 107:  A....</font><br>
<font face=3D"Arial"> 108:  A....</font><br>
<font face=3D"Arial"> 109:  A....</font><br>
<font face=3D"Arial"> 110:  A....</font><br>
<font face=3D"Arial"> 111:  A....</font><br>
<font face=3D"Arial"> 112:  A....</font><br>
<font face=3D"Arial"> 113:  A....</font><br>
<font face=3D"Arial"> 114:  A....</font><br>
<font face=3D"Arial"> 115:  A....</font><br>
<font face=3D"Arial"> 116:  A....</font><br>
<font face=3D"Arial"> 117:  A....</font><br>
<font face=3D"Arial"> 118:  A....</font><br>
<font face=3D"Arial"> 119:  A....</font><br>
<font face=3D"Arial"> 120:  A....</font><br>
<font face=3D"Arial"> 121:  A....</font><br>
<font face=3D"Arial"> 122:  A....</font><br>
<font face=3D"Arial"> 123:  A....</font><br>
<font face=3D"Arial"> 124:  A....</font><br>
<font face=3D"Arial"> 125:  A....</font><br>
<font face=3D"Arial"> 126:  A....</font><br>
<font face=3D"Arial"> 127:  A....</font><br>
<font face=3D"Arial"> 128:  A....</font><br>
<font face=3D"Arial"> 129:  A....</font><br>
<font face=3D"Arial"> 130:  A....</font><br>
<font face=3D"Arial"> 131:  A....</font><br>
<font face=3D"Arial"> 132:  A....</font><br>
<font face=3D"Arial"> 133:  A....</font><br>
<font face=3D"Arial"> 134:  A....</font><br>
<font face=3D"Arial"> 135:  A....</font><br>
<font face=3D"Arial"> 136:  A....</font><br>
<font face=3D"Arial"> 137:  A....</font><br>
<font face=3D"Arial"> 138:  A....</font><br>
<font face=3D"Arial"> 139:  A....</font><br>
<font face=3D"Arial"> 140:  A....</font><br>
<font face=3D"Arial"> 141:  A....</font><br>
<font face=3D"Arial"> 142:  A....</font><br>
<font face=3D"Arial"> 143:  A....</font><br>
<font face=3D"Arial"> 144:  A....</font><br>
<font face=3D"Arial"> 145:  A....</font><br>
<font face=3D"Arial"> 146:  A....</font><br>
<font face=3D"Arial"> 147:  A....</font><br>
<font face=3D"Arial"> 148:  A....</font><br>
<font face=3D"Arial"> 149:  A....</font><br>
<font face=3D"Arial"> 150:  A....</font><br>
<font face=3D"Arial"> 151:  A....</font><br>
<font face=3D"Arial"> 152:  A....</font><br>
<font face=3D"Arial"> 153:  A....</font><br>
<font face=3D"Arial"> 154:  A....</font><br>
<font face=3D"Arial"> 155:  A....</font><br>
<font face=3D"Arial"> 156:  A....</font><br>
<font face=3D"Arial"> 157:  A....</font><br>
<font face=3D"Arial"> 158:  A....</font><br>
<font face=3D"Arial"> 159:  A....</font><br>
<font face=3D"Arial"> 160:  A....</font><br>
<font face=3D"Arial"> 161:  A....</font><br>
<font face=3D"Arial"> 162:  A....</font><br>
<font face=3D"Arial"> 163:  A....</font><br>
<font face=3D"Arial"> 164:  A....</font><br>
<font face=3D"Arial"> 165:  A....</font><br>
<font face=3D"Arial"> 166:  A....</font><br>
<font face=3D"Arial"> 167:  A....</font><br>
<font face=3D"Arial"> 168:  A....</font><br>
<font face=3D"Arial"> 169:  A....</font><br>
<font face=3D"Arial"> 170:  A....</font><br>
<font face=3D"Arial"> 171:  A....</font><br>
<font face=3D"Arial"> 172:  A....</font><br>
<font face=3D"Arial"> 173:  A....</font><br>
<font face=3D"Arial"> 174:  A....</font><br>
<font face=3D"Arial"> 175:  A....</font><br>
<font face=3D"Arial"> 176:  A....</font><br>
<font face=3D"Arial"> 177:  A....</font><br>
<font face=3D"Arial"> 178:  A....</font><br>
<font face=3D"Arial"> 179:  A....</font><br>
<font face=3D"Arial"> 180:  A....</font><br>
<font face=3D"Arial"> 181:  A....</font><br>
<font face=3D"Arial"> 182:  A....</font><br>
<font face=3D"Arial"> 183:  A....</font><br>
<font face=3D"Arial"> 184:  A....</font><br>
<font face=3D"Arial"> 185:  A....</font><br>
<font face=3D"Arial"> 186:  A....</font><br>
<font face=3D"Arial"> 187:  A....</font><br>
<font face=3D"Arial"> 188:  A....</font><br>
<font face=3D"Arial"> 189:  A....</font><br>
<font face=3D"Arial"> 190:  A....</font><br>
<font face=3D"Arial"> 191:  A....</font><br>
<font face=3D"Arial"> 192:  A....</font><br>
<font face=3D"Arial"> 193:  A....</font><br>
<font face=3D"Arial"> 194:  A....</font><br>
<font face=3D"Arial"> 195:  A....</font><br>
<font face=3D"Arial"> 196:  A....</font><br>
<font face=3D"Arial"> 197:  A....</font><br>
<font face=3D"Arial"> 198:  A....</font><br>
<font face=3D"Arial"> 199:  A....</font><br>
<font face=3D"Arial"> 200:  A....</font><br>
<font face=3D"Arial"> 201:  A....</font><br>
<font face=3D"Arial"> 202:  A....</font><br>
<font face=3D"Arial"> 203:  A....</font><br>
<font face=3D"Arial"> 204:  A....</font><br>
<font face=3D"Arial"> 205:  A....</font><br>
<font face=3D"Arial"> 206:  A....</font><br>
<font face=3D"Arial"> 207:  A....</font><br>
<font face=3D"Arial"> 208:  A....</font><br>
<font face=3D"Arial"> 209:  A....</font><br>
<font face=3D"Arial"> 210:  A....</font><br>
<font face=3D"Arial"> 211:  A....</font><br>
<font face=3D"Arial"> 212:  A....</font><br>
<font face=3D"Arial"> 213:  A....</font><br>
<font face=3D"Arial"> 214:  A....</font><br>
<font face=3D"Arial"> 215:  A....</font><br>
<font face=3D"Arial"> 216:  A....</font><br>
<font face=3D"Arial"> 217:  A....</font><br>
<font face=3D"Arial"> 218:  A....</font><br>
<font face=3D"Arial"> 219:  A....</font><br>
<font face=3D"Arial"> 220:  A....</font><br>
<font face=3D"Arial"> 221:  A....</font><br>
<font face=3D"Arial"> 222:  A....</font><br>
<font face=3D"Arial"> 223:  A....</font><br>
<font face=3D"Arial"> 224:  A....</font><br>
<font face=3D"Arial"> 230:  A....</font><br>
<font face=3D"Arial"> 231:  A....</font><br>
<font face=3D"Arial"> 232:  A....</font><br>
<font face=3D"Arial"> 233:  A....</font><br>
<font face=3D"Arial"> 234:  GS...</font><br>
<font face=3D"Arial"> 236:  A....</font><br>
<font face=3D"Arial"> 237:  A....</font><br>
<font face=3D"Arial"> 238:  A....</font><br>
<font face=3D"Arial"> 239:  A....</font><br>
<font face=3D"Arial"> 240:  A....</font><br>
<font face=3D"Arial"> 256:  G...V</font><br>
<font face=3D"Arial"> 257:  G...V</font><br>
<font face=3D"Arial">[Domain info]</font><br>
<font face=3D"Arial">id=3D0x00000000</font><br>
<font face=3D"Arial">priority=3D100</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:55 CEST 2008</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/Xenomai</font><br>
<font face=3D"Arial">       +----- Handling ([A]ccepted, [G]rabbed, [W]=
ired, [D]iscarded)</font><br>
<font face=3D"Arial">       |+---- Sticky</font><br>
<font face=3D"Arial">       ||+--- Locked</font><br>
<font face=3D"Arial">       |||+-- Exclusive</font><br>
<font face=3D"Arial">       ||||+- Virtual</font><br>
<font face=3D"Arial">[IRQ]  |||||</font><br>
<font face=3D"Arial"> 230:  W....</font><br>
<font face=3D"Arial"> 233:  W..X.</font><br>
<font face=3D"Arial"> 234:  GS...</font><br>
<font face=3D"Arial"> 258:  W...V</font><br>
<font face=3D"Arial">[Domain info]</font><br>
<font face=3D"Arial">id=3D0x58454e4f</font><br>
<font face=3D"Arial">priority=3Dtopmost</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:55 CEST 2008</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/version</font><br>
<font face=3D"Arial">2.0-09</font><br>
<br>
<font face=3D"Arial">Wed Sep  3 11:01:55 CEST 2008</font><br>
<font face=3D"Arial">running: generate_loads 1</font><br>
<font face=3D"Arial">dd workload started, pids 8938 stored in /var/lock=
/xeno-test.8798.pids</font><br>
<font face=3D"Arial"> 8938 pts/4    00:00:00 xeno-test</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">something died a 8938 or</font><br>
<font face=3D"Arial">^C</font><br>
<br>
<br>
</body></html>=

--0__=4EBBFE2ADFBA94F88f9e8a93df938690918c4EBBFE2ADFBA94F8--


