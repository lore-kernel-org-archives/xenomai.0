From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <27fdadba-ac90-0f22-36f1-8aebc62b0bae@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 17 Jun 2021 09:15:27 +0200
MIME-Version: 1.0
Message-ID: <10a7-60caf680-a9-35a6e6c0@10083718>
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

Le Mercredi, Juin 16, 2021 17:10 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 16.06.21 15:51, Fran=C3=A7ois Legal wrote:
> > Le Mercredi, Juin 16, 2021 15:38 CEST, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 16.06.21 15:29, Fran=C3=A7ois Legal wrote:
> >>> Le Mercredi, Juin 16, 2021 11:40 CEST, Jan Kiszka <jan.kiszka@sie=
mens.com> a =C3=A9crit: 
> >>>  
> >>>> On 16.06.21 11:12, Fran=C3=A7ois Legal via Xenomai wrote:
> >>>>> Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan" <hongzh=
an.chen@intel.com> a =C3=A9crit: 
> >>>>>  
> >>>>>>
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org> 
> >>>>>>> Sent: Wednesday, June 16, 2021 4:19 PM
> >>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >>>>>>> Cc: xenomai@xenomai.org
> >>>>>>> Subject: RE: Large gpio interrupt latency
> >>>>>>>
> >>>>>>> Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hong=
zhan.chen@intel.com> a =C3=A9crit: 
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> -----Original Message-----
> >>>>>>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Fr=
an=C3=A7ois Legal via Xenomai
> >>>>>>>>> Sent: Wednesday, June 16, 2021 3:16 PM
> >>>>>>>>> To: xenomai@xenomai.org
> >>>>>>>>> Subject: Large gpio interrupt latency
> >>>>>>>>>
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> working on a realtime data recorder (for which I submitted =
a patch to add timestamp retrieval for net packets), I experience a str=
ange latency problem with taking GPIO interrupts.
> >>>>>>>>>
> >>>>>>>>> So basically my app monitors network packets (which as rece=
ived by the DUT would trigger toggling of a GPIO on the DUT) and one GP=
IO.
> >>>>>>>>> We know (from some ohter reference instrument) that the DUT=
 would toggle the GPIO 1-2ms after receiving a specific network packet.=

> >>>>>>>>>
> >>>>>>>>> My recorder app relies on the timestamping of events done i=
n interrupts service routines for GPIOs and network interface. By check=
ing the timestamps returned by the application, I get an about 50ms del=
ay between the network packet and the GPIO (so something between 51 and=
 52ms delay).
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Are you toggling gpio and access gpio device  through your r=
tdm device like on path /dev/rtdm/your=5Fgpiocontroller/gpio*?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Maybe my setup was not very clear.
> >>>>>>> I've got a DUT that receives network data, and toggles one of=
 its GPIOs depending one the network data.
> >>>>>>>
> >>>>>>> I've got another device running my realtime recording app, th=
at receives the same network data as the DUT, and that has one of its G=
PIO connected to the DUT GPIO.
> >>>>>>>
> >>>>>>> On the recording app, I use the RTDM device to open, ioctl (e=
nable interrupt + timestamp), then select & read the GPIO value.
> >>>>>>
> >>>>>> When issue happen, the recording app side have got same number=
 of network data packages and gpio interrupts with that DUT have been t=
oggling?  
> >>>>>> I am asking this because I met gpio hardware issue that would =
cause gpio interrupt missing or invalid gpio interrupts when gpio is co=
nnecting on two different boards.
> >>>>>>
> >>>>>
> >>>>> AFAICT, I'm not missing GPIO edges/interrupts in the app. Regar=
ding network, the DUT and the recoding device are connected to the same=
 switch with the same port config.
> >>>>>
> >>>>> Moreover, I tried changing the interrupt polarity of the record=
ing device (switched from rising edge to falling edge), and the result =
is 1-2ms + ~30ms (the width of the pulse of the DUT) + 50ms latency
> >>>>>
> >>>>
> >>>> Can you (or did you already) break down the latencies on the DUT=
 via
> >>>> tracing? Is it really the GPIO output path? What is happening in=
 it,
