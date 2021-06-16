From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <1818b5b8-7f6d-77d4-2354-6180a8541664@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 16 Jun 2021 15:29:06 +0200
MIME-Version: 1.0
Message-ID: <1202-60c9fc80-167-1ab27320@266230705>
Subject: =?utf-8?q?Re=3A?= Large gpio interrupt latency
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>, =?utf-8?q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mercredi, Juin 16, 2021 11:40 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 16.06.21 11:12, Fran=C3=A7ois Legal via Xenomai wrote:
> > Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan" <hongzhan.c=
hen@intel.com> a =C3=A9crit: 
> >  
> >>
> >>
> >>> -----Original Message-----
> >>> From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org> 
> >>> Sent: Wednesday, June 16, 2021 4:19 PM
> >>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >>> Cc: xenomai@xenomai.org
> >>> Subject: RE: Large gpio interrupt latency
> >>>
> >>> Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hongzhan=
.chen@intel.com> a =C3=A9crit: 
> >>>
> >>>>
> >>>>>
> >>>>> -----Original Message-----
> >>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Fran=C3=
=A7ois Legal via Xenomai
> >>>>> Sent: Wednesday, June 16, 2021 3:16 PM
> >>>>> To: xenomai@xenomai.org
> >>>>> Subject: Large gpio interrupt latency
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> working on a realtime data recorder (for which I submitted a pa=
tch to add timestamp retrieval for net packets), I experience a strange=
 latency problem with taking GPIO interrupts.
> >>>>>
> >>>>> So basically my app monitors network packets (which as received=
 by the DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
> >>>>> We know (from some ohter reference instrument) that the DUT wou=
ld toggle the GPIO 1-2ms after receiving a specific network packet.
> >>>>>
> >>>>> My recorder app relies on the timestamping of events done in in=
terrupts service routines for GPIOs and network interface. By checking =
the timestamps returned by the application, I get an about 50ms delay b=
etween the network packet and the GPIO (so something between 51 and 52m=
s delay).
> >>>>>
> >>>>
> >>>> Are you toggling gpio and access gpio device  through your rtdm =
device like on path /dev/rtdm/your=5Fgpiocontroller/gpio*?
> >>>>
> >>>
> >>> Maybe my setup was not very clear.
> >>> I've got a DUT that receives network data, and toggles one of its=
 GPIOs depending one the network data.
> >>>
> >>> I've got another device running my realtime recording app, that r=
eceives the same network data as the DUT, and that has one of its GPIO =
connected to the DUT GPIO.
> >>>
> >>> On the recording app, I use the RTDM device to open, ioctl (enabl=
e interrupt + timestamp), then select & read the GPIO value.
> >>
> >> When issue happen, the recording app side have got same number of =
network data packages and gpio interrupts with that DUT have been toggl=
ing?  
> >> I am asking this because I met gpio hardware issue that would caus=
e gpio interrupt missing or invalid gpio interrupts when gpio is connec=
ting on two different boards.
> >>
> > 
> > AFAICT, I'm not missing GPIO edges/interrupts in the app. Regarding=
 network, the DUT and the recoding device are connected to the same swi=
tch with the same port config.
> > 
> > Moreover, I tried changing the interrupt polarity of the recording =
device (switched from rising edge to falling edge), and the result is 1=
-2ms + ~30ms (the width of the pulse of the DUT) + 50ms latency
> > 
> 
> Can you (or did you already) break down the latencies on the DUT via
> tracing? Is it really the GPIO output path? What is happening in it,
> starting with RT/Linux task switches, mode transitions etc.?
> 

I just did it.

I did put gpio=5Fpin=5Finterrupt as trigger, then ran my application, t=
riggered the GPIO.
This is what I get in frozen, but I'm not quite sure how to read it and=
 what conclusion I could derive :
 cat frozen
I-pipe frozen back-tracing service on 4.4.227+/ipipe release #10
------------------------------------------------------------
CPU: 0, Freeze: 218343820846 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.461 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||                      +---------- Delay flag ('+': > 1 us, '!': > 1=
0 us)
 |||                      |        +- NMI noise ('N')
 |||                      |        |
          Type    User Val.   Time    Delay  Function (Parent)
:  +func               -6087+   1.302  load=5Fbalance+0x14 (run=5Frebal=
ance=5Fdomains+0x7e8)
:  +func               -6085      0.826  idle=5Fcpu+0x10 (load=5Fbalanc=
e+0x180)
:  +func               -6084      0.892  find=5Fbusiest=5Fgroup+0x14 (l=
oad=5Fbalance+0x1a4)
:  +func               -6084      0.757  update=5Fgroup=5Fcapacity+0x14=
 (find=5Fbusiest=5Fgroup+0x128)
:  +func               -6083+   1.452  =5F=5Fmsecs=5Fto=5Fjiffies+0x10 =
(update=5Fgroup=5Fcapacity+0x30)
:  +func               -6081+   1.535  idle=5Fcpu+0x10 (find=5Fbusiest=5F=
group+0x1e4)
:  +func               -6080+   1.410  idle=5Fcpu+0x10 (find=5Fbusiest=5F=
group+0x1e4)
:  +func               -6078      0.967  =5F=5Fmsecs=5Fto=5Fjiffies+0x1=
0 (run=5Frebalance=5Fdomains+0x810)
:  +func               -6077      0.886  =5F=5Frcu=5Fread=5Funlock+0x10=
 (run=5Frebalance=5Fdomains+0x648)
:  +func               -6077      0.820  rcu=5Fbh=5Fqs+0x10 (=5F=5Fdo=5F=
softirq+0x1b0)
:  +func               -6076      0.742  ipipe=5Fstall=5Froot+0x10 (=5F=
=5Fdo=5Fsoftirq+0x1b4)
:  +func               -6075      0.766  ipipe=5Froot=5Fonly+0x10 (ipip=
e=5Fstall=5Froot+0x18)
:| +begin   0x80000001 -6074      0.934  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Froot=5Fonly+0xb8)
:| +end     0x80000001 -6073      0.811  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Froot=5Fonly+0xfc)
:| +begin   0x80000001 -6072      0.895  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Fstall=5Froot+0x78)
:| #end     0x80000001 -6072      0.847  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Fstall=5Froot+0xb8)
:  #func               -6071      0.814  =5F=5Flocal=5Fbh=5Fenable+0x10=
 (=5F=5Fdo=5Fsoftirq+0x214)
