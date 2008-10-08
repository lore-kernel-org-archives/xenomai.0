Message-ID: <OF18FABCEE.31B1EBFE-ONC12574DC.001E5390-C12574DC.001F8407@domain.hid>
From: juergen.lanner@domain.hid
Date: Wed, 8 Oct 2008 07:44:38 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFE4FDF8DD5008f9e8a93df938690918c4EBBFE4FDF8DD500"
Content-Disposition: inline
Subject: [Xenomai-help]  question concerning xeno-test, latency, cyclic
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

--0__=4EBBFE4FDF8DD5008f9e8a93df938690918c4EBBFE4FDF8DD500
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable




We now found the reason for the really huge values and the complete han=
gup:

I am using a core 2 processor but didn't set the processor type within =
the
kernel configuration correctly.

Now I get good results again.

Regards

juergen






Posted by juergen . lanner on September 03, 2008 - 11:45:


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

Concerning latency: I get funny values as well:
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
RTT| 00:00:01 (periodic user-mode task, 500 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

worst
RTD| 29.333| 248.914| 274651.310| 878| 29.333| 274651.310
RTD| 29.333| 166.780| 164809.727| 1426| 29.333| 274651.310
RTD| 29.333| 222.095| 164803.022| 2193| 29.333| 274651.310
RTD| 29.333| 139.123| 109882.649| 2631| 29.333| 274651.310
RTD| 29.333| 304.228| 274651.310| 3729| 29.333| 274651.310
RTD| -470.172| 107252.707| -704900.898| 280993| -470.172| -704900.898
RTD| 29.333| 358.704| 274651.310| 282310| -470.172| -704900.898
RTD| 29.333| 386.361| 219726.747| 283737| -470.172| -704900.898
RTD| 29.333| 139.123| 109885.164| 284175| -470.172| -704900.898
RTD| 29.333| 139.123| 109882.649| 284613| -470.172| -704900.898
RTD| 29.333| 358.704| 274651.310| 285930| -470.172| -704900.898
RTD| 29.333| 194.438| 164803.022| 286588| -470.172| -704900.898
RTD| 29.333| 414.018| 274652.148| 288125| -470.172| -704900.898
RTD| 29.333| 331.885| 219726.747| 289332| -470.172| -704900.898

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

T: 0 ( 9472) P:80 I: 1000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000
T: 1 ( 9473) P:79 I: 1500 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000
T: 2 ( 9474) P:78 I: 2000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000
T: 3 ( 9475) P:77 I: 2500 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000
T: 4 ( 9476) P:76 I: 3000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000


I assume there Is something weird with my setup.
Can you give me some hint where to start searching, please?

Thanks a lot.

Juergen











here is the full output of xeno-test:

xeno-test: started
withBusybox is 0
xeno-test: running tests

Wed Sep 3 11:01:52 CEST 2008
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
--version=3D"2.4.4"
--cc=3D"gcc"
--arch=3D"x86"
--prefix=3D"/usr/xenomai"
--xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
--xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
--posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
--posix-ldflags=3D"-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/=
lib
-lpthread_rt -lpthread -lrt "
--library-dir=3D"/usr/xenomai/lib"

Wed Sep 3 11:01:52 CEST 2008
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux viper5 2.6.25.11-xe #1 SMP Fri Aug 29 07:47:16 CEST 2008 i686
GNU/Linux

Gnu C 4.2.3
Gnu make 3.81
util-linux ng 2.13.1)
mount ng 2.13.1)
module-init-tools 3.3-pre11
e2fsprogs 1.40.8
PPP 2.4.4
Linux C Library > libc.2.7
Dynamic linker (ldd) 2.7
Procps 3.2.7
Net-tools 1.60
Console-tools 0.2.3
Sh-utils 6.10
Modules Loaded e1000e af_packet rfcomm l2cap bluetooth i915 drm ppdev i=
pv6
iptable_filter ip_tables x_tables dm_crypt crypto_blkcipher dm_mod lp
parport_pc parport serio_raw psmouse iTCO_wdt iTCO_vendor_support shpch=
p
pci_hotplug intel_agp agpgart evdev ext3 jbd mbcache sg sd_mod pata_jmi=
cron
floppy ahci ata_piix ata_generic libata ehci_hcd uhci_hcd skge scsi_mod=

