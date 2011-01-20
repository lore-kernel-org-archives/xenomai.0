MIME-Version: 1.0
Message-ID: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
Date: Thu, 20 Jan 2011 09:03:58 +0100
From: Pierre.QUELIN@solystic.com
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF28DDFBA41D08f9e8a93df938690918c4EBBF28DDFBA41D0"
Content-Disposition: inline
Subject: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--0__=4EBBF28DDFBA41D08f9e8a93df938690918c4EBBF28DDFBA41D0
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=ISO-8859-1



Dear,

I am trying to debug a posix application and I noticed what I think is a
bug in the method pthread=5Fcond=5Fwait (). it returns EPERM when the
application is started with gdb.
Could you please help me to understand what is wrong or locate the bug?

Best regards.

Pierre Qu=E9lin

------------------------------------
Configuration
------------------------------------
Ubuntu 10.10
Linux xenomai 2.6.35.7-core2xeon-adeos-2.8-00 #1 SMP PREEMPT Mon Dec 6
13:37:41 CET 2010 i686 GNU/Linux

Gnu C 4.4.4-14ubuntu5)
GNU gdb (GDB) 7.2-ubuntu
Gnu make 3.81
util-linux ng 2.17.2)
mount ng 2.17.2 (with libblkid and selinux support)
module-init-tools 3.12
e2fsprogs 1.41.12
Linux C Library 2.12.1
Dynamic linker (ldd) 2.12.1
Procps 3.2.8
Net-tools 1.60
Kbd 1.15
Sh-utils 8.5
Modules Loaded ip6table=5Ffilter ip6=5Ftables binfmt=5Fmisc ipt=5FMASQUERADE
iptable=5Fnat nf=5Fnat nf=5Fconntrack=5Fipv4 nf=5Fdefrag=5Fipv4 xt=5Fstate =
nf=5Fconntrack
ipt=5FREJECT xt=5Ftcpudp iptable=5Ffilter ip=5Ftables x=5Ftables bridge stp=
 kvm=5Fintel
kvm parport=5Fpc ppdev arc4 rt73usb crc=5Fitu=5Ft rt2x00usb rt2x00lib led=
=5Fclass
i3200=5Fedac edac=5Fcore mac80211 lp psmouse serio=5Fraw cfg80211 parport h=
ed
floppy e1000 e1000e

------------------------------------
Code
------------------------------------
#include <sys/mman.h> /* line 0 */
#include <pthread.h>

void* bodyA(void*)
{
   pthread=5Fcond=5Ft cond;
   pthread=5Fmutex=5Ft mutex;
   pthread=5Fmutexattr=5Ft attr;
   int res;

   res =3D pthread=5Fmutexattr=5Finit( &attr );
   res =3D pthread=5Fmutexattr=5Fsetprotocol( &attr, PTHREAD=5FPRIO=5FINHER=
IT );
   res =3D pthread=5Fmutex=5Finit( &mutex, &attr );
   res =3D pthread=5Fmutexattr=5Fdestroy( &attr );
   res =3D pthread=5Fcond=5Finit( &cond, NULL );

   bool state =3D false;
   res =3D pthread=5Fmutex=5Flock( &mutex );
   while ( !state )
   {
      res =3D pthread=5Fcond=5Fwait( &cond, &mutex );
      if ( 0 !=3D res )
      {
         res =3D pthread=5Fmutex=5Funlock( &mutex );
         return (void*)-1;
      }
      else
      {
         (void)res;
      }
   }
   state =3D true;
   res =3D pthread=5Fmutex=5Funlock( &mutex );

   return 0;
};

