Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jun 2011 13:22:32 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD7FECF6@domain.hid>
In-Reply-To: <1308652557.2125.45.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid> <4DFCABDA.6000702@domain.hid>
	<1308406918.2122.24.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>
	<1308652557.2125.45.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> 2% off seems a lot for a transient load, and this would not happen on =
a
> periodic basis anyway. This needs to be investigated. Could you run
> switchtest in nofpu mode?

Still fluctuates about 2% (see !!  mark) but now more erratic. The =
reduced number of context switches is caused by the reduced number of =
tasks?

WE01:~ # switchtest -n
=3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|        2225|        2225
RTD|        2241|        4466
RTD|        2282|        6748
RTD|        2245|        8993
RTD|        2264|       11257
RTD|        2245|       13502
RTD|        2264|       15766
RTD|        2227|       17993
RTD|        2282|       20275
RTD|        2245|       22520
RTD|        2246|       24766
RTD|        2263|       27029
RTD|        2264|       29293
RTD|        2245|       31538
RTD|        2264|       33802
RTD|        2245|       36047
RTD|        2246|       38293
RTD|        2245|       40538
RTD|        2282|       42820
RTD|        2245|       45065
RTD|        2264|       47329
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|        2245|       49574
RTD|        2264|       51838
RTD|        2227|       54065
RTD|        2282|       56347
RTD|        2243|       58590
RTD|        2248|       60838
RTD|        2263|       63101
RTD|        2264|       65365
RTD|        2245|       67610
RTD|        2264|       69874
RTD|        2245|       72119
RTD|        2246|       74365
RTD|        2245|       76610
RTD|        2282|       78892
RTD|        2245|       81137
RTD|        2264|       83401
RTD|        2245|       85646
RTD|        2264|       87910
RTD|        2227|       90137
RTD|        2282|       92419
RTD|        2245|       94664
RTT|  00:00:43
RTH|ctx switches|-------total
RTD|        2246|       96910
RTD|        2263|       99173
RTD|        2264|      101437
RTD|        2245|      103682
RTD|        2264|      105946
RTD|        2245|      108191
RTD|        2246|      110437
RTD|        2245|      112682
RTD|        2282|      114964
RTD|        2245|      117209
RTD|        2264|      119473
RTD|        2245|      121718
RTD|        2264|      123982
!!RTD|        2227|      126209
!!RTD|        2282|      128491
RTD|        2245|      130736
RTD|        2246|      132982
RTD|        2263|      135245
RTD|        2264|      137509
RTD|        2245|      139754
RTD|        2264|      142018
WE01:~ # cat /proc/xenomai/version
2.5.6
WE01:~ # cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT
  0  0      rt      99      233ms634us  master     D          =
rt-watchdog
WE01:~ # cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          6972142    0     00500080   90.5  ROOT
  0  0      0          39412      0     00000084    0.0  rt-watchdog
  0  0      0          9305099    0     00000000    0.5  IRQ512: [timer]