usbcore fuse

Wed Sep 3 11:01:54 CEST 2008
running: cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 15
model name : Intel(R) Core(TM)2 CPU 4300 @ 1.80GHz
stepping : 2
cpu MHz : 1795.536
cache size : 2048 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 2
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_ts=
c
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr lahf_l=
m
bogomips : 3593.49
clflush size : 64

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 15
model name : Intel(R) Core(TM)2 CPU 4300 @ 1.80GHz
stepping : 2
cpu MHz : 1795.536
cache size : 2048 KB
physical id : 0
siblings : 2
core id : 1
cpu cores : 2
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_ts=
c
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr lahf_l=
m
bogomips : 3591.27
clflush size : 64


Wed Sep 3 11:01:54 CEST 2008
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
16c62e2579214d8da356a8085a11bac1 /proc/cpuinfo
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

Wed Sep 3 11:01:55 CEST 2008
running: cat /proc/ipipe/Linux
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
|+---- Sticky
||+--- Locked
|||+-- Exclusive
||||+- Virtual
[IRQ] |||||
0: A....
1: A....
2: A....
3: A.L..
4: A.L..
5: A.L..
6: A....
7: A....
8: A....
9: A....
10: A.L..
11: A....
12: A....
13: A.L..
14: A....
15: A....
16: A....
17: A....
18: A....
19: A....
20: A....
21: A....
22: A....
23: A....
24: A....
25: A....
26: A....
27: A....
28: A....
29: A....
30: A....
31: A....
32: A....
33: A....
34: A....
35: A....
36: A....
37: A....
38: A....
39: A....
40: A....
41: A....
42: A....
43: A....
44: A....
45: A....
46: A....
47: A....
48: A....
49: A....
50: A....
51: A....
52: A....
53: A....
54: A....
55: A....
56: A....
57: A....
58: A....
59: A....
60: A....
61: A....
62: A....
63: A....
64: A....
65: A....
66: A....
67: A....
68: A....
69: A....
70: A....
71: A....
72: A....
73: A....
74: A....
75: A....
76: A....
77: A....
78: A....
79: A....
80: A....
81: A....
82: A....
83: A....
84: A....
85: A....
86: A....
87: A....
88: A....
89: A....
90: A....
91: A....
92: A....
93: A....
94: A....
95: A....
96: A....
97: A....
98: A....
99: A....
100: A....
101: A....
102: A....
103: A....
104: A....
105: A....
106: A....
107: A....
108: A....
109: A....
110: A....
111: A....
112: A....
113: A....
114: A....
115: A....
116: A....
117: A....
118: A....
119: A....
120: A....
121: A....
122: A....
123: A....
124: A....
125: A....
126: A....
127: A....
128: A....
129: A....
130: A....
131: A....
132: A....
133: A....
134: A....
135: A....
136: A....
137: A....
138: A....
139: A....
140: A....
141: A....
142: A....
143: A....
144: A....
145: A....
146: A....
147: A....
148: A....
149: A....
150: A....
151: A....
152: A....
153: A....
154: A....
155: A....
156: A....
157: A....
158: A....
159: A....
160: A....
161: A....
162: A....
163: A....
164: A....
165: A....
166: A....
167: A....
168: A....
169: A....
170: A....
171: A....
172: A....
173: A....
174: A....
175: A....
176: A....
177: A....
178: A....
179: A....
180: A....
181: A....
182: A....
183: A....
184: A....
185: A....
186: A....
187: A....
188: A....
189: A....
190: A....
191: A....
192: A....
193: A....
194: A....
195: A....
196: A....
197: A....
198: A....
199: A....
200: A....
201: A....
202: A....
203: A....
204: A....
205: A....
206: A....
207: A....
208: A....
209: A....
210: A....
211: A....
212: A....
213: A....
214: A....
215: A....
216: A....
217: A....
218: A....
219: A....
220: A....
221: A....
222: A....
223: A....
224: A....
230: A....
231: A....
232: A....
233: A....
234: GS...
236: A....
237: A....
238: A....
239: A....
240: A....
256: G...V
257: G...V
[Domain info]
id=3D0x00000000
priority=3D100