void* bodyB(void*)
{
   pthread=5Fcond=5Ft cond;
   pthread=5Fmutex=5Ft mutex;
   pthread=5Fmutexattr=5Ft attr;
   int res;

   res =3D pthread=5Fmutexattr=5Finit( &attr );
   res =3D pthread=5Fmutexattr=5Fsetprotocol( &attr, PTHREAD=5FPRIO=5FINHER=
IT );
   res =3D pthread=5Fmutex=5Finit( &mutex, &attr );
   res =3D pthread=5Fmutexattr=5Fdestroy( &attr );
   res =3D pthread=5Fcond=5Finit( &cond, NULL );

   bool state =3D false;
   res =3D pthread=5Fmutex=5Flock( &mutex );
   while ( !state )
   {
      res =3D pthread=5Fcond=5Fwait( &cond, &mutex );
      if ( 0 !=3D res )
      {
         res =3D pthread=5Fmutex=5Funlock( &mutex );
         return (void*)-1;
      }
      else
      {
         (void)res;
      }
   }
   state =3D true;
   res =3D pthread=5Fmutex=5Funlock( &mutex );

   return 0;
};

#define DEFAULT=5FPRIORITY 100
#define HIGHEST=5FPRIORITY 2
#define LOWEST=5FPRIORITY 255

#define wind=5Fnormalized=5Fprio(prio, sched=5Ftype)  \
  ({ int =5F=5Fp =3D sched=5Fget=5Fpriority=5Fmin(sched=5Ftype) + ( ( ( LOW=
EST=5FPRIORITY -
(prio) ) * ( sched=5Fget=5Fpriority=5Fmax(sched=5Ftype) - sched=5Fget=5Fpri=
ority=5Fmin
(sched=5Ftype) ) ) / LOWEST=5FPRIORITY ); =5F=5Fp; })

int main()
{
   mlockall(MCL=5FCURRENT | MCL=5FFUTURE);

   struct sched=5Fparam parA;
   parA.sched=5Fpriority =3D wind=5Fnormalized=5Fprio(DEFAULT=5FPRIORITY,
SCHED=5FFIFO);
   pthread=5Ft threadA;
   pthread=5Fattr=5Ft pthread=5FattrA;
   int res;

   res =3D pthread=5Fattr=5Finit(&pthread=5FattrA);
   res =3D pthread=5Fattr=5Fsetinheritsched (&pthread=5FattrA,
PTHREAD=5FEXPLICIT=5FSCHED);
   res =3D pthread=5Fattr=5Fsetschedpolicy (&pthread=5FattrA, SCHED=5FFIFO);
   res =3D pthread=5Fattr=5Fsetschedparam( &pthread=5FattrA, &parA );
   res =3D pthread=5Fcreate( &threadA, &pthread=5FattrA, bodyA, NULL );
#ifdef =5F=5FXENO=5F=5F
   pthread=5Fset=5Fname=5Fnp( threadA, "threadA" );
#endif
   res =3D pthread=5Fattr=5Fdestroy( &pthread=5FattrA );



   struct sched=5Fparam parB;
   parB.sched=5Fpriority =3D wind=5Fnormalized=5Fprio(DEFAULT=5FPRIORITY,
SCHED=5FFIFO);
   pthread=5Ft threadB;
   pthread=5Fattr=5Ft pthread=5FattrB;

   res =3D pthread=5Fattr=5Finit(&pthread=5FattrB);
   res =3D pthread=5Fattr=5Fsetinheritsched (&pthread=5FattrB,
PTHREAD=5FEXPLICIT=5FSCHED);
   res =3D pthread=5Fattr=5Fsetschedpolicy (&pthread=5FattrB, SCHED=5FFIFO);
   pthread=5Fattr=5Fsetschedparam( &pthread=5FattrB, &parB );
   res =3D pthread=5Fcreate( &threadB, &pthread=5FattrB, bodyB, NULL );
#ifdef =5F=5FXENO=5F=5F
   pthread=5Fset=5Fname=5Fnp( threadB, "threadB" );
#endif
   res =3D pthread=5Fattr=5Fdestroy( &pthread=5FattrB );


   pthread=5Fcond=5Ft cond;
   pthread=5Fmutex=5Ft mutex;
   pthread=5Fmutexattr=5Ft attr;

   res =3D pthread=5Fmutexattr=5Finit( &attr );
   res =3D pthread=5Fmutexattr=5Fsetprotocol( &attr, PTHREAD=5FPRIO=5FINHER=
IT );
   res =3D pthread=5Fmutex=5Finit( &mutex, &attr );
   res =3D pthread=5Fmutexattr=5Fdestroy( &attr );
   res =3D pthread=5Fcond=5Finit( &cond, NULL );

   bool state =3D false;
   res =3D pthread=5Fmutex=5Flock( &mutex );
   while ( !state )
   {
      res =3D pthread=5Fcond=5Fwait( &cond, &mutex );
      if ( 0 !=3D res )
      {
         res =3D pthread=5Fmutex=5Funlock( &mutex );
         return -1;
      }
      else
      {
         (void)res;
      }
   }
   state =3D true;
   res =3D pthread=5Fmutex=5Funlock( &mutex );

   return 0;
}