:  #func               -6070      0.760  ipipe=5Ftest=5Froot+0x10 (=5F=5F=
local=5Fbh=5Fenable+0x1c)
:| #begin   0x80000001 -6069      0.907  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Ftest=5Froot+0x74)
:| #end     0x80000001 -6068      0.898  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Ftest=5Froot+0xb8)
:  #func               -6067      0.811  rcu=5Firq=5Fexit+0x10 (irq=5Fe=
xit+0x84)
:  #func               -6067      0.781  ipipe=5Ftest=5Fand=5Fstall=5Fr=
oot+0x10 (rcu=5Firq=5Fexit+0x18)
:  #func               -6066      0.799  ipipe=5Froot=5Fonly+0x10 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0x18)
:| #begin   0x80000001 -6065+   1.041  ipipe=5Ftrace=5Fbegin+0x24 (ipip=
e=5Froot=5Fonly+0xb8)
:| #end     0x80000001 -6064      0.769  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Froot=5Fonly+0xfc)
:| #begin   0x80000001 -6063      0.895  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
:| #end     0x80000001 -6062      0.841  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0xc4)
:  #func               -6061+   1.197  rcu=5Feqs=5Fenter=5Fcommon.const=
prop.21+0x10 (rcu=5Firq=5Fexit+0x80)
:| #begin   0x80000000 -6060+   1.413  ipipe=5Ftrace=5Fbegin+0x24 (=5F=5F=
ipipe=5Fdo=5Fsync=5Fstage+0x2b8)
:| +end     0x00000012 -6059+   1.044  ipipe=5Ftrace=5Fend+0x24 (=5F=5F=
ipipe=5Fgrab=5Firq+0x84)
:| +func               -6058      0.988  =5F=5Fipipe=5Fcheck=5Froot=5Fi=
nterruptible+0x10 (=5F=5Firq=5Fsvc+0x70)
:| +func               -6057      0.976  ipipe=5Ftest=5Froot+0x10 (=5F=5F=
ipipe=5Fcheck=5Froot=5Finterruptible+0x68)
:| +func               -6056      0.829  =5F=5Fipipe=5Fbugon=5Firqs=5Fe=
nabled+0x10 (=5F=5Fipipe=5Ffast=5Fsvc=5Firq=5Fexit+0x4)
:| +end     0x90000000 -6055      0.913  =5F=5Fipipe=5Ffast=5Fsvc=5Firq=
=5Fexit+0x20 (ipipe=5Funstall=5Froot+0x88)
:  +func               -6054      0.781  ipipe=5Ftest=5Froot+0x10 (cpu=5F=
startup=5Fentry+0x12c)
:| +begin   0x80000001 -6053      0.868  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Ftest=5Froot+0x74)
:| +end     0x80000001 -6052      0.781  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Ftest=5Froot+0xb8)
:  +func               -6052      0.748  rcu=5Fidle=5Fexit+0x10 (cpu=5F=
startup=5Fentry+0x138)
:  +func               -6051      0.739  ipipe=5Ftest=5Fand=5Fstall=5Fr=
oot+0x10 (rcu=5Fidle=5Fexit+0x18)
:  +func               -6050      0.775  ipipe=5Froot=5Fonly+0x10 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0x18)
:| +begin   0x80000001 -6049+   1.011  ipipe=5Ftrace=5Fbegin+0x24 (ipip=
e=5Froot=5Fonly+0xb8)
:| +end     0x80000001 -6048      0.742  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Froot=5Fonly+0xfc)
:| +begin   0x80000001 -6048      0.940  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
:| #end     0x80000001 -6047      0.790  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0xc4)
:  #func               -6046      0.859  rcu=5Feqs=5Fexit=5Fcommon.cons=
tprop.19+0x10 (rcu=5Fidle=5Fexit+0x8c)
:  #func               -6045      0.772  ipipe=5Funstall=5Froot+0x10 (r=
cu=5Fidle=5Fexit+0x78)
:| #begin   0x80000000 -6044      0.814  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Funstall=5Froot+0x98)
:| #func               -6043+   1.077  ipipe=5Froot=5Fonly+0x10 (ipipe=5F=
unstall=5Froot+0x24)
:| +end     0x80000000 -6042      0.835  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Funstall=5Froot+0x84)
:  +func               -6042      0.922  arch=5Fcpu=5Fidle=5Fexit+0x10 =
(cpu=5Fstartup=5Fentry+0xfc)
:  +func               -6041      0.793  ipipe=5Fstall=5Froot+0x10 (cpu=
=5Fstartup=5Fentry+0xc4)
:  +func               -6040      0.724  ipipe=5Froot=5Fonly+0x10 (ipip=
e=5Fstall=5Froot+0x18)
:| +begin   0x80000001 -6039+   1.098  ipipe=5Ftrace=5Fbegin+0x24 (ipip=
e=5Froot=5Fonly+0xb8)
:| +end     0x80000001 -6038      0.772  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Froot=5Fonly+0xfc)
:| +begin   0x80000001 -6037      0.841  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Fstall=5Froot+0x78)
:| #end     0x80000001 -6036      0.763  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Fstall=5Froot+0xb8)
:  #func               -6036      0.838  arch=5Fcpu=5Fidle=5Fenter+0x10=
 (cpu=5Fstartup=5Fentry+0xc8)
