From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
In-Reply-To: <87wnqnz2my.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 21 Jun 2021 17:35:14 +0200
MIME-Version: 1.0
Message-ID: <10a0-60d0b180-85-29fb8780@204393696>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>, =?utf-8?q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Lundi, Juin 21, 2021 16:57 CEST, Philippe Gerum <rpm@xenomai.org> a =
=C3=A9crit: 
 
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> > On 21.06.21 16:28, Philippe Gerum wrote:
> >> 
> >> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >> 
> >>> On 21.06.21 15:54, Philippe Gerum wrote:
> >>>>
> >>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>>
> >>>>> On 21.06.21 11:39, Philippe Gerum wrote:
> >>>>>>
> >>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
> >>>>>>
> >>>>>>> On 18.06.21 20:41, Fran=C3=A7ois Legal wrote:
> >>>>>>>> Le Mercredi, Juin 16, 2021 17:10 CEST, Jan Kiszka <jan.kiszk=
a@siemens.com> a =C3=A9crit: 
> >>>>>>>>  
> >>>>>>>>> On 16.06.21 15:51, Fran=C3=A7ois Legal wrote:
> >>>>>>>>>> Le Mercredi, Juin 16, 2021 15:38 CEST, Jan Kiszka <jan.kis=
zka@siemens.com> a =C3=A9crit: 
> >>>>>>>>>>  
> >>>>>>>>>>> On 16.06.21 15:29, Fran=C3=A7ois Legal wrote:
> >>>>>>>>>>>> Le Mercredi, Juin 16, 2021 11:40 CEST, Jan Kiszka <jan.k=
iszka@siemens.com> a =C3=A9crit: 
> >>>>>>>>>>>>  
> >>>>>>>>>>>>> On 16.06.21 11:12, Fran=C3=A7ois Legal via Xenomai wrot=
e:
> >>>>>>>>>>>>>> Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan=
" <hongzhan.chen@intel.com> a =C3=A9crit: 
> >>>>>>>>>>>>>>  
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> -----Original Message-----
> >>>>>>>>>>>>>>>> From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org> 
> >>>>>>>>>>>>>>>> Sent: Wednesday, June 16, 2021 4:19 PM
> >>>>>>>>>>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >>>>>>>>>>>>>>>> Cc: xenomai@xenomai.org
> >>>>>>>>>>>>>>>> Subject: RE: Large gpio interrupt latency
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzh=
an" <hongzhan.chen@intel.com> a =C3=A9crit: 
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> -----Original Message-----
> >>>>>>>>>>>>>>>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Beh=
alf Of Fran=C3=A7ois Legal via Xenomai
> >>>>>>>>>>>>>>>>>> Sent: Wednesday, June 16, 2021 3:16 PM
> >>>>>>>>>>>>>>>>>> To: xenomai@xenomai.org
> >>>>>>>>>>>>>>>>>> Subject: Large gpio interrupt latency
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Hello,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> working on a realtime data recorder (for which I s=
ubmitted a patch to add timestamp retrieval for net packets), I experie=
nce a strange latency problem with taking GPIO interrupts.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> So basically my app monitors network packets (whic=
h as received by the DUT would trigger toggling of a GPIO on the DUT) a=
nd one GPIO.
> >>>>>>>>>>>>>>>>>> We know (from some ohter reference instrument) tha=
t the DUT would toggle the GPIO 1-2ms after receiving a specific networ=
k packet.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> My recorder app relies on the timestamping of even=
ts done in interrupts service routines for GPIOs and network interface.=
 By checking the timestamps returned by the application, I get an about=
 50ms delay between the network packet and the GPIO (so something betwe=
en 51 and 52ms delay).
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Are you toggling gpio and access gpio device  throu=
gh your rtdm device like on path /dev/rtdm/your=5Fgpiocontroller/gpio*?=

> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Maybe my setup was not very clear.
> >>>>>>>>>>>>>>>> I've got a DUT that receives network data, and toggl=
es one of its GPIOs depending one the network data.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I've got another device running my realtime recordin=
g app, that receives the same network data as the DUT, and that has one=
 of its GPIO connected to the DUT GPIO.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On the recording app, I use the RTDM device to open,=
 ioctl (enable interrupt + timestamp), then select & read the GPIO valu=
