Message-ID: <4354C0A9.5060901@domain.hid>
Date: Tue, 18 Oct 2005 11:30:17 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080006040107010504030101"
Subject: [Xenomai-core] Xenomai latency tests on various PowerPC boards
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
--------------080006040107010504030101
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hallo,

attached you will find the results of Xemonai latency measurements on
various embedded PowerPC boards using MPC 8xx and AMCC 4xx processors,
from low to high end covering a worst case latency range from 25 to 225
us. It also includes a comparison with RTAI 3.0r5 on the slowest CPU.
Here are some remarks and comments:

- On low-end processor code size matters a lot and it's difficult to
  beat RTAI/RTHAL.

- Apart from the CPU power, big caches and a fast memory interface
  improves latencies.

- L2 cache improves latencies a lot (compare Ocotea with Yosemite).

- I'm a bit puzzled about the results of the "cruncher" test. Could
  someone explain the output, please?

- Stability seems already quite good. At least I did not observe any
  crash yet :-).

The PowerPC port of Xenomai is already in good shape. That's great!

Wolfgang.




--------------080006040107010504030101
Content-Type: text/plain;
 name="xenomai-latencies-ppc-summary.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-latencies-ppc-summary.log"

Latency tests with Xenomai on various PowerPC boards
----------------------------------------------------

Board   : Processor  CPU-Clk Bus-Clk I-Cache D-Cache Memory Remarks

TQM860L : MPC 860     50 MHz  50 MHz    4 KB    4 kB  16 MB
TQM866M : MPC 866    133 MHz  66 MHz   16 KB    8 kB 128 MB

Walnut  : AMCC 405GP 200 MHz 100 MHz   16 KB    8 kB  32 MB
Yosemite: AMCC 440EP 533 MHz 133 MHz   32 KB   32 KB 256 MB DDR-RAM, FPU
Ocotea  : AMCC 440GX 533 MHz 152 MHz   32 KB   32 KB 256 MB DDR-RAM, L2 256 KB


Linux  : DENX linux-2.6.14-rc3-g4c234921
iPipe  : 1.0-00
Xenomai: SVN 2005-10-15


CRUNCER without load:

         | Ideal computation time
TQM860L  |   368 us ???
TQM866L  | 10008 us 
Walnut   | 10150 us
Yosemite |  9911 us
Ocotea   |  9479 us 


SWITCH without load:

         |     lat min|     lat avg|     lat max|        lost
TQM860L  |      103360|      107840|      209280|           0
TQM866L  |       25745|       31880|       51369|           5
Walnut   |       24620|       25965|       32280|           1
Yosemite |        5626|        5655|       17403|           0
Ocotea   |        5158|        5169|       10038|           0


KLATENCY with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
TQM860L  |       50560|       98976|      199040|       0|    00:09:45
TQM866L  |       13835|       28571|       74348|       0|    00:11:44
Walnut   |       16195|       25062|       45755|       0|    00:10:09
Yosemite |        3106|        9697|       36832|       0|    00:09:55
Ocotea   |        3575|        7438|       24474|       0|    00:10:50


LATENCY with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
TQM860L  |       60480|      120960|      224320|       0|    00:09:46
TQM866L  |       15759|       34286|       78799|       0|    00:11:14
Walnut   |       21070|       31650|       64500|       0|    00:09:58
Yosemite |        3808|       12163|       47898|       0|    00:10:00
Ocotea   |        3575|        7438|       24474|       0|    00:10:50


KLATENCY comparison Xenomai 2.0 vs. RTAI/RTHAL 3.0r5 on TQM860L:
---------------------------------------------------------------

KLATENCY with load:

            |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
Xenomai 2.0 |       50560|       98976|      199040|       0|    00:09:45
RTAI 3.0r5  |       23120|       31838|       70520|       ?|    00:12:26



Note: load has been put onto the system by running in a telnet session
      "ping -f <remote-host-ip>" and "while ls; do ls; done".

Note: all test have been run with CONFIG_XENO_HW_TIMER_LATENCY="1" and
      CONFIG_XENO_HW_SCHED_LATENCY="1" to get correct latancy values.
      RTAI figures have been corrected manually.



--------------080006040107010504030101
Content-Type: application/x-gzip;
 name="xenomai-latencies-ppc.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="xenomai-latencies-ppc.tgz"