:  #func               -6035      0.745  arm=5Fheavy=5Fmb+0x10 (arch=5F=
cpu=5Fidle=5Fenter+0x1c)
:  #func               -6034      0.916  l2c210=5Fsync+0x10 (arm=5Fheav=
y=5Fmb+0x2c)
:  #func               -6033+   1.062  tick=5Fcheck=5Fbroadcast=5Fexpir=
ed+0x10 (cpu=5Fstartup=5Fentry+0xd8)
:  #func               -6032      0.787  rcu=5Fidle=5Fenter+0x10 (cpu=5F=
startup=5Fentry+0x124)
:  #func               -6031      0.745  ipipe=5Ftest=5Fand=5Fstall=5Fr=
oot+0x10 (rcu=5Fidle=5Fenter+0x18)
:  #func               -6031      0.751  ipipe=5Froot=5Fonly+0x10 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0x18)
:| #begin   0x80000001 -6030      0.991  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Froot=5Fonly+0xb8)
:| #end     0x80000001 -6029      0.772  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Froot=5Fonly+0xfc)
:| #begin   0x80000001 -6028      0.892  ipipe=5Ftrace=5Fbegin+0x24 (ip=
ipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
:| #end     0x80000001 -6027      0.847  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Ftest=5Fand=5Fstall=5Froot+0xc4)
:  #func               -6026      0.922  rcu=5Feqs=5Fenter=5Fcommon.con=
stprop.21+0x10 (rcu=5Fidle=5Fenter+0x90)
:  #func               -6025      0.862  default=5Fidle=5Fcall+0x10 (cp=
u=5Fstartup=5Fentry+0x128)
:  #func               -6024      0.877  arch=5Fcpu=5Fidle+0x10 (defaul=
t=5Fidle=5Fcall+0x38)
:| #begin   0x80000000 -6024! 5992.167  ipipe=5Ftrace=5Fbegin+0x24 (arc=
h=5Fcpu=5Fidle+0xb8)
:| +func                 -31      0.760  ipipe=5Funstall=5Froot+0x10 (a=
rch=5Fcpu=5Fidle+0x30)
:| +func                 -31+   1.116  ipipe=5Froot=5Fonly+0x10 (ipipe=5F=
unstall=5Froot+0x24)
:| +end     0x80000000   -30      0.931  ipipe=5Ftrace=5Fend+0x24 (ipip=
e=5Funstall=5Froot+0x84)
:| +begin   0x90000000   -29      0.844  =5F=5Firq=5Fsvc+0x58 (ipipe=5F=
unstall=5Froot+0x88)
:| +func                 -28      0.925  gic=5Fhandle=5Firq+0x10 (=5F=5F=
irq=5Fsvc+0x6c)
:| +func                 -27      0.904  irq=5Ffind=5Fmapping+0x10 (gic=
=5Fhandle=5Firq+0x50)
:| +func                 -26      0.940  =5F=5Fipipe=5Fgrab=5Firq+0x10 =
(gic=5Fhandle=5Firq+0x58)
:| +begin   0x000000c9   -25      0.826  ipipe=5Ftrace=5Fbegin+0x24 (=5F=
=5Fipipe=5Fgrab=5Firq+0x58)
:| +func                 -24      0.814  =5F=5Fipipe=5Fdispatch=5Firq+0=
x10 (=5F=5Fipipe=5Fgrab=5Firq+0x7c)
:| +func                 -23+   1.275  irq=5Fto=5Fdesc+0x10 (=5F=5Fipip=
e=5Fdispatch=5Firq+0x184)
:| +func                 -22+   1.679  irq=5Fto=5Fdesc+0x10 (=5F=5Fipip=
e=5Fdispatch=5Firq+0x198)
:| +func                 -20+   2.092  ucc=5Fgpio=5Firqhandler+0x14 (=5F=
=5Fipipe=5Fdispatch=5Firq+0x1fc)
:| +func                 -18+   1.413  irq=5Ffind=5Fmapping+0x10 (ucc=5F=
gpio=5Firqhandler+0x84)
:| +begin   0x000000e3   -17      0.757  ipipe=5Ftrace=5Fbegin+0x24 (uc=
c=5Fgpio=5Firqhandler+0x8c)
:| +func                 -16      0.778  =5F=5Fipipe=5Fdispatch=5Firq+0=
x10 (ucc=5Fgpio=5Firqhandler+0x98)
:| +func                 -15+   1.023  irq=5Fto=5Fdesc+0x10 (=5F=5Fipip=
e=5Fdispatch=5Firq+0x184)
:| +func                 -14+   1.494  irq=5Fto=5Fdesc+0x10 (=5F=5Fipip=
e=5Fdispatch=5Firq+0x198)
:| +func                 -13+   1.014  =5F=5Fipipe=5Fack=5Flevel=5Firq+=
0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x1fc)
:| +func                 -12      0.763  ucc=5Fgpio=5Firq=5Fmask+0x10 (=
=5F=5Fipipe=5Fack=5Flevel=5Firq+0x54)
:| +func                 -11+   1.248  =5F=5Fipipe=5Fspin=5Flock=5Firqs=
ave+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x2c)
:| #func                 -10+   1.619  =5F=5Fipipe=5Fspin=5Funlock=5Fir=
qrestore+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x4c)
:| +func                  -8+   1.239  =5F=5Fipipe=5Fset=5Firq=5Fpendin=
g+0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x3bc)
:| +end     0x000000e3    -7      0.994  ipipe=5Ftrace=5Fend+0x24 (ucc=5F=
gpio=5Firqhandler+0xa0)
:| +func                  -6+   1.029  gic=5Feoi=5Firq+0x10 (ucc=5Fgpio=
=5Firqhandler+0xd4)
:| +func                  -5+   1.353  =5F=5Fipipe=5Fdo=5Fsync=5Fpipeli=
ne+0x14 (=5F=5Fipipe=5Fdispatch=5Firq+0x17c)
:|+ func                  -4+   1.449  =5F=5Fipipe=5Fdo=5Fsync=5Fstage+=
0x14 (=5F=5Fipipe=5Fdo=5Fsync=5Fpipeline+0xf0)
:|# func                  -2+   1.191  xnintr=5Firq=5Fhandler+0x14 (=5F=
=5Fipipe=5Fdo=5Fsync=5Fstage+0x200)
:|# func                  -1+   1.455  =5F=5F=5Fxnlock=5Fget+0x10 (xnin=
tr=5Firq=5Fhandler+0xc0)
<|# func                   0      1.107  gpio=5Fpin=5Finterrupt+0x10 (x=
nintr=5Firq=5Fhandler+0xf4)
 |# func                   1      1.236  xnclock=5Fcore=5Fread=5Fmonoto=