Wed Sep 3 11:01:55 CEST 2008
running: cat /proc/ipipe/Xenomai
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
|+---- Sticky
||+--- Locked
|||+-- Exclusive
||||+- Virtual
[IRQ] |||||
230: W....
233: W..X.
234: GS...
258: W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Wed Sep 3 11:01:55 CEST 2008
running: cat /proc/ipipe/version
2.0-09

Wed Sep 3 11:01:55 CEST 2008
running: generate_loads 1
dd workload started, pids 8938 stored in /var/lock/xeno-test.8798.pids
8938 pts/4 00:00:00 xeno-test
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

--0__=4EBBFE4FDF8DD5008f9e8a93df938690918c4EBBFE4FDF8DD500
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial"><br>
We now found the reason for the really huge values and the complete han=
gup:</font><br>
<br>
<font face=3D"Arial">I am using a core 2 processor but didn't set the p=
rocessor type within the kernel configuration correctly.</font><br>
<br>
<font face=3D"Arial">Now I get good results again.</font><br>
<br>
<font face=3D"Arial">Regards</font><br>
<br>
<font face=3D"Arial">juergen</font><br>
<br>
<br>
<br>
<br>
<br>
<br>
<font size=3D"4">Posted by </font><b><font size=3D"4">juergen . lanner<=
/font></b><font size=3D"4"> on September 03, 2008 - 11:45:</font>
<p><font size=3D"4" face=3D"Arial">Hi!</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
I set up my box with xenomai 2.4.4 but I doubt that I was fully success=
ful doing so.<br>
At least I have problems understanding the outputs of the test suite pr=
ograms.</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
running xeno-test I get the following output (see below for full output=
)<br>
...<br>
something died a 8938 or<br>
something died a 8938 or<br>
...<br>
What does it mean? What might be the problem?</font><font size=3D"4"><b=
r>
</font><font size=3D"4" face=3D"Arial"><br>
Concerning latency: I get funny values as well:<br>
viper@domain.hid$ latency/run -p500<br=
>
*<br>
*<br>
* Type ^C to stop this application.<br>
*<br>
*<br>
=3D=3D Sampling period: 500 us<br>
=3D=3D Test mode: periodic user-mode task<br>
=3D=3D All results in microseconds<br>
warming up...<br>
RTT| 00:00:01 (periodic user-mode task, 500 us period, priority 99)<br>=

RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst<br>
RTD| 29.333| 248.914| 274651.310| 878| 29.333| 274651.310<br>
RTD| 29.333| 166.780| 164809.727| 1426| 29.333| 274651.310<br>
RTD| 29.333| 222.095| 164803.022| 2193| 29.333| 274651.310<br>
RTD| 29.333| 139.123| 109882.649| 2631| 29.333| 274651.310<br>
RTD| 29.333| 304.228| 274651.310| 3729| 29.333| 274651.310<br>
RTD| -470.172| 107252.707| -704900.898| 280993| -470.172| -704900.898<b=
r>
RTD| 29.333| 358.704| 274651.310| 282310| -470.172| -704900.898<br>
RTD| 29.333| 386.361| 219726.747| 283737| -470.172| -704900.898<br>
RTD| 29.333| 139.123| 109885.164| 284175| -470.172| -704900.898<br>
RTD| 29.333| 139.123| 109882.649| 284613| -470.172| -704900.898<br>
RTD| 29.333| 358.704| 274651.310| 285930| -470.172| -704900.898<br>
RTD| 29.333| 194.438| 164803.022| 286588| -470.172| -704900.898<br>
RTD| 29.333| 414.018| 274652.148| 288125| -470.172| -704900.898<br>
RTD| 29.333| 331.885| 219726.747| 289332| -470.172| -704900.898</font><=
font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
A max latency of some 100ms seems quite large to me, or am I getting so=
mething wrong?<br>
What do negative values mean here (latency best)? </font><font size=3D"=
4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Running cyclic freezes my box completely:<br>
It gives me some output before.<br>
viper@domain.hid$ cyclic/run -p 80 -t =
5 -n<br>
*<br>
*<br>
* Type ^C to stop this application.<br>
*<br>
*<br>
5.16 5.10 4.93 6/193 9476</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
T: 0 ( 9472) P:80 I: 1000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000<=
br>
T: 1 ( 9473) P:79 I: 1500 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000<=
br>
T: 2 ( 9474) P:78 I: 2000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000<=
br>
T: 3 ( 9475) P:77 I: 2500 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000<=
br>
T: 4 ( 9476) P:76 I: 3000 C: 0 Min: 1000000 Act: 0 Avg: 0 Max:-1000000<=
/font><font size=3D"4"><br>
<br>
</font><font size=3D"4" face=3D"Arial"><br>
I assume there Is something weird with my setup.<br>
Can you give me some hint where to start searching, please?</font><font=
 size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Thanks a lot.</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Juergen</font><font size=3D"4"><br>
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
</font><font size=3D"4" face=3D"Arial"><br>
here is the full output of xeno-test:</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
xeno-test: started<br>
withBusybox is 0<br>
xeno-test: running tests</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:52 CEST 2008<br>
running: /usr/xenomai/bin/xeno-config --verbose<br>
xeno-config --verbose<br>
--version=3D&quot;2.4.4&quot;<br>
--cc=3D&quot;gcc&quot;<br>
--arch=3D&quot;x86&quot;<br>
--prefix=3D&quot;/usr/xenomai&quot;<br>
--xeno-cflags=3D&quot;-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT=
 -D__XENO__&quot;<br>