> -----Urspr=C3=BCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Dienstag, 21. Juni 2011 12:36
> An: Wildenburg, Roderik RAEK1 MRA
> Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> Betreff: Re: AW: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
>=20
> On Tue, 2011-06-21 at 12:04 +0200, roderik.wildenburg@domain.hid
> wrote:
> > I confirm that switchtest runs (nearly) perfectly on PPC-Kernel =
2.6.34 with
> Xenomai 2.5.6. The only anomaly I could see is a "collapse" of the =
number of
> context switches exactly every 7 seconds by 2% (see below).  Is this =
worth to pay
> attention to? (No other Xenomai-Task is running except for a watchdog =
task with a
> period of 500ms)
>=20
> 2% off seems a lot for a transient load, and this would not happen on =
a
> periodic basis anyway. This needs to be investigated. Could you run
> switchtest in nofpu mode?
>=20
> >
> > On the opposite, switchtest runs erratic on PPC-2.4.25 with Xenomai =
2.5.6 as
> you already mentioned: The number of context switches is much smaller =
then
> (only about 2%) with  PPC-2.6.34 and fluctuate very much (see below).
> > Do you think you will find some spare time to fix this Problem?
> >
>=20
> Spare time has become a luxury over the last months. I'll try to find =
a
> time slot next week to have a look at this again.
>=20
> > Roderik
> >
> >
> > Xenomai 2.5.6 on PPC-2.6.34:
> > RTH|ctx switches|-------total
> > RTD|        4347|     7290193
> > RTD|        4347|     7294540
> > RTD|        4347|     7298887
> > RTD|        4347|     7303234
> > RTD|        4282|     7307516
> > RTD|        4345|     7311861
> > RTD|        4345|     7316206
> > RTD|        4347|     7320553
> > RTD|        4347|     7324900
> > RTD|        4347|     7329247
> > RTD|        4347|     7333594
> > RTD|        4282|     7337876
> > RTD|        4345|     7342221
> > RTD|        4345|     7346566
> > RTD|        4347|     7350913
> > RTD|        4347|     7355260
> > RTD|        4347|     7359607
> > RTD|        4347|     7363954
> > RTD|        4282|     7368236
> > RTD|        4345|     7372581
> > RTD|        4345|     7376926
> > RTT|  00:28:31
> > WE01:~ # cat /proc/xenomai/sched
> > CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
> >   0  0      idle    -1      -         master     R          ROOT
> >   0  0      rt      99      496ms670us  master     D          =
rt-watchdog
> >
> >
> > Xenomai 2.5.6 on PPC-2.4.25:
> > RTH|ctx switches|-------total
> > RTD|         138|       25321
> > RTD|          73|       25394
> > RTD|          65|       25459
> > RTD|         138|       25597
> > RTD|          73|       25670
> > RTD|          65|       25735
> > RTD|         138|       25873
> > RTD|         138|       26011
> > RTD|         138|       26149
> > RTD|         138|       26287
> > RTD|         138|       26425
> > RTD|         138|       26563
> > RTD|         138|       26701
> > RTD|         138|       26839
> > RTD|         138|       26977
> > RTD|          73|       27050
> > RTD|          65|       27115
> > RTD|         138|       27253
> > RTD|         138|       27391
> > RTD|         138|       27529
> > RTD|         138|       27667
> > RTT|  00:09:48
> > mrconfig:~ # cat /proc/xenomai/sched
> > CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
> >   0  0      idle    -1      -         master     R          ROOT
> >   0  0      rt      60      185ms803us  master     D          =
rt-watchdog
> >
> >
> > > -----Urspr=C3=BCngliche Nachricht-----
> > > Von: Philippe Gerum [mailto:rpm@xenomai.org]
> > > Gesendet: Samstag, 18. Juni 2011 16:22
> > > An: Gilles Chanteperdrix
> > > Cc: Wildenburg, Roderik RAEK1 MRA; xenomai@xenomai.org
> > > Betreff: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
> > >
> > > On Sat, 2011-06-18 at 15:44 +0200, Gilles Chanteperdrix wrote:
> > > > On 06/18/2011 10:50 AM, Philippe Gerum wrote:
> > > > > On Tue, 2011-06-14 at 14:47 +0200, =
roderik.wildenburg@domain.hid
> > > > > wrote:
> > > > >> Perhaps this may help:
> > > > >> I instrumented src/common/sem_heap.c   and =
ksrc/nucleus/heap.c with
> printf
> > > and printk (see appended files) and this is the output:
> > > > >>
> > > > >> 1:mrconfig:~ # latency
> > > > >> 2:xeno_init_private_heap
> > > > >> 3:map_sem_heap syscall 0
> > > > >> 4:xeno_map_heap open 3
> > > > >> 5:xnheap_ioctl private data: 00000000
> > > > >> 6:xeno_map_heap ioctl 0 handle 0xc7dd9210
> > > > >> 7:xnheap_mmap 00000000 00000000
> > > > >> 8:xeno_map_heap 0xffffffff
> > > > >> 9:Xenomai: mmap local sem heap: No such device or address
> > > > >> 10:mrconfig:~ #
> > > > >>
> > > > >>
> > > > >> It looks like (if I figured it out correctly) as if in =
function sem_heap.c-
> > > >xeno_map_heap()  (which is called from xeno_init_privat_heap() =
via
> function
> > > map_sem_heap())  the ioctl-Call fails.
> > > > >> xeno_map_heap() passes correctly an argument unequal NULL as =
third
> > > parameter to ioctl() (line6), but in kernel space function =
xnheap_ioctl() the 3.
> > > parameter arrives as NULL(line 5). This sets file->private_data to =
NULL which
> in
> > > turn lets xnheap_mmap() fail, as this function expects =
file->private_data !=3D
> NULL
> > > (line7).
> > > > >> Therefore xnheap_mmap() returns -ENIXIO to xeno_map_heap() =
which
> > > outputs the error message " Xenomai: mmap local sem heap: No such =
device
> or
> > > address".
> > > > >> The one million dollar question is, why the 3. parameter of =
ioctl() mutates
> to
> > > NULL. Any idea?
> > > > >>
> > > > >> If I can do anything else, let me know.
> > > > >>
> > > > >
> > > > > You will need these patches to run linux 2.4.25 over 2.5.6. =
The first
> > > > > one fixes the ioctl() issue.
> > > > > http://git.xenomai.org/?p=3Dxenomai-
> > > rpm.git;a=3Dcommit;h=3Dc2a24b90667e12d0614e5d8442dba74f137f9d4d
> > > > > http://git.xenomai.org/?p=3Dxenomai-
> > > rpm.git;a=3Dcommit;h=3Dbebc2a8e6b430c99041800330dc6061665371d90
> > > > >
> > > > > Note: the switch test does not seem to be running correctly on =
my
> > > > > icecube (albeit the latency one does), somehow linux =
reschedule events
> > > > > get lost. For this reason, I would not consider the current =
state as
> > > > > being production-grade.
> > > >
> > > > How do you see that reschedule events are lost?
> > >
> > > The pace of the supposedly 1sec periodic display stabilizes only =
when
> > > other processes run in the background and becomes erratic when the
> > > switch test is running alone, whilst the system does not seem to =
lose
> > > its idea of time. Additionally, signals do not seem to make their =
way to
> > > the shadows upon ^C. I did not track the issue in depth though, so =
at
> > > this stage I'm speculating.
> > >
> > > >  Does this happen also on
> > > > other systems?
> > > >
> > >
> > > Can't tell, I'm not using 2.5.x that much these days. I did not =
see any
> > > issue during the sh4 port, which seems to exclude 2.6.x from the
> > > potential victims.
> > >
> > > Guts feeling is that this might be specific to 2.4 kernels.
> > >
> > > --
> > > Philippe.
> > >
> > >
> >
> > --------------------------------------------------------
> > manroland AG
> > Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> > Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul
> Steidle
> > Sitz der Gesellschaft: Offenbach am Main, Registergericht: =
Amtsgericht
> Offenbach HRB-Nr. 42592
> > USt-Ident-Nr. DE 250200933
> >
>=20
> --
> Philippe.
>=20
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