e.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> When issue happen, the recording app side have got sa=
me number of network data packages and gpio interrupts with that DUT ha=
ve been toggling?  
> >>>>>>>>>>>>>>> I am asking this because I met gpio hardware issue th=
at would cause gpio interrupt missing or invalid gpio interrupts when g=
pio is connecting on two different boards.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> AFAICT, I'm not missing GPIO edges/interrupts in the a=
pp. Regarding network, the DUT and the recoding device are connected to=
 the same switch with the same port config.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Moreover, I tried changing the interrupt polarity of t=
he recording device (switched from rising edge to falling edge), and th=
e result is 1-2ms + ~30ms (the width of the pulse of the DUT) + 50ms la=
tency
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Can you (or did you already) break down the latencies o=
n the DUT via
> >>>>>>>>>>>>> tracing? Is it really the GPIO output path? What is hap=
pening in it,
> >>>>>>>>>>>>> starting with RT/Linux task switches, mode transitions =
etc.?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> I just did it.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I did put gpio=5Fpin=5Finterrupt as trigger, then ran my=
 application, triggered the GPIO.
> >>>>>>>>>>>> This is what I get in frozen, but I'm not quite sure how=
 to read it and what conclusion I could derive :
> >>>>>>>>>>>>  cat frozen
> >>>>>>>>>>>> I-pipe frozen back-tracing service on 4.4.227+/ipipe rel=
ease #10
> >>>>>>>>>>>> --------------------------------------------------------=
----
> >>>>>>>>>>>> CPU: 0, Freeze: 218343820846 cycles, Trace Points: 100 (=
+10)
> >>>>>>>>>>>> Calibrated minimum trace-point overhead: 0.461 us
> >>>>>>>>>>>>
> >>>>>>>>>>>>  +----- Hard IRQs ('|': locked)
> >>>>>>>>>>>>  |+-- Xenomai
> >>>>>>>>>>>>  ||+- Linux ('*': domain stalled, '+': current, '#': cur=
rent+stalled)
> >>>>>>>>>>>>  |||                      +---------- Delay flag ('+': >=
 1 us, '!': > 10 us)
> >>>>>>>>>>>>  |||                      |        +- NMI noise ('N')
> >>>>>>>>>>>>  |||                      |        |
> >>>>>>>>>>>>           Type    User Val.   Time    Delay  Function (P=
arent)
> >>>>>>>>>>>> :  +func               -6087+   1.302  load=5Fbalance+0x=
14 (run=5Frebalance=5Fdomains+0x7e8)
> >>>>>>>>>>>> :  +func               -6085      0.826  idle=5Fcpu+0x10=
 (load=5Fbalance+0x180)