--xeno-ldflags=3D&quot;-L/usr/xenomai/lib -lpthread &quot;<br>
--posix-cflags=3D&quot;-I/usr/xenomai/include -I/usr/xenomai/include/po=
six -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;<br>
--posix-ldflags=3D&quot;-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xen=
omai/lib -lpthread_rt -lpthread -lrt &quot;<br>
--library-dir=3D&quot;/usr/xenomai/lib&quot;</font><font size=3D"4"><br=
>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:52 CEST 2008<br>
running: /usr/xenomai/bin/xeno-info<br>
If some fields are empty or look unusual you may have an old version.<b=
r>
Compare to the current minimal requirements in Documentation/Changes.</=
font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Linux viper5 2.6.25.11-xe #1 SMP Fri Aug 29 07:47:16 CEST 2008 i686 GNU=
/Linux</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Gnu C 4.2.3<br>
Gnu make 3.81<br>
util-linux ng 2.13.1)<br>
mount ng 2.13.1)<br>
module-init-tools 3.3-pre11<br>
e2fsprogs 1.40.8<br>
PPP 2.4.4<br>
Linux C Library &gt; libc.2.7<br>
Dynamic linker (ldd) 2.7<br>
Procps 3.2.7<br>
Net-tools 1.60<br>
Console-tools 0.2.3<br>
Sh-utils 6.10<br>
Modules Loaded e1000e af_packet rfcomm l2cap bluetooth i915 drm ppdev i=
pv6 iptable_filter ip_tables x_tables dm_crypt crypto_blkcipher dm_mod =
lp parport_pc parport serio_raw psmouse iTCO_wdt iTCO_vendor_support sh=
pchp pci_hotplug intel_agp agpgart evdev ext3 jbd mbcache sg sd_mod pat=
a_jmicron floppy ahci ata_piix ata_generic libata ehci_hcd uhci_hcd skg=
e scsi_mod usbcore fuse</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:54 CEST 2008<br>
running: cat /proc/cpuinfo<br>
processor : 0<br>
vendor_id : GenuineIntel<br>
cpu family : 6<br>
model : 15<br>
model name : Intel(R) Core(TM)2 CPU 4300 @ 1.80GHz<br>
stepping : 2<br>
cpu MHz : 1795.536<br>
cache size : 2048 KB<br>
physical id : 0<br>
siblings : 2<br>
core id : 0<br>
cpu cores : 2<br>
fdiv_bug : no<br>
hlt_bug : no<br>
f00f_bug : no<br>
coma_bug : no<br>
fpu : yes<br>
fpu_exception : yes<br>
cpuid level : 10<br>
wp : yes<br>
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant=
_tsc arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr l=
ahf_lm<br>
bogomips : 3593.49<br>
clflush size : 64</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
processor : 1<br>
vendor_id : GenuineIntel<br>
cpu family : 6<br>
model : 15<br>
model name : Intel(R) Core(TM)2 CPU 4300 @ 1.80GHz<br>
stepping : 2<br>
cpu MHz : 1795.536<br>
cache size : 2048 KB<br>
physical id : 0<br>
siblings : 2<br>
core id : 1<br>
cpu cores : 2<br>
fdiv_bug : no<br>
hlt_bug : no<br>
f00f_bug : no<br>
coma_bug : no<br>
fpu : yes<br>
fpu_exception : yes<br>
cpuid level : 10<br>
wp : yes<br>
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant=
_tsc arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr l=
ahf_lm<br>
bogomips : 3591.27<br>
clflush size : 64</font><font size=3D"4"><br>
<br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:54 CEST 2008<br>
running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>
16c62e2579214d8da356a8085a11bac1 /proc/cpuinfo<br>
CONFIG_PREEMPT_NOTIFIERS=3Dy<br>
# CONFIG_PREEMPT_NONE is not set<br>
CONFIG_PREEMPT_VOLUNTARY=3Dy<br>
# CONFIG_PREEMPT is not set<br>
CONFIG_IPIPE=3Dy<br>
CONFIG_IPIPE_DOMAINS=3D4<br>
CONFIG_IPIPE_COMPAT=3Dy<br>
CONFIG_PM=3Dy<br>
CONFIG_PM_LEGACY=3Dy<br>
CONFIG_PM_DEBUG=3Dy<br>
# CONFIG_PM_VERBOSE is not set<br>
# CONFIG_PM_TRACE_RTC is not set<br>
CONFIG_PM_SLEEP_SMP=3Dy<br>
CONFIG_PM_SLEEP=3Dy<br>
CONFIG_PM_STD_PARTITION=3D&quot;&quot;<br>
# CONFIG_ACPI is not set<br>
# CONFIG_CPU_FREQ is not set<br>
# CONFIG_IPIPE_DEBUG is not set<br>
# CONFIG_DEBUG_SPINLOCK is not set<br>
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:55 CEST 2008<br>
running: cat /proc/ipipe/Linux<br>
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)<br>
|+---- Sticky<br>
||+--- Locked<br>
|||+-- Exclusive<br>
||||+- Virtual<br>
[IRQ] |||||<br>
0: A....<br>
1: A....<br>
2: A....<br>
3: A.L..<br>
4: A.L..<br>
5: A.L..<br>
6: A....<br>
7: A....<br>
8: A....<br>
9: A....<br>
10: A.L..<br>
11: A....<br>
12: A....<br>
13: A.L..<br>
14: A....<br>
15: A....<br>
16: A....<br>
17: A....<br>
18: A....<br>
19: A....<br>
20: A....<br>
21: A....<br>
22: A....<br>
23: A....<br>
24: A....<br>
25: A....<br>
26: A....<br>
27: A....<br>
28: A....<br>
29: A....<br>
30: A....<br>
31: A....<br>
32: A....<br>
33: A....<br>
34: A....<br>
35: A....<br>
36: A....<br>
37: A....<br>
38: A....<br>
39: A....<br>
40: A....<br>
41: A....<br>
42: A....<br>
43: A....<br>
44: A....<br>
45: A....<br>
46: A....<br>
47: A....<br>
48: A....<br>
49: A....<br>
50: A....<br>
51: A....<br>
52: A....<br>
53: A....<br>
54: A....<br>
55: A....<br>
56: A....<br>
57: A....<br>
58: A....<br>
59: A....<br>
60: A....<br>
61: A....<br>
62: A....<br>
63: A....<br>
64: A....<br>
65: A....<br>
66: A....<br>
67: A....<br>
68: A....<br>
69: A....<br>
70: A....<br>
71: A....<br>
72: A....<br>
73: A....<br>
74: A....<br>
75: A....<br>
76: A....<br>
77: A....<br>
78: A....<br>
79: A....<br>
80: A....<br>
81: A....<br>
82: A....<br>
83: A....<br>
84: A....<br>
85: A....<br>
86: A....<br>
87: A....<br>
88: A....<br>
89: A....<br>
90: A....<br>
91: A....<br>
92: A....<br>
93: A....<br>
94: A....<br>
95: A....<br>
96: A....<br>
97: A....<br>
98: A....<br>
99: A....<br>
100: A....<br>
101: A....<br>
102: A....<br>
103: A....<br>
104: A....<br>
105: A....<br>
106: A....<br>
107: A....<br>
108: A....<br>
109: A....<br>
110: A....<br>
111: A....<br>
112: A....<br>
113: A....<br>
114: A....<br>
115: A....<br>
116: A....<br>
117: A....<br>
118: A....<br>
119: A....<br>
120: A....<br>
121: A....<br>
122: A....<br>
123: A....<br>
124: A....<br>
125: A....<br>
126: A....<br>
127: A....<br>
128: A....<br>
129: A....<br>
130: A....<br>
131: A....<br>
132: A....<br>
133: A....<br>
134: A....<br>
135: A....<br>
136: A....<br>
137: A....<br>
138: A....<br>
139: A....<br>
140: A....<br>
141: A....<br>
142: A....<br>
143: A....<br>
144: A....<br>
145: A....<br>
146: A....<br>
147: A....<br>
148: A....<br>
149: A....<br>
150: A....<br>
151: A....<br>
152: A....<br>
153: A....<br>
154: A....<br>
155: A....<br>
156: A....<br>
157: A....<br>
158: A....<br>
159: A....<br>
160: A....<br>
161: A....<br>
162: A....<br>
163: A....<br>
164: A....<br>
165: A....<br>
166: A....<br>
167: A....<br>
168: A....<br>
169: A....<br>
170: A....<br>
171: A....<br>
172: A....<br>
173: A....<br>
174: A....<br>
175: A....<br>
176: A....<br>
177: A....<br>
178: A....<br>
179: A....<br>
180: A....<br>
181: A....<br>
182: A....<br>
183: A....<br>
184: A....<br>
185: A....<br>
186: A....<br>
187: A....<br>
188: A....<br>
189: A....<br>
190: A....<br>
191: A....<br>
192: A....<br>
193: A....<br>
194: A....<br>
195: A....<br>
196: A....<br>
197: A....<br>
198: A....<br>
199: A....<br>
200: A....<br>
201: A....<br>
202: A....<br>
203: A....<br>
204: A....<br>
205: A....<br>
206: A....<br>
207: A....<br>
208: A....<br>
209: A....<br>
210: A....<br>
211: A....<br>
212: A....<br>
213: A....<br>
214: A....<br>
215: A....<br>
216: A....<br>
217: A....<br>
218: A....<br>
219: A....<br>
220: A....<br>
221: A....<br>
222: A....<br>
223: A....<br>
224: A....<br>
230: A....<br>
231: A....<br>
232: A....<br>
233: A....<br>
234: GS...<br>
236: A....<br>
237: A....<br>
238: A....<br>
239: A....<br>
240: A....<br>
256: G...V<br>
257: G...V<br>
[Domain info]<br>
id=3D0x00000000<br>
priority=3D100</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:55 CEST 2008<br>
running: cat /proc/ipipe/Xenomai<br>
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)<br>
|+---- Sticky<br>
||+--- Locked<br>
|||+-- Exclusive<br>
||||+- Virtual<br>
[IRQ] |||||<br>
230: W....<br>
233: W..X.<br>
234: GS...<br>
258: W...V<br>
[Domain info]<br>
id=3D0x58454e4f<br>
priority=3Dtopmost</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:55 CEST 2008<br>
running: cat /proc/ipipe/version<br>
2.0-09</font><font size=3D"4"><br>
</font><font size=3D"4" face=3D"Arial"><br>
Wed Sep 3 11:01:55 CEST 2008<br>
running: generate_loads 1<br>
dd workload started, pids 8938 stored in /var/lock/xeno-test.8798.pids<=
br>
8938 pts/4 00:00:00 xeno-test<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
something died a 8938 or<br>
^C</font><font size=3D"4"><br>
<br>
</font></body></html>=

--0__=4EBBFE4FDF8DD5008f9e8a93df938690918c4EBBFE4FDF8DD500--