> >>>> starting with RT/Linux task switches, mode transitions etc.?
> >>>>
> >>>
> >>> I just did it.
> >>>
> >>> I did put gpio=5Fpin=5Finterrupt as trigger, then ran my applicat=
ion, triggered the GPIO.
> >>> This is what I get in frozen, but I'm not quite sure how to read =
it and what conclusion I could derive :
> >>>  cat frozen
> >>> I-pipe frozen back-tracing service on 4.4.227+/ipipe release #10
> >>> ------------------------------------------------------------
> >>> CPU: 0, Freeze: 218343820846 cycles, Trace Points: 100 (+10)
> >>> Calibrated minimum trace-point overhead: 0.461 us
> >>>
> >>>  +----- Hard IRQs ('|': locked)
> >>>  |+-- Xenomai
> >>>  ||+- Linux ('*': domain stalled, '+': current, '#': current+stal=
led)
> >>>  |||                      +---------- Delay flag ('+': > 1 us, '!=
': > 10 us)
> >>>  |||                      |        +- NMI noise ('N')
> >>>  |||                      |        |
> >>>           Type    User Val.   Time    Delay  Function (Parent)
> >>> :  +func               -6087+   1.302  load=5Fbalance+0x14 (run=5F=
rebalance=5Fdomains+0x7e8)
> >>> :  +func               -6085      0.826  idle=5Fcpu+0x10 (load=5F=
balance+0x180)
> >>> :  +func               -6084      0.892  find=5Fbusiest=5Fgroup+0=
x14 (load=5Fbalance+0x1a4)
> >>> :  +func               -6084      0.757  update=5Fgroup=5Fcapacit=
y+0x14 (find=5Fbusiest=5Fgroup+0x128)
> >>> :  +func               -6083+   1.452  =5F=5Fmsecs=5Fto=5Fjiffies=
+0x10 (update=5Fgroup=5Fcapacity+0x30)
> >>> :  +func               -6081+   1.535  idle=5Fcpu+0x10 (find=5Fbu=
siest=5Fgroup+0x1e4)
> >>> :  +func               -6080+   1.410  idle=5Fcpu+0x10 (find=5Fbu=
siest=5Fgroup+0x1e4)
> >>> :  +func               -6078      0.967  =5F=5Fmsecs=5Fto=5Fjiffi=
es+0x10 (run=5Frebalance=5Fdomains+0x810)
> >>> :  +func               -6077      0.886  =5F=5Frcu=5Fread=5Funloc=
k+0x10 (run=5Frebalance=5Fdomains+0x648)
> >>> :  +func               -6077      0.820  rcu=5Fbh=5Fqs+0x10 (=5F=5F=
do=5Fsoftirq+0x1b0)
> >>> :  +func               -6076      0.742  ipipe=5Fstall=5Froot+0x1=
0 (=5F=5Fdo=5Fsoftirq+0x1b4)
> >>> :  +func               -6075      0.766  ipipe=5Froot=5Fonly+0x10=
 (ipipe=5Fstall=5Froot+0x18)
> >>> :| +begin   0x80000001 -6074      0.934  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Froot=5Fonly+0xb8)
> >>> :| +end     0x80000001 -6073      0.811  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Froot=5Fonly+0xfc)
> >>> :| +begin   0x80000001 -6072      0.895  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Fstall=5Froot+0x78)
> >>> :| #end     0x80000001 -6072      0.847  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Fstall=5Froot+0xb8)
> >>> :  #func               -6071      0.814  =5F=5Flocal=5Fbh=5Fenabl=
e+0x10 (=5F=5Fdo=5Fsoftirq+0x214)
> >>> :  #func               -6070      0.760  ipipe=5Ftest=5Froot+0x10=
 (=5F=5Flocal=5Fbh=5Fenable+0x1c)
> >>> :| #begin   0x80000001 -6069      0.907  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Ftest=5Froot+0x74)
> >>> :| #end     0x80000001 -6068      0.898  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Ftest=5Froot+0xb8)
> >>> :  #func               -6067      0.811  rcu=5Firq=5Fexit+0x10 (i=
rq=5Fexit+0x84)
> >>> :  #func               -6067      0.781  ipipe=5Ftest=5Fand=5Fsta=
ll=5Froot+0x10 (rcu=5Firq=5Fexit+0x18)
> >>> :  #func               -6066      0.799  ipipe=5Froot=5Fonly+0x10=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>> :| #begin   0x80000001 -6065+   1.041  ipipe=5Ftrace=5Fbegin+0x24=
 (ipipe=5Froot=5Fonly+0xb8)