> >>>>>>>>>>>> :  +func               -6084      0.892  find=5Fbusiest=5F=
group+0x14 (load=5Fbalance+0x1a4)
> >>>>>>>>>>>> :  +func               -6084      0.757  update=5Fgroup=5F=
capacity+0x14 (find=5Fbusiest=5Fgroup+0x128)
> >>>>>>>>>>>> :  +func               -6083+   1.452  =5F=5Fmsecs=5Fto=5F=
jiffies+0x10 (update=5Fgroup=5Fcapacity+0x30)
> >>>>>>>>>>>> :  +func               -6081+   1.535  idle=5Fcpu+0x10 (=
find=5Fbusiest=5Fgroup+0x1e4)
> >>>>>>>>>>>> :  +func               -6080+   1.410  idle=5Fcpu+0x10 (=
find=5Fbusiest=5Fgroup+0x1e4)
> >>>>>>>>>>>> :  +func               -6078      0.967  =5F=5Fmsecs=5Ft=
o=5Fjiffies+0x10 (run=5Frebalance=5Fdomains+0x810)
> >>>>>>>>>>>> :  +func               -6077      0.886  =5F=5Frcu=5Frea=
d=5Funlock+0x10 (run=5Frebalance=5Fdomains+0x648)
> >>>>>>>>>>>> :  +func               -6077      0.820  rcu=5Fbh=5Fqs+0=
x10 (=5F=5Fdo=5Fsoftirq+0x1b0)
> >>>>>>>>>>>> :  +func               -6076      0.742  ipipe=5Fstall=5F=
root+0x10 (=5F=5Fdo=5Fsoftirq+0x1b4)
> >>>>>>>>>>>> :  +func               -6075      0.766  ipipe=5Froot=5F=
only+0x10 (ipipe=5Fstall=5Froot+0x18)
> >>>>>>>>>>>> :| +begin   0x80000001 -6074      0.934  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Froot=5Fonly+0xb8)
> >>>>>>>>>>>> :| +end     0x80000001 -6073      0.811  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Froot=5Fonly+0xfc)
> >>>>>>>>>>>> :| +begin   0x80000001 -6072      0.895  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Fstall=5Froot+0x78)
> >>>>>>>>>>>> :| #end     0x80000001 -6072      0.847  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Fstall=5Froot+0xb8)
> >>>>>>>>>>>> :  #func               -6071      0.814  =5F=5Flocal=5Fb=
h=5Fenable+0x10 (=5F=5Fdo=5Fsoftirq+0x214)
> >>>>>>>>>>>> :  #func               -6070      0.760  ipipe=5Ftest=5F=
root+0x10 (=5F=5Flocal=5Fbh=5Fenable+0x1c)
> >>>>>>>>>>>> :| #begin   0x80000001 -6069      0.907  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Ftest=5Froot+0x74)
> >>>>>>>>>>>> :| #end     0x80000001 -6068      0.898  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Ftest=5Froot+0xb8)
> >>>>>>>>>>>> :  #func               -6067      0.811  rcu=5Firq=5Fexi=
t+0x10 (irq=5Fexit+0x84)
> >>>>>>>>>>>> :  #func               -6067      0.781  ipipe=5Ftest=5F=
and=5Fstall=5Froot+0x10 (rcu=5Firq=5Fexit+0x18)
> >>>>>>>>>>>> :  #func               -6066      0.799  ipipe=5Froot=5F=
only+0x10 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>>>>>>>>>>> :| #begin   0x80000001 -6065+   1.041  ipipe=5Ftrace=5Fb=
egin+0x24 (ipipe=5Froot=5Fonly+0xb8)
> >>>>>>>>>>>> :| #end     0x80000001 -6064      0.769  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Froot=5Fonly+0xfc)
> >>>>>>>>>>>> :| #begin   0x80000001 -6063      0.895  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>>>>>>>>>>> :| #end     0x80000001 -6062      0.841  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>>>>>>>>>>> :  #func               -6061+   1.197  rcu=5Feqs=5Fenter=
=5Fcommon.constprop.21+0x10 (rcu=5Firq=5Fexit+0x80)
> >>>>>>>>>>>> :| #begin   0x80000000 -6060+   1.413  ipipe=5Ftrace=5Fb=
egin+0x24 (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x2b8)
> >>>>>>>>>>>> :| +end     0x00000012 -6059+   1.044  ipipe=5Ftrace=5Fe=
nd+0x24 (=5F=5Fipipe=5Fgrab=5Firq+0x84)
> >>>>>>>>>>>> :| +func               -6058      0.988  =5F=5Fipipe=5Fc=
heck=5Froot=5Finterruptible+0x10 (=5F=5Firq=5Fsvc+0x70)
> >>>>>>>>>>>> :| +func               -6057      0.976  ipipe=5Ftest=5F=
root+0x10 (=5F=5Fipipe=5Fcheck=5Froot=5Finterruptible+0x68)
> >>>>>>>>>>>> :| +func               -6056      0.829  =5F=5Fipipe=5Fb=
ugon=5Firqs=5Fenabled+0x10 (=5F=5Fipipe=5Ffast=5Fsvc=5Firq=5Fexit+0x4)
> >>>>>>>>>>>> :| +end     0x90000000 -6055      0.913  =5F=5Fipipe=5Ff=
ast=5Fsvc=5Firq=5Fexit+0x20 (ipipe=5Funstall=5Froot+0x88)
> >>>>>>>>>>>> :  +func               -6054      0.781  ipipe=5Ftest=5F=
root+0x10 (cpu=5Fstartup=5Fentry+0x12c)
> >>>>>>>>>>>> :| +begin   0x80000001 -6053      0.868  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Ftest=5Froot+0x74)
> >>>>>>>>>>>> :| +end     0x80000001 -6052      0.781  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Ftest=5Froot+0xb8)
> >>>>>>>>>>>> :  +func               -6052      0.748  rcu=5Fidle=5Fex=
it+0x10 (cpu=5Fstartup=5Fentry+0x138)
> >>>>>>>>>>>> :  +func               -6051      0.739  ipipe=5Ftest=5F=
and=5Fstall=5Froot+0x10 (rcu=5Fidle=5Fexit+0x18)
> >>>>>>>>>>>> :  +func               -6050      0.775  ipipe=5Froot=5F=
only+0x10 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>>>>>>>>>>> :| +begin   0x80000001 -6049+   1.011  ipipe=5Ftrace=5Fb=
egin+0x24 (ipipe=5Froot=5Fonly+0xb8)
> >>>>>>>>>>>> :| +end     0x80000001 -6048      0.742  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Froot=5Fonly+0xfc)
> >>>>>>>>>>>> :| +begin   0x80000001 -6048      0.940  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>>>>>>>>>>> :| #end     0x80000001 -6047      0.790  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>>>>>>>>>>> :  #func               -6046      0.859  rcu=5Feqs=5Fexi=
t=5Fcommon.constprop.19+0x10 (rcu=5Fidle=5Fexit+0x8c)
> >>>>>>>>>>>> :  #func               -6045      0.772  ipipe=5Funstall=
=5Froot+0x10 (rcu=5Fidle=5Fexit+0x78)
> >>>>>>>>>>>> :| #begin   0x80000000 -6044      0.814  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Funstall=5Froot+0x98)
> >>>>>>>>>>>> :| #func               -6043+   1.077  ipipe=5Froot=5Fon=
ly+0x10 (ipipe=5Funstall=5Froot+0x24)
> >>>>>>>>>>>> :| +end     0x80000000 -6042      0.835  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Funstall=5Froot+0x84)
> >>>>>>>>>>>> :  +func               -6042      0.922  arch=5Fcpu=5Fid=
le=5Fexit+0x10 (cpu=5Fstartup=5Fentry+0xfc)
> >>>>>>>>>>>> :  +func               -6041      0.793  ipipe=5Fstall=5F=
root+0x10 (cpu=5Fstartup=5Fentry+0xc4)
> >>>>>>>>>>>> :  +func               -6040      0.724  ipipe=5Froot=5F=
only+0x10 (ipipe=5Fstall=5Froot+0x18)
> >>>>>>>>>>>> :| +begin   0x80000001 -6039+   1.098  ipipe=5Ftrace=5Fb=
egin+0x24 (ipipe=5Froot=5Fonly+0xb8)
> >>>>>>>>>>>> :| +end     0x80000001 -6038      0.772  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Froot=5Fonly+0xfc)
> >>>>>>>>>>>> :| +begin   0x80000001 -6037      0.841  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Fstall=5Froot+0x78)
> >>>>>>>>>>>> :| #end     0x80000001 -6036      0.763  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Fstall=5Froot+0xb8)
> >>>>>>>>>>>> :  #func               -6036      0.838  arch=5Fcpu=5Fid=
le=5Fenter+0x10 (cpu=5Fstartup=5Fentry+0xc8)
> >>>>>>>>>>>> :  #func               -6035      0.745  arm=5Fheavy=5Fm=
b+0x10 (arch=5Fcpu=5Fidle=5Fenter+0x1c)
> >>>>>>>>>>>> :  #func               -6034      0.916  l2c210=5Fsync+0=
x10 (arm=5Fheavy=5Fmb+0x2c)
> >>>>>>>>>>>> :  #func               -6033+   1.062  tick=5Fcheck=5Fbr=
oadcast=5Fexpired+0x10 (cpu=5Fstartup=5Fentry+0xd8)
> >>>>>>>>>>>> :  #func               -6032      0.787  rcu=5Fidle=5Fen=
ter+0x10 (cpu=5Fstartup=5Fentry+0x124)
> >>>>>>>>>>>> :  #func               -6031      0.745  ipipe=5Ftest=5F=
and=5Fstall=5Froot+0x10 (rcu=5Fidle=5Fenter+0x18)
> >>>>>>>>>>>> :  #func               -6031      0.751  ipipe=5Froot=5F=
only+0x10 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x18)
> >>>>>>>>>>>> :| #begin   0x80000001 -6030      0.991  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Froot=5Fonly+0xb8)
> >>>>>>>>>>>> :| #end     0x80000001 -6029      0.772  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Froot=5Fonly+0xfc)
> >>>>>>>>>>>> :| #begin   0x80000001 -6028      0.892  ipipe=5Ftrace=5F=
begin+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0x80)
> >>>>>>>>>>>> :| #end     0x80000001 -6027      0.847  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Ftest=5Fand=5Fstall=5Froot+0xc4)
> >>>>>>>>>>>> :  #func               -6026      0.922  rcu=5Feqs=5Fent=
er=5Fcommon.constprop.21+0x10 (rcu=5Fidle=5Fenter+0x90)
> >>>>>>>>>>>> :  #func               -6025      0.862  default=5Fidle=5F=
call+0x10 (cpu=5Fstartup=5Fentry+0x128)
> >>>>>>>>>>>> :  #func               -6024      0.877  arch=5Fcpu=5Fid=
le+0x10 (default=5Fidle=5Fcall+0x38)
> >>>>>>>>>>>> :| #begin   0x80000000 -6024! 5992.167  ipipe=5Ftrace=5F=
begin+0x24 (arch=5Fcpu=5Fidle+0xb8)
> >>>>>>>>>>>
> >>>>>>>>>>> Here your system (or this core) went idle, waiting for th=
e next event.
> >>>>>>>>>>>
> >>>>>>>>>>>> :| +func                 -31      0.760  ipipe=5Funstall=
=5Froot+0x10 (arch=5Fcpu=5Fidle+0x30)
> >>>>>>>>>>>
> >>>>>>>>>>> Comming back from idle.
> >>>>>>>>>>>
> >>>>>>>>>>>> :| +func                 -31+   1.116  ipipe=5Froot=5Fon=
ly+0x10 (ipipe=5Funstall=5Froot+0x24)
> >>>>>>>>>>>> :| +end     0x80000000   -30      0.931  ipipe=5Ftrace=5F=
end+0x24 (ipipe=5Funstall=5Froot+0x84)
> >>>>>>>>>>>> :| +begin   0x90000000   -29      0.844  =5F=5Firq=5Fsvc=
+0x58 (ipipe=5Funstall=5Froot+0x88)
> >>>>>>>>>>>> :| +func                 -28      0.925  gic=5Fhandle=5F=
irq+0x10 (=5F=5Firq=5Fsvc+0x6c)
> >>>>>>>>>>>> :| +func                 -27      0.904  irq=5Ffind=5Fma=
pping+0x10 (gic=5Fhandle=5Firq+0x50)
> >>>>>>>>>>>> :| +func                 -26      0.940  =5F=5Fipipe=5Fg=
rab=5Firq+0x10 (gic=5Fhandle=5Firq+0x58)
> >>>>>>>>>>>> :| +begin   0x000000c9   -25      0.826  ipipe=5Ftrace=5F=
begin+0x24 (=5F=5Fipipe=5Fgrab=5Firq+0x58)
> >>>>>>>>>>>> :| +func                 -24      0.814  =5F=5Fipipe=5Fd=
ispatch=5Firq+0x10 (=5F=5Fipipe=5Fgrab=5Firq+0x7c)
> >>>>>>>>>>>> :| +func                 -23+   1.275  irq=5Fto=5Fdesc+0=
x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x184)
> >>>>>>>>>>>> :| +func                 -22+   1.679  irq=5Fto=5Fdesc+0=
x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x198)
> >>>>>>>>>>>> :| +func                 -20+   2.092  ucc=5Fgpio=5Firqh=
andler+0x14 (=5F=5Fipipe=5Fdispatch=5Firq+0x1fc)
> >>>>>>>>>>>> :| +func                 -18+   1.413  irq=5Ffind=5Fmapp=
ing+0x10 (ucc=5Fgpio=5Firqhandler+0x84)
> >>>>>>>>>>>> :| +begin   0x000000e3   -17      0.757  ipipe=5Ftrace=5F=
begin+0x24 (ucc=5Fgpio=5Firqhandler+0x8c)
> >>>>>>>>>>>> :| +func                 -16      0.778  =5F=5Fipipe=5Fd=
ispatch=5Firq+0x10 (ucc=5Fgpio=5Firqhandler+0x98)
> >>>>>>>>>>>> :| +func                 -15+   1.023  irq=5Fto=5Fdesc+0=
x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x184)
> >>>>>>>>>>>> :| +func                 -14+   1.494  irq=5Fto=5Fdesc+0=
x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x198)
> >>>>>>>>>>>> :| +func                 -13+   1.014  =5F=5Fipipe=5Fack=
=5Flevel=5Firq+0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x1fc)
> >>>>>>>>>>>> :| +func                 -12      0.763  ucc=5Fgpio=5Fir=
q=5Fmask+0x10 (=5F=5Fipipe=5Fack=5Flevel=5Firq+0x54)
> >>>>>>>>>>>> :| +func                 -11+   1.248  =5F=5Fipipe=5Fspi=
n=5Flock=5Firqsave+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x2c)
> >>>>>>>>>>>> :| #func                 -10+   1.619  =5F=5Fipipe=5Fspi=
n=5Funlock=5Firqrestore+0x10 (ucc=5Fgpio=5Firq=5Fmask+0x4c)
> >>>>>>>>>>>> :| +func                  -8+   1.239  =5F=5Fipipe=5Fset=
=5Firq=5Fpending+0x10 (=5F=5Fipipe=5Fdispatch=5Firq+0x3bc)
> >>>>>>>>>>>> :| +end     0x000000e3    -7      0.994  ipipe=5Ftrace=5F=
end+0x24 (ucc=5Fgpio=5Firqhandler+0xa0)
> >>>>>>>>>>>> :| +func                  -6+   1.029  gic=5Feoi=5Firq+0=
x10 (ucc=5Fgpio=5Firqhandler+0xd4)
> >>>>>>>>>>>> :| +func                  -5+   1.353  =5F=5Fipipe=5Fdo=5F=
sync=5Fpipeline+0x14 (=5F=5Fipipe=5Fdispatch=5Firq+0x17c)
> >>>>>>>>>>>> :|+ func                  -4+   1.449  =5F=5Fipipe=5Fdo=5F=
sync=5Fstage+0x14 (=5F=5Fipipe=5Fdo=5Fsync=5Fpipeline+0xf0)
> >>>>>>>>>>>> :|# func                  -2+   1.191  xnintr=5Firq=5Fha=
ndler+0x14 (=5F=5Fipipe=5Fdo=5Fsync=5Fstage+0x200)
> >>>>>>>>>>>> :|# func                  -1+   1.455  =5F=5F=5Fxnlock=5F=
get+0x10 (xnintr=5Firq=5Fhandler+0xc0)
> >>>>>>>>>>>> <|# func                   0      1.107  gpio=5Fpin=5Fin=
terrupt+0x10 (xnintr=5Firq=5Fhandler+0xf4)
> >>>>>>>>>>>
> >>>>>>>>>>> And here we start to process that GPIO interrupt in the R=
TDM handler,
> >>>>>>>>>>> roughly after 30 =C2=B5s (which are also due to tracing o=
verhead). So far
> >>>>>>>>>>> nothing suspiciuos.
> >>>>>>>>>>>
> >>>>>>>>>>>>  |# func                   1      1.236  xnclock=5Fcore=5F=
read=5Fmonotonic+0x10 (gpio=5Fpin=5Finterrupt+0x1c)
> >>>>>>>>>>>>  |# func                   2      1.224  rtdm=5Fevent=5F=
signal+0x10 (gpio=5Fpin=5Finterrupt+0x2c)
> >>>>>>>>>>>
> >>>>>>>>>>> Here some likely waiting RT task is signalled. Does that =
one notice a
> >>>>>>>>>>> too high latency?
> >>>>>>>>>>
> >>>>>>>>>> I may have been wrong speaking of "latency". The problem I=
'm trying to fix, is understanding why my reference instrument indicate=
s a delay from network packet to GPIO on the DUT of about 1 to 2ms, whe=
reas my xenomai powered realtime recorder application, given the same n=
etwork stream and gpio access gives me ~50 to 52 ms.
> >>>>>>>>>>
> >>>>>>>>>> I first though there was something wrong/delayed on the GP=
IO interrupt side (the network packet could not have been received befo=
re it is sent right).
> >>>>>>>>>> The trace seem to demonstrate ~30=C2=B5s of interrupt late=
ncy (a number I expected for interrupt latency on that system) for the =
GPIO. So something is wrong on my system, but I don't know what !
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Try to trace events, not functions, using regular ftrace ("=
trace-cmd
> >>>>>>>>> record -e cobalt* -e sched* -e irq* -e signal*" e.g.). Chec=
k when the
> >>>>>>>>> NIC gets the interrupt and compare that to when the GPIO ev=
ent is
> >>>>>>>>> triggered (or whatever is trigger and reaction). Function t=
racing is for
> >>>>>>>>> zooming in when you know where to zoom.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> So I think I found the answer to my problem.
> >>>>>>>> Is there any reason why NET events (in NIC irq functions) ar=
e dated with rtdm=5Fclock=5Fread, whereas GPIO event are dated with rtd=
m=5Fclock=5Fread=5Fmonotonic ?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Inconsistency of the GPIO drivers, UART drivers use rtdm=5Fcl=
ock=5Fread for
> >>>>>>> user-exposed timestamping as well. Maybe Philippe can comment=
 on
> >>>>>>> thoughts behind this deviation.
> >>>>>>>
> >>>>>>
> >>>>>> When running over the I-pipe, rtdm=5Fclock=5Fread() is based o=
n Xenomai's
> >>>>>> idea of real time, which is the Cobalt monotonic clock plus an=
 arbitrary
> >>>>>> offset. For this reason, rtdm=5Fclock=5Fread() is not SMP-cons=
istent
> >>>>>> (different CPUs might read different timestamps at the exact s=
ame time),
> >>>>>> is not in sync with linux's wall clock either. For these reaso=
ns, I
> >>>>>> don't see any practical way to synchronize multiple systems on=
 the clock
> >>>>>> underlying rtdm=5Fclock=5Fread().
> >>>>>>
> >>>>>> Therefore, there is no upside in using rtdm=5Fclock=5Fread() f=
or
> >>>>>> timestamping in this context, only adding the potential for ev=
en more
> >>>>>> surprising results due to the mono->real-time offset changing =
under our
> >>>>>> feet, since the epoch of the Xenomai real-time clock can be (r=
e)set
> >>>>>> during runtime.
> >>>>>>
> >>>>>> I believe the UART driver is wrong here, it should return time=
stamps
> >>>>>> based on the monotonic source, which best fits the common need=
: getting
> >>>>>> timestamps from the local CPU for measuring delays between eve=
nts
> >>>>>> received by drivers and the actions taken by the applications =
which
> >>>>>> consume them, immune from updates to the underlying clock
> >>>>>> epoch. Granted, there might be a catch when a timestamp is tak=
en from
> >>>>>> IRQ context, which is then consumed from a thread living on a =
different
> >>>>>> CPU, if per-CPU clocks are not/badly synchronized. But that wo=
uld happen
> >>>>>> the exact same way with rtdm=5Fclock=5Fread() anyway.
> >>>>>>
> >>>>>> The situation improves when running on top of Dovetail, since =
Xenomai
> >>>>>> now refers to the common linux clocks (mono / real) instead of=
 providing
> >>>>>> its own idea of time, but the UART driver code predates the Do=
vetail
> >>>>>> port.
> >>>>>>  
> >>>>>
> >>>>> Well, it's not just UART. All hardware drivers - except for GPI=
O - use
> >>>>> rtdm=5Fclock=5Fread. That was no problem in practice for their =
use cases so
> >>>>> far. One problem is that GPIO timestamps are now not comparable=
 to others.
> >>>>>
> >>>>> But IIRC, most Xenomai APIs using absolute timestamps are based=
 on
> >>>>> Xenomai's real-time clock. Therefore, providing timestamps for =
that
> >>>>
> >>>> /*
> >>>>  * The Copperplate clock shall be monotonic unless the threading=

> >>>>  * library has restrictions to support this over Mercury.
> >>>>  *
> >>>>  * In the normal case, this means that ongoing delays and timeou=
ts
> >>>>  * won't be affected when the host system date is changed. In th=
e
> >>>>  * restricted case by contrast, ongoing delays and timeouts may =
be
> >>>>  * impacted by changes to the host system date.
> >>>>  *
> >>>>  * The implementation maintains a per-clock epoch value, so that=

> >>>>  * different emulators can have different (virtual) system dates=
.
> >>>>  */
> >>>> #ifdef CONFIG=5FXENO=5FCOPPERPLATE=5FCLOCK=5FRESTRICTED
> >>>> #define CLOCK=5FCOPPERPLATE  CLOCK=5FREALTIME
> >>>> #else
> >>>> #define CLOCK=5FCOPPERPLATE  CLOCK=5FMONOTONIC
> >>>> #endif
> >>>>
> >>>> So no, only the POSIX API is using what the standard mandates, w=
hich is
> >>>> CLOCK=5FREALTIME. All other APIs are based on copperplate, and t=
hey are
> >>>> using a monotonic source as documented above.
> >>>
> >>> OK, but that changed in 3.x. At the time that RTDM API was origin=
ally
> >>> added and then promoted, it was the other not this way. We became=

> >>> inconsistent then.
> >>>
> >>>>
> >>>>> particular clock was the original idea of rtdm=5Fclock=5Fread (=
which
> >>>>> predates rtdm=5Fclock=5Fread=5Fmonotonic). GPIO breaks that and=
 should be
> >>>>> fixed - unless I'm wrong with that assumption.
> >>>>>
> >>>>
> >>>> We cannot assume the epoch is going to remain stable with
> >>>> rtdm=5Fclock=5Fread() the way it is implemented, which is quite =
of a
> >>>> problem wrt the common use case. For timestamping, a majority of=

> >>>> mainline drivers is using ktime=5Fget() or a variant thereof whi=
ch is
> >>>> based on the monotonic clock source, not the =5Freal form. Why w=
ould the
> >>>> real-time I/O drivers be different?
> >>>
> >>> We have two cases here:
> >>>
> >>>  - I-pipe-based version where the realtime clock is under full
> >>>    application control -> no problem to use rtdm=5Fclock=5Fread
> >> 
> >> Well, there is still the issue that rtdm=5Fclock=5Fread() is not i=
mmune to
> >> some part of userland changing the CLOCK=5FREALTIME epoch Xenomai-=
wise
> >> e.g. via a call to clock=5Fsettime(), which is the same problem th=
an Linux
> >> changing the epoch of CLOCK=5FREALTIME over Dovetail. This would b=
reak the
> >> application.
> >
> > Yes, but that's about the application(s) breaking themselves. Nothi=
ng
> > new, not going to change when we only avoid clock=5Frealtime for st=
amps
> > but still use POSIX services basing timers on that clock. The key p=
oint
> > is that I-pipe gave that into RT application hands (with all relate=
d
> > downsides), with Dovetail it's in system hands.
> >
> >> 
> >>>  - Dovetail where we share the realtime clock - with all its tuni=
ng -
> >>>    with Linux -> here we have a problem with rtdm=5Fclock=5Fread =
and should
> >>>    reconsider its usage (and promotion!)
> >>>
> >>> For stable 3.1, the proper fix is with GPIO going to rtdm=5Fclock=
=5Fread.
> >> 
> >> Wait, you have downstream users already depending on GPIO returnin=
g
> >> monotonic timestamps, and this is a =5Fstable=5F release. So why n=
ot fixing
> >> other drivers based on the fact that timestamping with rtdm=5Fcloc=
k=5Fread()
> >> is wrong instead? Same issue, right?
> >
> > GPIO was broken, but you are right that we may have users relying o=
n
> > that breakage now. Obviously, we can change the other drivers for t=
he
> > very same reasons: They are working like they work for more than 10=

> > years now.
> >
> 
> Sorry, but I my views, rtdm=5Fread=5Fclock() was broken since day one=
. GPIO
> had to work around the breakage.. :)
> 
> >> 
> >> So the best course of action to sort this out for 3.1.x may be to =
extend
> >> GPIO=5FRTIOC=5FTS with say, GPIO=5FRTIOC=5FTS=5FREAL, which would =
log and return
> >> timestamps based on the Xenomai wallclock. Applications which do w=
ant to
> >> align on that clock would simply have to issue GPIO=5FRTIOC=5FTS=5F=
REAL
> >> instead of GPIO=5FRTIOC=5FTS. This would break backward ABI compat=
 only for
