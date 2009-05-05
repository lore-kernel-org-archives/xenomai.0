Message-ID: <OF9CF4E5FB.BA5862BC-ONC12575AD.00275D59-C12575AD.00285FDC@datacon.at>
From: henning.richter@domain.hid
Date: Tue, 5 May 2009 09:21:00 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFF3EDFB4DBC98f9e8a93df938690918c4EBBFF3EDFB4DBC9"
Content-Disposition: inline
Subject: [Xenomai-help] help with xenomai configuration
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

--0__=4EBBFF3EDFB4DBC98f9e8a93df938690918c4EBBFF3EDFB4DBC9
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi,

I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai 2.4.6.1 and the late=
st
rtnet version.
I set up the EthercatMasterLibrary and send some Frames (size of ~1200
byte) cylical to my Beckhoff devices.
Measuring the time (via rt_read_timer-function of timer.h) handing the
frames over to the NIC last between 5 and 10 us. (its the low_level_sen=
d)
Measuring the time at the application layer is takes ~250 - 350 us. So =
I am
loosing quite a lot time in between.

Maybe there is sth. wrong with my xenomai configuration.
I run the 'xeno-test' (results below) but the test stop at generation l=
oad.

Henning

here are the results of xeno-test:

xeno-test: started
withBusybox is 0
xeno-test: running tests

Di 5. Mai 07:12:40 CEST 2009
running: ./xeno-config --verbose
xeno-config --verbose
--version=3D"2.4.6.1"
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

Di 5. Mai 07:12:40 CEST 2009
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux rd-ethercat 2.6.27.7-xe #1 SMP Wed Apr 29 12:00:19 CEST 2009 i686=

GNU/Linux

Gnu C 4.3.2-1ubuntu12)
Gnu make 3.81
util-linux ng 2.14)
mount ng 2.14 (with libvolume_id and selinux support)
module-init-tools 3.3-pre11
e2fsprogs 1.41.3
Linux C Library 2.8.90
Dynamic linker (ldd) 2.8.90
Procps 3.2.7
Net-tools 1.60
Kbd 1.14.1
Sh-utils 6.10
Modules Loaded e100 rt_eepro100 rtpacket rtnet af_packet i915 drm bridg=
e
stp bnep rfcomm sco l2cap bluetooth ppdev ipv6 iptable_filter ip_tables=

x_tables parport_pc lp parport sr_mod cdrom isp1760 com20020_pci com200=
20
arcnet evdev serio_raw iTCO_wdt psmouse iTCO_vendor_support intel_agp
shpchp pci_hotplug agpgart ext3 jbd mbcache sd_mod crc_t10dif sg
usb_storage libusual ata_piix ata_generic libata mii uhci_hcd ehci_hcd
scsi_mod usbcore fuse

Di 5. Mai 07:12:41 CEST 2009
running: cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 9
model name : Mobile Genuine Intel(R) processor 1100MHz
stepping : 5
cpu MHz : 1099.881
cache size : 1024 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 2
wp : yes
flags : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat
clflush dts acpi mmx fxsr sse sse2 tm pbe up bts est tm2
bogomips : 2199.76
clflush size : 64
power management:


Di 5. Mai 07:12:41 CEST 2009
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
3f1cac044dfe9caf955d09d7612b905f /proc/cpuinfo
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
CONFIG_IPIPE_COMPAT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
# CONFIG_PM is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Di 5. Mai 07:12:41 CEST 2009
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
5: A....
6: A....
7: A....
8: A....
9: A....
10: A.L..
11: A.L..
12: A....
13: A....
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
235: A....
236: A....
237: A....
238: A....
239: A....
240: A....
256: G...V
257: G...V
259: G...V
[Domain info]
id=3D0x00000000
priority=3D100

Di 5. Mai 07:12:41 CEST 2009
running: cat /proc/ipipe/Xenomai
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
|+---- Sticky
||+--- Locked
|||+-- Exclusive
||||+- Virtual
[IRQ] |||||
9: W..X.
230: W....
233: W..X.
234: GS...
258: W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Di 5. Mai 07:12:41 CEST 2009
running: cat /proc/ipipe/version
2.1-02