------------------------------------
Linux without gdb : Ok
------------------------------------

------------------------------------
Linux with gdb : Ok
------------------------------------
Thread [3] 5111 (Suspended : Container)
=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
pthread=5Fcond=5Fwait@domain.hid()
at ../nptl/sysdeps/unix/sysv/linux/i386/i686/../i486/pthread=5Fcond=5Fwait.=
S:142
 0xb7fbd4ad
bodyB() at /home/generation/Projets/PosixTest/src/Main.cpp:55 0x8048af1
start=5Fthread() at pthread=5Fcreate.c:304 0xb7fb8cc9
clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7e1469e

Thread [2] 5110 (Suspended : Container)
=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
pthread=5Fcond=5Fwait@domain.hid()
at ../nptl/sysdeps/unix/sysv/linux/i386/i686/../i486/pthread=5Fcond=5Fwait.=
S:142
 0xb7fbd4ad
bodyA() at /home/generation/Projets/PosixTest/src/Main.cpp:21 0x8048a01
start=5Fthread() at pthread=5Fcreate.c:304 0xb7fb8cc9
clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7e1469e

Thread [1] 5106 (Suspended : Signal : SIGINT:Interrupt)
=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
pthread=5Fcond=5Fwait@domain.hid()
at ../nptl/sysdeps/unix/sysv/linux/i386/i686/../i486/pthread=5Fcond=5Fwait.=
S:142
 0xb7fbd4ad
main() at /home/generation/Projets/PosixTest/src/Main.cpp:131 0x8048dfa

------------------------------------
Xenomai without gdb : Ok
------------------------------------
generation@domain.hid$ cat /proc/xenomai/sched
CPU PID CLASS PRI TIMEOUT TIMEBASE STAT NAME
0 0 idle -1 - master R ROOT/0
1 0 idle -1 - master R ROOT/1
0 5025 rt 0 - master W PosixTest
0 5026 rt 60 - master W threadA
0 5027 rt 60 - master W threadB

------------------------------------
Xenomai with gdb : Nok
------------------------------------

->Step 1 : (break point on pthread=5Fcond=5Fwait)

Thread [2] 5193 (Suspended : Breakpoint)
bodyA() at /home/generation/Projets/PosixTest/src/Main.cpp:21 0x8048b0f
0xb7fc30b2
start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9
clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7df869e

Thread [1] 5188 (Suspended : Container)
=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
mmap() at ../sysdeps/unix/sysv/linux/i386/mmap.S:62 0xb7df4a88
allocate=5Fstack() at allocatestack.c:489 0xb7fa563b
=5F=5Fpthread=5Fcreate=5F2=5F1() at pthread=5Fcreate.c:458 0xb7fa563b
=5F=5Freal=5Fpthread=5Fcreate() at 0xb7fca382
=5F=5Fwrap=5Fpthread=5Fcreate() at 0xb7fc2e2f
main() at /home/generation/Projets/PosixTest/src/Main.cpp:110 0x8048e7e

->Step 2 : break point after pthread=5Fcond=5Fwait. pthread=5Fcond=5Fwait r=
etrun 1
(EPERM)