> >>> :| #end     0x80000001 -6064      0.769  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Froot=5Fonly+0xfc)
> >>> :| #begin   0x80000001 -6063      0.895  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>> :| #end     0x80000001 -6062      0.841  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>> :  #func               -6061+   1.197  rcu=5Feqs=5Fenter=5Fcommon=
.constprop.21+0x10 (rcu=5Firq=5Fexit+0x80)
> >>> :| #begin   0x80000000 -6060+   1.413  ipipe=5Ftrace=5Fbegin+0x24=
 (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x2b8)
> >>> :| +end     0x00000012 -6059+   1.044  ipipe=5Ftrace=5Fend+0x24 (=
=5F=5Fipipe=5Fgrab=5Firq+0x84)
> >>> :| +func               -6058      0.988  =5F=5Fipipe=5Fcheck=5Fro=
ot=5Finterruptible+0x10 (=5F=5Firq=5Fsvc+0x70)
> >>> :| +func               -6057      0.976  ipipe=5Ftest=5Froot+0x10=
 (=5F=5Fipipe=5Fcheck=5Froot=5Finterruptible+0x68)
> >>> :| +func               -6056      0.829  =5F=5Fipipe=5Fbugon=5Fir=
qs=5Fenabled+0x10 (=5F=5Fipipe=5Ffast=5Fsvc=5Firq=5Fexit+0x4)
> >>> :| +end     0x90000000 -6055      0.913  =5F=5Fipipe=5Ffast=5Fsvc=
=5Firq=5Fexit+0x20 (ipipe=5Funstall=5Froot+0x88)
> >>> :  +func               -6054      0.781  ipipe=5Ftest=5Froot+0x10=
 (cpu=5Fstartup=5Fentry+0x12c)
> >>> :| +begin   0x80000001 -6053      0.868  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Ftest=5Froot+0x74)
> >>> :| +end     0x80000001 -6052      0.781  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Ftest=5Froot+0xb8)
> >>> :  +func               -6052      0.748  rcu=5Fidle=5Fexit+0x10 (=
cpu=5Fstartup=5Fentry+0x138)
> >>> :  +func               -6051      0.739  ipipe=5Ftest=5Fand=5Fsta=
ll=5Froot+0x10 (rcu=5Fidle=5Fexit+0x18)
> >>> :  +func               -6050      0.775  ipipe=5Froot=5Fonly+0x10=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>> :| +begin   0x80000001 -6049+   1.011  ipipe=5Ftrace=5Fbegin+0x24=
 (ipipe=5Froot=5Fonly+0xb8)
> >>> :| +end     0x80000001 -6048      0.742  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Froot=5Fonly+0xfc)
> >>> :| +begin   0x80000001 -6048      0.940  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>> :| #end     0x80000001 -6047      0.790  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>> :  #func               -6046      0.859  rcu=5Feqs=5Fexit=5Fcommo=
n.constprop.19+0x10 (rcu=5Fidle=5Fexit+0x8c)
> >>> :  #func               -6045      0.772  ipipe=5Funstall=5Froot+0=
x10 (rcu=5Fidle=5Fexit+0x78)
> >>> :| #begin   0x80000000 -6044      0.814  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Funstall=5Froot+0x98)
> >>> :| #func               -6043+   1.077  ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Funstall=5Froot+0x24)
> >>> :| +end     0x80000000 -6042      0.835  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Funstall=5Froot+0x84)
> >>> :  +func               -6042      0.922  arch=5Fcpu=5Fidle=5Fexit=
+0x10 (cpu=5Fstartup=5Fentry+0xfc)
> >>> :  +func               -6041      0.793  ipipe=5Fstall=5Froot+0x1=
0 (cpu=5Fstartup=5Fentry+0xc4)
> >>> :  +func               -6040      0.724  ipipe=5Froot=5Fonly+0x10=
 (ipipe=5Fstall=5Froot+0x18)
> >>> :| +begin   0x80000001 -6039+   1.098  ipipe=5Ftrace=5Fbegin+0x24=
 (ipipe=5Froot=5Fonly+0xb8)
