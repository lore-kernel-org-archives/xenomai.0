Message-ID: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
Date: Fri, 2 Feb 2007 09:43:15 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
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

Hi everybody,

I have a strange issue frequently when reading /proc/xenomai/stat.
I do a cat /proc/xenomai/stat and I get an "Cannot allocate memory" error.
This happens typcially after I have started and terminated by application t=
hat uses a number of tasks.
I am able to reproduce it deterministically...
While the application is running, I can see the stat values perfectly.
Here is the head output of all /proc/xenomai/* files:

=3D=3D> affinity <=3D=3D
00000002

=3D=3D> apc <=3D=3D
APC          CPU0         CPU1
  0:            0           0    (pipe_wakeup)
  1:           49          54    (lostage_handler)
  2:           12          23    (registry_export)

=3D=3D> faults <=3D=3D
TRAP         CPU0        CPU1
  0:            0           0    (Divide error)
  1:            0           0    (Debug)
  3:            0           0    (Int3)
  4:            0           0    (Overflow)
  5:            0           0    (Bounds)
  6:            0           0    (Invalid opcode)
  7:            0           0    (FPU not available)
  8:            0           0    (Double fault)
  9:            0           0    (FPU segment overrun)
 10:            0           0    (Invalid TSS)
 11:            0           0    (Segment not present)
 12:            0           0    (Stack segment)
 13:            0           0    (General protection)
 14:            0           0    (Page fault)
 15:            0           0    (Spurious interrupt)
 16:            0           0    (FPU error)
 17:            0           0    (Alignment check)
 18:            0           0    (Machine check)
 19:            0           0    (SIMD error)

=3D=3D> hal <=3D=3D
1.6-03

=3D=3D> heap <=3D=3D
size=3D130560:used=3D168:pagesz=3D512

=3D=3D> interfaces <=3D=3D
head: error reading `interfaces': Is a directory

=3D=3D> irq <=3D=3D
IRQ         CPU0        CPU1
213:           0          13
216:      387539      236720         [timer]
217:           0           0
226:         112         137         [virtual]

=3D=3D> latency <=3D=3D
2699

=3D=3D> registry <=3D=3D
head: error reading `registry': Is a directory

=3D=3D> rtdm <=3D=3D
head: error reading `rtdm': Is a directory

=3D=3D> sched <=3D=3D
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
head: cannot open `stat' for reading: Cannot allocate memory

=3D=3D> timer <=3D=3D
status=3Doneshot:setup=3D120:tickval=3D1:jiffies=3D442215696848

=3D=3D> version <=3D=3D
2.3


I am using Xenomai 2.3.0 with some additional COW patches. Kernel 2.6.19.1 =
SMP.
Xenomai is directly integrated in the kernel,  not a module.

Thanks for any feedback on that

Mathias



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