H4sIABK7VEMAA+1abW/bOBLuZ/2KuRQLJIdYISWSlnSbAn5tfE1sr+10210sAsVWEl1tySvJ
qVP0x9+Qkmw5cdJs201zB80HW+TwZUgOZ54hufSCcOb6lambeMHY9+JK8ufMEmSqT8PLF9+H
CCVEMPaCIJlUqH/G0zSS4Fy8oMQ0ODVNQ3Asjzn8BZDv1P+DtIgTNwJ48TGcXjxU7tydnIc3
8VOI9JR0WqmHYQJUp7oJu/9eTIHaYBDCoQJUOFw4tLqngdbonzoA8K7fsMRyufytHwRNBm4C
nMDJ0ScHGHyoQ6fScMdXXppoZol2qwHzyIu9INHqoRtNHBj9coI6dtysk5pZGXGiG8TQmoPa
CfZBBZzUtfZxbXiEKUsmOoHsG2Iv8t2p1lskzjrViqJCqusp3rDRgNboqDXotkb7SoA8Bb/3
B52T1h9av3HS6NQc4Dp5C2OUCi7CRYCy1Qave8P30A/6nWYLmlyrL2IgDuh6740G0PSu/bEn
M07CiTfFsfSGR516DU7eMJPYJ7URtP1o5sBrbJlCHYZe9BK7sWsmtSzR16BAo5u558CR7L3p
xx82eA137o795AanlhpCt3Ei4BCYTuB1HXYtxg1iEVgCp4ZcINkU7ESLAC6mbnx1FlzEO5CE
MMNRJRDJRb7wp158EyfeDMJrL4Jue4gVj/wE3OAGPng3snychHNwF0l4jlVwLol2+ArOJ35w
EWozbyZ3SyLFOwSyzDYwUQz/kwcrBs0YSpasjmQwssFI66RNWQVGeHERe0neh9FqIyOO3FXv
G50rRtb7BsOfzaKzczfO+2i32ylDDg37uYw3a1DND5KLyPszG4ekVL2180W8neElV+5kEuUj
Jw6hDjEco+GItsNbWqcPBT61DZ0KSzd1C6VwF5MIzW7GorigBM7nsaZpx36wWAI40Gx138FU
piqGLnTKKtHYrFyysWEy20CB+z4uOxakOqngyN6l5tyB4duu2sYVSiqUa1pjcNpt4BaAj35y
FS4SmIbuxMF8d+qfoxR+cAlj1B7csJGu60wwyk2+D6aw7vxMwsCDSgX8iedOYRzO5osEWwgD
SPyZh2PBUrCIdU1qAcTubI56tw8qdfUJ1ETuzv3JIauSfZiHU398czhE6Zpn7U67h1mRHx7a
9p5WyUjrukEYTz1vDv/xk8TDLT/zAzVrAnvah5m7lJuDU5Vyry8lT6W01tIbL5R0m1VNglzc
SD/t5dUtrnIMU2albTCmsij9qSCMNvy1M2oc3Z7Kw0MYyrHKqZyjOQrRmHAie5GsZggB7kHU
MC+KFvMEkis/xpGGl6i+2mB09FnpCPphKd86gXIUOO7yc24fpmGcYL1mloEO1BRklahaLE8Y
xDYssqoHck9rb45ro1a38V4NIh+BEkONMRdjlZBirDkoRkWaEFSYz3nmuRcnn7Pvj2GkhBvm
vXLCV8KBbdlVkUtq22QlKaQfchfZDuMH+QduiC3Sbptvms733zYOQdhqKilO7GpQhsFMY/s4
RD4OsdESpca6Jay7asmUtvBOS4w7Jj3IP3CtumGCvkPOBVy5MYrtBYAbEcIArXiCfjcz9ec3
gMML5Cyh3ruQeNMAbWvsxTFuiszl7Mwlv3IBP0feDBuuXKF2Vfz5qx30DRPY+XiFvgOm8b9w
82d/gbej51K40ym2GycoybWXiiI9kVqtRq/b7rw+e9fq9s6Ofj0bofcdnGXrebhDVQeZFLeK
piahWBRHdomyj8Mo8saJ3BJuML6Ba3e68NDeoJ4oGHsDM8+NFzgUxBxxKkZqUg2d6QZXYxqM
ah0wdRJx2P3gT92F5673+FdSZrmd1GQv5/PxmXHGzibetTdFuxfOUoOORnb8QVqOlYW2UHMd
YumakspJhUO7jPYYMuFgVwm791BtLUqk8Z9443Ts6OSltV2oOTGpwaUJRq+VFlPQANe9mFQL
i6gAtJcwnsDBIo4OIjTz0rIfyCWOF37iHXzwouAgjRlusKR+gMstdyTuycEIZ38WRrgIbuBe
ogjXElseo6J6Ex1kGdX+PyXBcFQbjDrd14D4DE77MGjVjkHqCKjVPz1Gl4XW9giOO93Td6Aq
ZVXbfRie9vs97LDWbcqazffQ7g2gBv3WoNNrdhqqpcG61s+vsnZGncYbQKgm7cXu0W978POr
dZFG7bhTH6DaNQFhL7QHrV9OlfXJZ/ChGqrHSqc7ag0Gp/1RZdSrrEeSmzG0FthKEN/bSq+L
E3DUG8GwNcJZURMittbpnfQ72LQDl+MxoCmTmxrV2pRwXilb67j5BjMQ4afZFXtPVtdevky1
LFtFxMAZEpB+PAyn8PIlrmxqWKU3VRBJCYDZ7nV0mTl7CrsqS6mlApbSGijLiW3GHrImqe9b
IBKThqndP8XMFMvJtGwowhz1fzZDWA3oGlEPEQgmqCmo5+yAGAfo6w1lSSlBY4FmXUUFBq0K
mZbWXGUwtMoqw5WyXHppqaqNIQYim1utGdQxxUZraJaLrYkqN+62ZlmmhZKl1u8mXKSGD80T
gj1EFoQEMaRmGMd84V+iLYr/oWk/Otq7S8vt8b+YPV38b3L8zuJ/gzOaxv9mGf8/Bd2O/wMZ
cmfxv4xjmMPMQvx/IuP//ABAhv+4ZLpt2zIWgt8phry4xaiJnkrm/JEHtLjXCqcD1mNOB8RJ
Gw16tdKXrVGidTCkwpbQF01uVkcFhlU4KzCNbz4ryE8HNs8MVmcFAN0Q4/L8rACn5WtiY+sv
x8ZGkXErNmbNHxIbF9b9VnAshM4yxp3guEkc23TsusNNB/u6Lziu0geC4x8eG1MhTMKMfcBQ
wH5ENCw9p4qHvxQOox38xnA4i3/TcBZBRiEaFsaDwbCl4lxSCIaNdU4WC4s856tC4UJophb8
qyNdMHiV8TwhT9VW0RJ6EGEXI11+T6T7twWI1LTMlWyGxas0T1SZyaw7YR2lDmMH+cfzCXQp
r/LVTJrMsMRqHFbVtreNg+bjoKwMT7eFpz/a12+ju/jvozsNFsl3hH9fxH+C8dv4TyC7xH9P
QAX8x2B3iB4FvUaO/2zHtB3C9rQc/tVOECz1w49e1G8AI/w1BuzetQ4tCQWlh5YwcLd/XD/E
Jd+HXr9+yPG/VW8cpuflezki7Dc6aAGCMYynIYaNWN00ZYH99IQ0QFcqi7jRuS9PMbzAPZ96
ky/jyRxD/qq0GAeRitxvpNK25F5MvbMquBVWpkAyQ5WcGtg8QsCOLCfvgpreNbz1gs5EfuFv
A1FZDB3Er4/Hnl8FHDdgYAE4Inaz7rlUIQXGJnAs4MO/BBy34cOaZMyjcJzDQHVFkumDNp+e
n+UQUTFozhj7BQbCfDPVgS2XKsypNZyW6VDbEeY9uNEiOn/WuJHYNjX4PiJkIR6FGyknj7pH
4d98j6IuQ3LoRxkpAEez+hBwNNht4Mj4beBoWM8FODKxPqM3uC3WKNK4dUVCnxw4CmqvgSMn
wsgTDKEYvwu45EnYQf7xfICjQUmVrMG54KsEunmy9YaEWwf5Rwkcnxg43sV/N2HszdDpfj8E
+CX8V+XVAv4jWB63aXn+9yS0if96qHx0hf8oX5//bSI/RloZ8qvngOt9pjZFyKWK3YFcuYl9
2+hJcySE8vl5rkKaPAMCeSYiSix6KxPRpQO3are25CnoltXdBvcMXnxxJJhMPAru5R3I2wYy
BrCIJeShpGFj2lC55K+fR8pLQ7ZcniEIkl59naJfd95IN48VC7Cxcd95I7v/vPF7wcaqPLu8
Cxt5AQVu4kZa5DwaOKJzbDUc/LCqDiOST/MCd/n0HmCJM6g/6xNJw7bNRwBKhJ/0ce9ymPhG
PFktwEmriCath8AkuXMIWb2DJZ8JlAQuDFFIrBEarTJiPua1zd8GwRB2kbVstrCrKzwmLNPY
CsHyxzb8GT22ARMt6mpaDSpW08qqlr3lLBVHQHJITEok+Rgkec/9b/n++zb9/+O/8v13+f67
fP9dvv8u33+X77/L99/l++//PXRbvv8u33+X77/L99/l+++SSiqppJJKKqmkkkoqqaSSSiqp
pJJKUvRfoI6rTgBQAAA=
--------------080006040107010504030101--