> >>> :| +end     0x80000001 -6038      0.772  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Froot=5Fonly+0xfc)
> >>> :| +begin   0x80000001 -6037      0.841  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Fstall=5Froot+0x78)
> >>> :| #end     0x80000001 -6036      0.763  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Fstall=5Froot+0xb8)
> >>> :  #func               -6036      0.838  arch=5Fcpu=5Fidle=5Fente=
r+0x10 (cpu=5Fstartup=5Fentry+0xc8)
> >>> :  #func               -6035      0.745  arm=5Fheavy=5Fmb+0x10 (a=
rch=5Fcpu=5Fidle=5Fenter+0x1c)
> >>> :  #func               -6034      0.916  l2c210=5Fsync+0x10 (arm=5F=
heavy=5Fmb+0x2c)
> >>> :  #func               -6033+   1.062  tick=5Fcheck=5Fbroadcast=5F=
expired+0x10 (cpu=5Fstartup=5Fentry+0xd8)
> >>> :  #func               -6032      0.787  rcu=5Fidle=5Fenter+0x10 =
(cpu=5Fstartup=5Fentry+0x124)
> >>> :  #func               -6031      0.745  ipipe=5Ftest=5Fand=5Fsta=
ll=5Froot+0x10 (rcu=5Fidle=5Fenter+0x18)
> >>> :  #func               -6031      0.751  ipipe=5Froot=5Fonly+0x10=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>> :| #begin   0x80000001 -6030      0.991  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Froot=5Fonly+0xb8)
> >>> :| #end     0x80000001 -6029      0.772  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Froot=5Fonly+0xfc)
> >>> :| #begin   0x80000001 -6028      0.892  ipipe=5Ftrace=5Fbegin+0x=
24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>> :| #end     0x80000001 -6027      0.847  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>> :  #func               -6026      0.922  rcu=5Feqs=5Fenter=5Fcomm=
on.constprop.21+0x10 (rcu=5Fidle=5Fenter+0x90)
> >>> :  #func               -6025      0.862  default=5Fidle=5Fcall+0x=
10 (cpu=5Fstartup=5Fentry+0x128)
> >>> :  #func               -6024      0.877  arch=5Fcpu=5Fidle+0x10 (=
default=5Fidle=5Fcall+0x38)
> >>> :| #begin   0x80000000 -6024! 5992.167  ipipe=5Ftrace=5Fbegin+0x2=
4 (arch=5Fcpu=5Fidle+0xb8)
> >>
> >> Here your system (or this core) went idle, waiting for the next ev=
ent.
> >>
> >>> :| +func                 -31      0.760  ipipe=5Funstall=5Froot+0=
x10 (arch=5Fcpu=5Fidle+0x30)
> >>
> >> Comming back from idle.
> >>
> >>> :| +func                 -31+   1.116  ipipe=5Froot=5Fonly+0x10 (=
ipipe=5Funstall=5Froot+0x24)
> >>> :| +end     0x80000000   -30      0.931  ipipe=5Ftrace=5Fend+0x24=
 (ipipe=5Funstall=5Froot+0x84)
> >>> :| +begin   0x90000000   -29      0.844  =5F=5Firq=5Fsvc+0x58 (ip=
ipe=5Funstall=5Froot+0x88)
> >>> :| +func                 -28      0.925  gic=5Fhandle=5Firq+0x10 =
(=5F=5Firq=5Fsvc+0x6c)
> >>> :| +func                 -27      0.904  irq=5Ffind=5Fmapping+0x1=
0 (gic=5Fhandle=5Firq+0x50)
> >>> :| +func                 -26      0.940  =5F=5Fipipe=5Fgrab=5Firq=
+0x10 (gic=5Fhandle=5Firq+0x58)
> >>> :| +begin   0x000000c9   -25      0.826  ipipe=5Ftrace=5Fbegin+0x=
24 (=5F=5Fipipe=5Fgrab=5Firq+0x58)
> >>> :| +func                 -24      0.814  =5F=5Fipipe=5Fdispatch=5F=
irq+0x10 (=5F=5Fipipe=5Fgrab=5Firq+0x7c)
> >>> :| +func                 -23+   1.275  irq=5Fto=5Fdesc+0x10 (=5F=5F=
ipipe=5Fdispatch=5Firq+0x184)
> >>> :| +func                 -22+   1.679  irq=5Fto=5Fdesc+0x10 (=5F=5F=
ipipe=5Fdispatch=5Firq+0x198)
> >>> :| +func                 -20+   2.092  ucc=5Fgpio=5Firqhandler+0x=
14 (=5F=5Fipipe=5Fdispatch=5Firq+0x1fc)
> >>> :| +func                 -18+   1.413  irq=5Ffind=5Fmapping+0x10 =
(ucc=5Fgpio=5Firqhandler+0x84)
> >>> :| +begin   0x000000e3   -17      0.757  ipipe=5Ftrace=5Fbegin+0x=
24 (ucc=5Fgpio=5Firqhandler+0x8c)
> >>> :| +func                 -16      0.778  =5F=5Fipipe=5Fdispatch=5F=
irq+0x10 (ucc=5Fgpio=5Firqhandler+0x98)
> >>> :| +func                 -15+   1.023  irq=5Fto=5Fdesc+0x10 (=5F=5F=
ipipe=5Fdispatch=5Firq+0x184)
> >>> :| +func                 -14+   1.494  irq=5Fto=5Fdesc+0x10 (=5F=5F=
ipipe=5Fdispatch=5Firq+0x198)
> >>> :| +func                 -13+   1.014  =5F=5Fipipe=5Fack=5Flevel=5F=
irq+0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x1fc)
> >>> :| +func                 -12      0.763  ucc=5Fgpio=5Firq=5Fmask+=
0x10 (=5F=5Fipipe=5Fack=5Flevel=5Firq+0x54)
> >>> :| +func                 -11+   1.248  =5F=5Fipipe=5Fspin=5Flock=5F=
irqsave+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x2c)
> >>> :| #func                 -10+   1.619  =5F=5Fipipe=5Fspin=5Funloc=
k=5Firqrestore+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x4c)
> >>> :| +func                  -8+   1.239  =5F=5Fipipe=5Fset=5Firq=5F=
pending+0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x3bc)
> >>> :| +end     0x000000e3    -7      0.994  ipipe=5Ftrace=5Fend+0x24=
 (ucc=5Fgpio=5Firqhandler+0xa0)