Thread [3] 5204 (Suspended : Container)
=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
=5F=5Flll=5Flock=5Fwait=5Fprivate()
at ../nptl/sysdeps/unix/sysv/linux/i386/i686/../i486/lowlevellock.S:95
0xb7fac133
=5FL=5Flock=5F2466() at 0xb7fa5d2a
start=5Fthread() at pthread=5Fcreate.c:295 0xb7fa4ec1
clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7df869e

Thread [2] 5193 (Suspended : Step)
bodyA() at /home/generation/Projets/PosixTest/src/Main.cpp:22 0x8048b24
0xb7fc30b2
start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9
clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7df869e

Thread [1] 5188 (Suspended : Container)

--0__=4EBBF28DDFBA41D08f9e8a93df938690918c4EBBF28DDFBA41D0
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline

<html><body><p>Dear,<br><br><font size=3D"4">I am trying to debug a posix a=
pplication and I noticed what I think is a bug in the method pthread=5Fcond=
=5Fwait (). it returns EPERM when the application is started with gdb.</fon=
t><br><font size=3D"4">Could you please help me to understand what is wrong=
 or locate the bug?</font><br><br>Best regards.<br><br>Pierre Qu=E9lin<br><=
br>------------------------------------<br>Configuration<br>---------------=
---------------------<br>Ubuntu 10.10<br>Linux xenomai 2.6.35.7-core2xeon-a=
deos-2.8-00 #1 SMP PREEMPT Mon Dec 6 13:37:41 CET 2010 i686 GNU/Linux<br><b=
r>Gnu C 4.4.4-14ubuntu5)<br>GNU gdb (GDB) 7.2-ubuntu<br>Gnu make 3.81<br>ut=
il-linux ng 2.17.2)<br>mount ng 2.17.2 (with libblkid and selinux support)<=
br>module-init-tools 3.12<br>e2fsprogs 1.41.12<br>Linux C Library 2.12.1<br=
>Dynamic linker (ldd) 2.12.1<br>Procps 3.2.8<br>Net-tools 1.60<br>Kbd 1.15<=
br>Sh-utils 8.5<br>Modules Loaded ip6table=5Ffilter ip6=5Ftables binfmt=5Fm=
isc ipt=5FMASQUERADE iptable=5Fnat nf=5Fnat nf=5Fconntrack=5Fipv4 nf=5Fdefr=
ag=5Fipv4 xt=5Fstate nf=5Fconntrack ipt=5FREJECT xt=5Ftcpudp iptable=5Ffilt=
er ip=5Ftables x=5Ftables bridge stp kvm=5Fintel kvm parport=5Fpc ppdev arc=
4 rt73usb crc=5Fitu=5Ft rt2x00usb rt2x00lib led=5Fclass i3200=5Fedac edac=
=5Fcore mac80211 lp psmouse serio=5Fraw cfg80211 parport hed floppy e1000 e=
1000e<br><br>------------------------------------<br>Code<br>--------------=
----------------------<br>#include &lt;sys/mman.h&gt; /* line 0 */<br>#incl=
ude &lt;pthread.h&gt;<br><br>void* bodyA(void*)<br>{<br>   pthread=5Fcond=
=5Ft cond;<br>   pthread=5Fmutex=5Ft mutex;<br>   pthread=5Fmutexattr=5Ft a=
ttr;<br>   int res;<br><br>   res =3D pthread=5Fmutexattr=5Finit( &amp;attr=
 );<br>   res =3D pthread=5Fmutexattr=5Fsetprotocol( &amp;attr, PTHREAD=5FP=
RIO=5FINHERIT );<br>   res =3D pthread=5Fmutex=5Finit( &amp;mutex, &amp;att=
r );<br>   res =3D pthread=5Fmutexattr=5Fdestroy( &amp;attr );<br>   res =
=3D pthread=5Fcond=5Finit( &amp;cond, NULL );<br><br>   bool state =3D fals=
e;<br>   res =3D pthread=5Fmutex=5Flock( &amp;mutex );<br>   while ( !state=
 )<br>   {<br>      res =3D pthread=5Fcond=5Fwait( &amp;cond, &amp;mutex );=
<br>      if ( 0 !=3D res )<br>      {<br>         res =3D pthread=5Fmutex=
=5Funlock( &amp;mutex );<br>         return (void*)-1;<br>      }<br>      =
else<br>      {<br>         (void)res;<br>      }<br>   }<br>   state =3D t=
rue;<br>   res =3D pthread=5Fmutex=5Funlock( &amp;mutex );<br><br>   return=
 0;<br>};<br><br>void* bodyB(void*)<br>{<br>   pthread=5Fcond=5Ft cond;<br>=
   pthread=5Fmutex=5Ft mutex;<br>   pthread=5Fmutexattr=5Ft attr;<br>   int=
 res;<br><br>   res =3D pthread=5Fmutexattr=5Finit( &amp;attr );<br>   res =
=3D pthread=5Fmutexattr=5Fsetprotocol( &amp;attr, PTHREAD=5FPRIO=5FINHERIT =
);<br>   res =3D pthread=5Fmutex=5Finit( &amp;mutex, &amp;attr );<br>   res=
 =3D pthread=5Fmutexattr=5Fdestroy( &amp;attr );<br>   res =3D pthread=5Fco=
nd=5Finit( &amp;cond, NULL );<br><br>   bool state =3D false;<br>   res =3D=
 pthread=5Fmutex=5Flock( &amp;mutex );<br>   while ( !state )<br>   {<br>  =
    res =3D pthread=5Fcond=5Fwait( &amp;cond, &amp;mutex );<br>      if ( 0=
 !=3D res )<br>      {<br>         res =3D pthread=5Fmutex=5Funlock( &amp;m=
utex );<br>         return (void*)-1;<br>      }<br>      else<br>      {<b=
r>         (void)res;<br>      }<br>   }<br>   state =3D true;<br>   res =
=3D pthread=5Fmutex=5Funlock( &amp;mutex );<br><br>   return 0;<br>};<br><b=
r>#define DEFAULT=5FPRIORITY 100<br>#define HIGHEST=5FPRIORITY 2<br>#define=
 LOWEST=5FPRIORITY 255<br><br>#define wind=5Fnormalized=5Fprio(prio, sched=