Di 5. Mai 07:12:41 CEST 2009
running: generate_loads 1
dd workload started, pids 5100 stored in /var/lock/xeno-test.4960.pids
5100 pts/2 00:00:00 dd
something died a 5100 or=

--0__=4EBBFF3EDFB4DBC98f9e8a93df938690918c4EBBFF3EDFB4DBC9
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hi,</font><br>
<br>
<font face=3D"Arial">I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai=
 2.4.6.1 and the latest rtnet version.</font><br>
<font face=3D"Arial">I set up the EthercatMasterLibrary and send some F=
rames (size of ~1200 byte) cylical to my Beckhoff devices.</font><br>
<font face=3D"Arial">Measuring the time (via rt_read_timer-function of =
timer.h) handing the frames over to the NIC last between 5 and 10 us. (=
its the low_level_send)</font><br>
<font face=3D"Arial">Measuring the time at the application layer is tak=
es ~250 - 350 us. So I am loosing quite a lot time in between.</font><b=
r>
<br>
<font face=3D"Arial">Maybe there is sth. wrong with my xenomai configur=
ation.</font><br>
<font face=3D"Arial">I run the 'xeno-test' (results below) but the test=
 stop at generation load.</font><br>
<br>
<font face=3D"Arial">Henning</font><br>
<br>
<font face=3D"Arial">here are the results of xeno-test:</font><br>
<br>
<font face=3D"Times New Roman">xeno-test: started <br>
withBusybox is 0 <br>
xeno-test: running tests </font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:40 CEST 2009<br>
running: ./xeno-config --verbose<br>
xeno-config --verbose <br>
--version=3D&quot;2.4.6.1&quot; <br>
--cc=3D&quot;gcc&quot; <br>
--arch=3D&quot;x86&quot; <br>
--prefix=3D&quot;/usr/xenomai&quot; <br>
--xeno-cflags=3D&quot;-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT=
 -D__XENO__&quot;<br>
--xeno-ldflags=3D&quot;-L/usr/xenomai/lib -lpthread &quot; <br>
--posix-cflags=3D&quot;-I/usr/xenomai/include -I/usr/xenomai/include/po=
six -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;<br>
--posix-ldflags=3D&quot;-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xen=
omai/lib -lpthread_rt -lpthread -lrt &quot; <br>
--library-dir=3D&quot;/usr/xenomai/lib&quot; </font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:40 CEST 2009<br>
running: ./xeno-info <br>
If some fields are empty or look unusual you may have an old version.<b=
r>
Compare to the current minimal requirements in Documentation/Changes.</=
font><br>
<font face=3D"Times New Roman"><br>
Linux rd-ethercat 2.6.27.7-xe #1 SMP Wed Apr 29 12:00:19 CEST 2009 i686=
 GNU/Linux</font><br>