> >>> :| +func                  -6+   1.029  gic=5Feoi=5Firq+0x10 (ucc=5F=
gpio=5Firqhandler+0xd4)
> >>> :| +func                  -5+   1.353  =5F=5Fipipe=5Fdo=5Fsync=5F=
pipeline+0x14 (=5F=5Fipipe=5Fdispatch=5Firq+0x17c)
> >>> :|+ func                  -4+   1.449  =5F=5Fipipe=5Fdo=5Fsync=5F=
stage+0x14 (=5F=5Fipipe=5Fdo=5Fsync=5Fpipeline+0xf0)
> >>> :|# func                  -2+   1.191  xnintr=5Firq=5Fhandler+0x1=
4 (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x200)
> >>> :|# func                  -1+   1.455  =5F=5F=5Fxnlock=5Fget+0x10=
 (xnintr=5Firq=5Fhandler+0xc0)
> >>> <|# func                   0      1.107  gpio=5Fpin=5Finterrupt+0=
x10 (xnintr=5Firq=5Fhandler+0xf4)
> >>
> >> And here we start to process that GPIO interrupt in the RTDM handl=
er,
> >> roughly after 30 =C2=B5s (which are also due to tracing overhead).=
 So far
> >> nothing suspiciuos.
> >>
> >>>  |# func                   1      1.236  xnclock=5Fcore=5Fread=5F=
monotonic+0x10 (gpio=5Fpin=5Finterrupt+0x1c)
> >>>  |# func                   2      1.224  rtdm=5Fevent=5Fsignal+0x=
10 (gpio=5Fpin=5Finterrupt+0x2c)
> >>
> >> Here some likely waiting RT task is signalled. Does that one notic=
e a
> >> too high latency?
> > 
> > I may have been wrong speaking of "latency". The problem I'm trying=
 to fix, is understanding why my reference instrument indicates a delay=
 from network packet to GPIO on the DUT of about 1 to 2ms, whereas my x=
enomai powered realtime recorder application, given the same network st=
ream and gpio access gives me ~50 to 52 ms.
> > 
> > I first though there was something wrong/delayed on the GPIO interr=
upt side (the network packet could not have been received before it is =
sent right).
> > The trace seem to demonstrate ~30=C2=B5s of interrupt latency (a nu=
mber I expected for interrupt latency on that system) for the GPIO. So =
something is wrong on my system, but I don't know what !
> > 
> 
> Try to trace events, not functions, using regular ftrace ("trace-cmd
> record -e cobalt* -e sched* -e irq* -e signal*" e.g.). Check when the=

> NIC gets the interrupt and compare that to when the GPIO event is
> triggered (or whatever is trigger and reaction). Function tracing is =
for
> zooming in when you know where to zoom.
> 

I just tried what you indicated (trace-cmd...), but I can't see any of =
my RT interrupts. Only eth0 (which supports my NFS rootfs).
I'll try again adjusting the -e flags and report back.

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