=5Ftype)  \<br>  ({ int =5F=5Fp =3D sched=5Fget=5Fpriority=5Fmin(sched=5Fty=
pe) + ( ( ( LOWEST=5FPRIORITY - (prio) ) * ( sched=5Fget=5Fpriority=5Fmax(s=
ched=5Ftype) - sched=5Fget=5Fpriority=5Fmin(sched=5Ftype) ) ) / LOWEST=5FPR=
IORITY ); =5F=5Fp; })<br><br>int main()<br>{<br>   mlockall(MCL=5FCURRENT |=
 MCL=5FFUTURE);<br><br>   struct sched=5Fparam parA;<br>   parA.sched=5Fpri=
ority =3D wind=5Fnormalized=5Fprio(DEFAULT=5FPRIORITY, SCHED=5FFIFO);<br>  =
 pthread=5Ft threadA;<br>   pthread=5Fattr=5Ft pthread=5FattrA;<br>   int r=
es;<br><br>   res =3D pthread=5Fattr=5Finit(&amp;pthread=5FattrA);<br>   re=
s =3D pthread=5Fattr=5Fsetinheritsched (&amp;pthread=5FattrA, PTHREAD=5FEXP=
LICIT=5FSCHED);<br>   res =3D pthread=5Fattr=5Fsetschedpolicy (&amp;pthread=
=5FattrA, SCHED=5FFIFO);<br>   res =3D pthread=5Fattr=5Fsetschedparam( &amp=
;pthread=5FattrA, &amp;parA );<br>   res =3D pthread=5Fcreate( &amp;threadA=
, &amp;pthread=5FattrA, bodyA, NULL );<br>#ifdef =5F=5FXENO=5F=5F<br>   pth=
read=5Fset=5Fname=5Fnp( threadA, &quot;threadA&quot; );<br>#endif<br>   res=
 =3D pthread=5Fattr=5Fdestroy( &amp;pthread=5FattrA );<br><br><br><br>   st=
ruct sched=5Fparam parB;<br>   parB.sched=5Fpriority =3D wind=5Fnormalized=
=5Fprio(DEFAULT=5FPRIORITY, SCHED=5FFIFO);<br>   pthread=5Ft threadB;<br>  =
 pthread=5Fattr=5Ft pthread=5FattrB;<br><br>   res =3D pthread=5Fattr=5Fini=
t(&amp;pthread=5FattrB);<br>   res =3D pthread=5Fattr=5Fsetinheritsched (&a=
mp;pthread=5FattrB, PTHREAD=5FEXPLICIT=5FSCHED);<br>   res =3D pthread=5Fat=
tr=5Fsetschedpolicy (&amp;pthread=5FattrB, SCHED=5FFIFO);<br>   pthread=5Fa=
ttr=5Fsetschedparam( &amp;pthread=5FattrB, &amp;parB );<br>   res =3D pthre=
ad=5Fcreate( &amp;threadB, &amp;pthread=5FattrB, bodyB, NULL );<br>#ifdef =
=5F=5FXENO=5F=5F<br>   pthread=5Fset=5Fname=5Fnp( threadB, &quot;threadB&qu=
ot; );<br>#endif<br>   res =3D pthread=5Fattr=5Fdestroy( &amp;pthread=5Fatt=
rB );<br><br><br>   pthread=5Fcond=5Ft cond;<br>   pthread=5Fmutex=5Ft mute=
x;<br>   pthread=5Fmutexattr=5Ft attr;<br><br>   res =3D pthread=5Fmutexatt=
r=5Finit( &amp;attr );<br>   res =3D pthread=5Fmutexattr=5Fsetprotocol( &am=
p;attr, PTHREAD=5FPRIO=5FINHERIT );<br>   res =3D pthread=5Fmutex=5Finit( &=
amp;mutex, &amp;attr );<br>   res =3D pthread=5Fmutexattr=5Fdestroy( &amp;a=
ttr );<br>   res =3D pthread=5Fcond=5Finit( &amp;cond, NULL );<br><br>   bo=
ol state =3D false;<br>   res =3D pthread=5Fmutex=5Flock( &amp;mutex );<br>=
   while ( !state )<br>   {<br>      res =3D pthread=5Fcond=5Fwait( &amp;co=
nd, &amp;mutex );<br>      if ( 0 !=3D res )<br>      {<br>         res =3D=
 pthread=5Fmutex=5Funlock( &amp;mutex );<br>         return -1;<br>      }<=
br>      else<br>      {<br>         (void)res;<br>      }<br>   }<br>   st=
ate =3D true;<br>   res =3D pthread=5Fmutex=5Funlock( &amp;mutex );<br><br>=
   return 0;<br>}<br><br>------------------------------------<br>Linux with=