nic+0x10 (gpio=5Fpin=5Finterrupt+0x1c)
 |# func                   2      1.224  rtdm=5Fevent=5Fsignal+0x10 (gp=
io=5Fpin=5Finterrupt+0x2c)
 |# func                   3      1.032  =5F=5F=5Fxnlock=5Fget+0x10 (rt=
dm=5Fevent=5Fsignal+0x80)
 |# func                   4      0.997  xnsynch=5Fflush+0x14 (rtdm=5Fe=
vent=5Fsignal+0xa0)
 |# func                   5      1.835  =5F=5F=5Fxnlock=5Fget+0x10 (xn=
synch=5Fflush+0x74)
 |# func                   7      1.083  =5F=5Fxnselect=5Fsignal+0x10 (=
rtdm=5Fevent=5Fsignal+0x1e4)
 |# func                   8      0.856  xnsynch=5Fflush+0x14 (=5F=5Fxn=
select=5Fsignal+0x90)
 |# func                   9      0.958  =5F=5F=5Fxnlock=5Fget+0x10 (xn=
synch=5Fflush+0x74)
 |# func                  10      0.886  xnthread=5Fresume+0x14 (xnsync=
h=5Fflush+0xe8)
 |# func                  11      0.000  =5F=5F=5Fxnlock=5Fget+0x10 (xn=
thread=5Fresume+0x7c)



> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