> >> users of GPIO=5FRTIOC=5FTS=5FREAL, but that would be much better t=
han
> >> introducing a sneaky change in behavior for the GPIO driver.
> >
> > Yeah, likely the way to go.
> >
> >> 
> >>> For 3.2, I'm not sure yet what to do with rtdm=5Fclock=5Fread.
> >>>
> >> 
> >> The decision looks pretty simple for the common use case: when
> >> timestamps are needed for performance/delay measurements, we want =
to get
> >> them from a clock source which won't play funny games, warping bac=
k to
> >> the future.
> >
> > You only think of measurements. The other drivers used the stamping=
 also
> > for real applications, means to calculate absolute clock-realtime
> > timeouts and wait for them to arrive. We will likely need to enhanc=
e
> > also the other driver APIs to select the desired clocksource, just =
like
> > for GPIO.
> 
> I'm referring to what is in the GPIO code, which is the problem at ha=
nd:
> that timestamping was designed since day #1 to provide a way to measu=
re
> the scheduling latency.
> 
> I agree that the only way out is to enable all timestamp consumers to=

> pick their base clock of choice (mono or wallclock).
> 
> -- 
> Philippe.
 
 Hi there,

as we speak of breaking ABI, why not introducing some specific IOCTL to=
 select which timesource to use for each driver using it, then using a =
function pointer to call the right rtdm=5Ftime=5Fget=5Fwhatever functio=
n ?

Fran=C3=A7ois