out gdb : Ok<br>------------------------------------<br><br>---------------=
---------------------<br>Linux with gdb : Ok<br>---------------------------=
---------<br>Thread [3] 5111 (Suspended : Container) <br>=5F=5Fkernel=5Fvsy=
scall() at 0xb7fe1424 <br>pthread=5Fcond=5Fwait@domain.hid() at ../nptl=
/sysdeps/unix/sysv/linux/i386/i686/../i486/pthread=5Fcond=5Fwait.S:142 0xb7=
fbd4ad <br>bodyB() at /home/generation/Projets/PosixTest/src/Main.cpp:55 0x=
8048af1 <br>start=5Fthread() at pthread=5Fcreate.c:304 0xb7fb8cc9 <br>clone=
() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7e1469e <br><br>Thread=
 [2] 5110 (Suspended : Container) <br>=5F=5Fkernel=5Fvsyscall() at 0xb7fe14=
24 <br>pthread=5Fcond=5Fwait@domain.hid() at ../nptl/sysdeps/unix/sysv/=
linux/i386/i686/../i486/pthread=5Fcond=5Fwait.S:142 0xb7fbd4ad <br>bodyA() =
at /home/generation/Projets/PosixTest/src/Main.cpp:21 0x8048a01 <br>start=
=5Fthread() at pthread=5Fcreate.c:304 0xb7fb8cc9 <br>clone() at ../sysdeps/=
unix/sysv/linux/i386/clone.S:130 0xb7e1469e <br><br>Thread [1] 5106 (Suspen=
ded : Signal : SIGINT:Interrupt) <br>=5F=5Fkernel=5Fvsyscall() at 0xb7fe142=
4 <br>pthread=5Fcond=5Fwait@domain.hid() at ../nptl/sysdeps/unix/sysv/l=
inux/i386/i686/../i486/pthread=5Fcond=5Fwait.S:142 0xb7fbd4ad <br>main() at=
 /home/generation/Projets/PosixTest/src/Main.cpp:131 0x8048dfa <br><br>----=