<font face=3D"Times New Roman"><br>
Gnu C 4.3.2-1ubuntu12) <br>
Gnu make 3.81 <br>
util-linux ng 2.14) <br>
mount ng 2.14 (with libvolume_id and selinux support) <br>
module-init-tools 3.3-pre11 <br>
e2fsprogs 1.41.3 <br>
Linux C Library 2.8.90 <br>
Dynamic linker (ldd) 2.8.90 <br>
Procps 3.2.7 <br>
Net-tools 1.60 <br>
Kbd 1.14.1 <br>
Sh-utils 6.10 <br>
Modules Loaded e100 rt_eepro100 rtpacket rtnet af_packet i915 drm bridg=
e stp bnep rfcomm sco l2cap bluetooth ppdev ipv6 iptable_filter ip_tabl=
es x_tables parport_pc lp parport sr_mod cdrom isp1760 com20020_pci com=
20020 arcnet evdev serio_raw iTCO_wdt psmouse iTCO_vendor_support intel=
_agp shpchp pci_hotplug agpgart ext3 jbd mbcache sd_mod crc_t10dif sg u=
sb_storage libusual ata_piix ata_generic libata mii uhci_hcd ehci_hcd s=
csi_mod usbcore fuse </font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: cat /proc/cpuinfo <br>
processor : 0 <br>
vendor_id : GenuineIntel<br>
cpu family : 6 <br>
model : 9 <br>
model name : Mobile Genuine Intel(R) processor 1100MHz<br>
stepping : 5 <br>
cpu MHz : 1099.881 <br>
cache size : 1024 KB <br>
fdiv_bug : no <br>
hlt_bug : no <br>
f00f_bug : no <br>
coma_bug : no <br>
fpu : yes <br>
fpu_exception : yes <br>
cpuid level : 2 <br>
wp : yes <br>
flags : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat c=
lflush dts acpi mmx fxsr sse sse2 tm pbe up bts est tm2<br>
bogomips : 2199.76 <br>
clflush size : 64 <br>
power management: </font><br>
<br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>
3f1cac044dfe9caf955d09d7612b905f /proc/cpuinfo <br>
CONFIG_PREEMPT_NOTIFIERS=3Dy <br>
# CONFIG_PREEMPT_NONE is not set <br>
CONFIG_PREEMPT_VOLUNTARY=3Dy <br>
# CONFIG_PREEMPT is not set <br>
CONFIG_IPIPE=3Dy <br>
CONFIG_IPIPE_DOMAINS=3D4 <br>
CONFIG_IPIPE_COMPAT=3Dy <br>
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy <br>
# CONFIG_PM is not set <br>
# CONFIG_CPU_FREQ is not set <br>
# CONFIG_IPIPE_DEBUG is not set <br>
# CONFIG_DEBUG_SPINLOCK is not set <br>
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set </font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: cat /proc/ipipe/Linux<br>
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)<br>
|+---- Sticky <br>
||+--- Locked <br>
|||+-- Exclusive <br>
||||+- Virtual <br>
[IRQ] ||||| <br>
0: A.... <br>
1: A.... <br>
2: A.... <br>
3: A.L.. <br>
4: A.L.. <br>
5: A.... <br>
6: A.... <br>
7: A.... <br>
8: A.... <br>
9: A.... <br>
10: A.L.. <br>
11: A.L.. <br>
12: A.... <br>
13: A.... <br>
14: A.... <br>
15: A.... <br>
16: A.... <br>
17: A.... <br>
18: A.... <br>
19: A.... <br>
20: A.... <br>
21: A.... <br>
22: A.... <br>
23: A.... <br>
24: A.... <br>
25: A.... <br>
26: A.... <br>
27: A.... <br>
28: A.... <br>
29: A.... <br>
30: A.... <br>
31: A.... <br>
32: A.... <br>
33: A.... <br>
34: A.... <br>
35: A.... <br>
36: A.... <br>
37: A.... <br>
38: A.... <br>
39: A.... <br>
40: A.... <br>
41: A.... <br>
42: A.... <br>
43: A.... <br>
44: A.... <br>
45: A.... <br>
46: A.... <br>
47: A.... <br>
48: A.... <br>
49: A.... <br>
50: A.... <br>
51: A.... <br>
52: A.... <br>
53: A.... <br>
54: A.... <br>
55: A.... <br>
56: A.... <br>
57: A.... <br>
58: A.... <br>
59: A.... <br>
60: A.... <br>
61: A.... <br>
62: A.... <br>
63: A.... <br>
64: A.... <br>
65: A.... <br>
66: A.... <br>
67: A.... <br>
68: A.... <br>
69: A.... <br>
70: A.... <br>
71: A.... <br>
72: A.... <br>
73: A.... <br>
74: A.... <br>
75: A.... <br>
76: A.... <br>
77: A.... <br>
78: A.... <br>
79: A.... <br>
80: A.... <br>
81: A.... <br>
82: A.... <br>
83: A.... <br>
84: A.... <br>
85: A.... <br>
86: A.... <br>
87: A.... <br>
88: A.... <br>
89: A.... <br>
90: A.... <br>
91: A.... <br>
92: A.... <br>
93: A.... <br>
94: A.... <br>
95: A.... <br>
96: A.... <br>
97: A.... <br>
98: A.... <br>
99: A.... <br>
100: A.... <br>
101: A.... <br>
102: A.... <br>
103: A.... <br>
104: A.... <br>
105: A.... <br>
106: A.... <br>
107: A.... <br>
108: A.... <br>
109: A.... <br>
110: A.... <br>
111: A.... <br>
112: A.... <br>
113: A.... <br>
114: A.... <br>
115: A.... <br>
116: A.... <br>
117: A.... <br>
118: A.... <br>
119: A.... <br>
120: A.... <br>
121: A.... <br>
122: A.... <br>
123: A.... <br>
124: A.... <br>
125: A.... <br>
126: A.... <br>
127: A.... <br>
128: A.... <br>
129: A.... <br>
130: A.... <br>
131: A.... <br>
132: A.... <br>
133: A.... <br>
134: A.... <br>
135: A.... <br>
136: A.... <br>
137: A.... <br>
138: A.... <br>
139: A.... <br>
140: A.... <br>
141: A.... <br>
142: A.... <br>
143: A.... <br>
144: A.... <br>
145: A.... <br>
146: A.... <br>
147: A.... <br>
148: A.... <br>
149: A.... <br>
150: A.... <br>
151: A.... <br>
152: A.... <br>
153: A.... <br>
154: A.... <br>
155: A.... <br>
156: A.... <br>
157: A.... <br>
158: A.... <br>
159: A.... <br>
160: A.... <br>
161: A.... <br>
162: A.... <br>
163: A.... <br>
164: A.... <br>
165: A.... <br>
166: A.... <br>
167: A.... <br>
168: A.... <br>
169: A.... <br>
170: A.... <br>
171: A.... <br>
172: A.... <br>
173: A.... <br>
174: A.... <br>
175: A.... <br>
176: A.... <br>
177: A.... <br>
178: A.... <br>
179: A.... <br>
180: A.... <br>
181: A.... <br>
182: A.... <br>
183: A.... <br>
184: A.... <br>
185: A.... <br>
186: A.... <br>
187: A.... <br>
188: A.... <br>
189: A.... <br>
190: A.... <br>
191: A.... <br>
192: A.... <br>
193: A.... <br>
194: A.... <br>
195: A.... <br>
196: A.... <br>
197: A.... <br>
198: A.... <br>
199: A.... <br>
200: A.... <br>
201: A.... <br>
202: A.... <br>
203: A.... <br>
204: A.... <br>
205: A.... <br>
206: A.... <br>
207: A.... <br>
208: A.... <br>
209: A.... <br>
210: A.... <br>
211: A.... <br>
212: A.... <br>
213: A.... <br>
214: A.... <br>
215: A.... <br>
216: A.... <br>
217: A.... <br>
218: A.... <br>
219: A.... <br>
220: A.... <br>
221: A.... <br>
222: A.... <br>
223: A.... <br>
224: A.... <br>
230: A.... <br>
231: A.... <br>
232: A.... <br>
233: A.... <br>
234: GS... <br>
235: A.... <br>
236: A.... <br>
237: A.... <br>
238: A.... <br>
239: A.... <br>
240: A.... <br>
256: G...V <br>
257: G...V <br>
259: G...V<br>
[Domain info]<br>
id=3D0x00000000<br>
priority=3D100</font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: cat /proc/ipipe/Xenomai<br>
+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)<br>
|+---- Sticky<br>
||+--- Locked<br>
|||+-- Exclusive<br>
||||+- Virtual<br>
[IRQ] |||||<br>
9: W..X.<br>
230: W....<br>
233: W..X.<br>
234: GS...<br>
258: W...V<br>
[Domain info]<br>
id=3D0x58454e4f<br>
priority=3Dtopmost</font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: cat /proc/ipipe/version<br>
2.1-02</font><br>
<font face=3D"Times New Roman"><br>
Di 5. Mai 07:12:41 CEST 2009<br>
running: generate_loads 1<br>
dd workload started, pids 5100 stored in /var/lock/xeno-test.4960.pids<=
br>
5100 pts/2 00:00:00 dd<br>
something died a 5100 or</font></body></html>=

--0__=4EBBFF3EDFB4DBC98f9e8a93df938690918c4EBBFF3EDFB4DBC9--