--------------------------------<br>Xenomai without gdb : Ok<br>-----------=
-------------------------<br>generation@domain.hid=
$ cat /proc/xenomai/sched<br>CPU PID CLASS PRI TIMEOUT TIMEBASE STAT NAME<b=
r>0 0 idle -1 - master R ROOT/0<br>1 0 idle -1 - master R ROOT/1<br>0 5025 =
rt 0 - master W PosixTest<br>0 5026 rt 60 - master W threadA<br>0 5027 rt 6=
0 - master W threadB<br><br>------------------------------------<br>Xenomai=
 with gdb : Nok<br>------------------------------------<br><br>-&gt;Step 1 =
: (break point on pthread=5Fcond=5Fwait)<br><br>Thread [2] 5193 (Suspended =
: Breakpoint) <br>bodyA() at /home/generation/Projets/PosixTest/src/Main.cp=
p:21 0x8048b0f <br>0xb7fc30b2 <br>start=5Fthread() at pthread=5Fcreate.c:30=
4 0xb7fa4cc9 <br>clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb=
7df869e <br><br>Thread [1] 5188 (Suspended : Container) <br>=5F=5Fkernel=5F=
vsyscall() at 0xb7fe1424 <br>mmap() at ../sysdeps/unix/sysv/linux/i386/mmap=
.S:62 0xb7df4a88 <br>allocate=5Fstack() at allocatestack.c:489 0xb7fa563b <=
br>=5F=5Fpthread=5Fcreate=5F2=5F1() at pthread=5Fcreate.c:458 0xb7fa563b <b=
r>=5F=5Freal=5Fpthread=5Fcreate() at 0xb7fca382 <br>=5F=5Fwrap=5Fpthread=5F=
create() at 0xb7fc2e2f <br>main() at /home/generation/Projets/PosixTest/src=
/Main.cpp:110 0x8048e7e <br><br>-&gt;Step 2 : break point after pthread=5Fc=
ond=5Fwait. pthread=5Fcond=5Fwait retrun 1 (EPERM)<br><br>Thread [3] 5204 (=
Suspended : Container) <br>=5F=5Fkernel=5Fvsyscall() at 0xb7fe1424 <br>=5F=
=5Flll=5Flock=5Fwait=5Fprivate() at ../nptl/sysdeps/unix/sysv/linux/i386/i6=
86/../i486/lowlevellock.S:95 0xb7fac133 <br>=5FL=5Flock=5F2466() at 0xb7fa5=
d2a <br>start=5Fthread() at pthread=5Fcreate.c:295 0xb7fa4ec1 <br>clone() a=
t ../sysdeps/unix/sysv/linux/i386/clone.S:130 0xb7df869e <br><br>Thread [2]=
 5193 (Suspended : Step) <br>bodyA() at /home/generation/Projets/PosixTest/=
src/Main.cpp:22 0x8048b24 <br>0xb7fc30b2 <br>start=5Fthread() at pthread=5F=
create.c:304 0xb7fa4cc9 <br>clone() at ../sysdeps/unix/sysv/linux/i386/clon=
e.S:130 0xb7df869e <br><br>Thread [1] 5188 (Suspended : Container) <BR>
</body></html>

--0__=4EBBF28DDFBA41D08f9e8a93df938690918c4EBBF28DDFBA41D0--


