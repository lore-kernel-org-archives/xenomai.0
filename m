From: Lange Norbert <norbert.lange@andritz.com>
Subject: Still getting Deadlocks with condition variables
Date: Fri, 5 Jun 2020 14:36:39 +0000
Message-ID: <VI1PR05MB59177F9BC5CD74A181467003F6860@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I brought this up once or twice at this ML [1], I am still getting some occ=
asional lockups. Now the first time without running under an debugger,

Harwdare is a TQMxE39M (Goldmont Atom)
Kernel: 4.19.124-cip27-xeno12-static x86_64
I-pipe Version: 12
Xenomai Version: 3.1
Glibc Version 2.28

What happens (as far as I understand it):

The setup is an project with several cobalt threads (no "native" Linux thre=
ad as far as I can tell, apart maybe from the cobalt's printf thread).
They mostly sleep, and are triggered if work is available, the project also=
 can load DSOs (specialized maths) during configuration stage - during this=
 stages is when the exceptions occur


1.   Linux Thread LWP 682 calls SYS_futex "wake"

Code immediately before syscall, file x86_64/lowlevellock.S:
movl$0, (%rdi)
LOAD_FUTEX_WAKE (%esi)
movl$1, %edx/* Wake one thread.  */
movl$SYS_futex, %eax
syscall

2. Xenomai switches a cobalt thread to secondary, potentially because all t=
hreads are in primary:

Jun 05 12:35:19 buildroot kernel: [Xenomai] switching dispatcher to seconda=
ry mode after exception #14 from user-space at 0x7fd731299115 (pid 681)

Note that most threads are stuck waiting for a condvar in sc_cobalt_cond_wa=
it_prologue (cond.c:313), LWP 681 is at the next instruction.

3. Xenomai gets XCPU signal -> coredump

gdb) thread apply all bt 3

Thread 9 (LWP 682):
#0  __lll_unlock_wake () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.=
S:339
#1  0x00007fd731275d65 in __pthread_mutex_unlock_usercnt (mutex=3D0x7fd7312=
f6968 <_rtld_global+2312>, decr=3D1) at pthread_mutex_unlock.c:54
#2  0x00007fd7312e0442 in ?? () from /home/lano/Downloads/bugcrash/lib64/ld=
-linux-x86-64.so.2
#3  0x00007fd7312c72ac in ?? () from /lib/libdl.so.2
#4  0x00007fd73104211f in _dl_catch_exception () from /lib/libc.so.6
#5  0x00007fd731042190 in _dl_catch_error () from /lib/libc.so.6
#6  0x00007fd7312c7975 in ?? () from /lib/libdl.so.2
#7  0x00007fd7312c7327 in dlopen () from /lib/libdl.so.2
(More stack frames follow...)

Thread 8 (LWP 686):
#0  0x00007fd731298d48 in __cobalt_clock_nanosleep (clock_id=3D0, flags=3D0=
, rqtp=3D0x7fd727e3ad10, rmtp=3D0x0) at /opt/hipase2/src/xenomai-3.1.0/lib/=
cobalt/clock.c:312
#1  0x00007fd731298d81 in __cobalt_nanosleep (rqtp=3D<optimized out>, rmtp=
=3D<optimized out>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/clock.c:35=
4
#2  0x0000000000434590 in operator() (__closure=3D0x7fd720006fb8) at ../../=
acpu.runner/asim/asim_com.cpp:685
(More stack frames follow...)

Thread 7 (LWP 677):
#0  0x00007fd73127b6c6 in __GI___nanosleep (requested_time=3Drequested_time=
@entry=3D0x7fd7312b1fb0 <syncdelay>, remaining=3Dremaining@entry=3D0x0) at =
../sysdeps/unix/sysv/linux/nanosleep.c:28
#1  0x00007fd73129b746 in printer_loop (arg=3D<optimized out>) at /opt/hipa=
se2/src/xenomai-3.1.0/lib/cobalt/printf.c:635
#2  0x00007fd7312720f7 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:486
(More stack frames follow...)

Thread 6 (LWP 685):
#0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=3D0x7fd72f269660=
, mutex=3D0x7fd72f269630) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond=
.c:313
#1  0x000000000046377c in conditionvar_wait (pData=3D0x7fd72f269660, pMutex=
=3D0x7fd72f269630) at ../../alib/src/alib/posix/conditionvar.c:66
#2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (thi=
s=3D0x7fd72f269660, lock=3D...) at ../../alib/include/alib/alib_conditionva=
r_posix.h:67
(More stack frames follow...)

Thread 5 (LWP 684):
#0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=3D0x7fd72f267790=
, mutex=3D0x7fd72f267760) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond=
.c:313
#1  0x000000000046377c in conditionvar_wait (pData=3D0x7fd72f267790, pMutex=
=3D0x7fd72f267760) at ../../alib/src/alib/posix/conditionvar.c:66
#2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (thi=
s=3D0x7fd72f267790, lock=3D...) at ../../alib/include/alib/alib_conditionva=
r_posix.h:67
(More stack frames follow...)

Thread 4 (LWP 680):
#0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=3D0xfeafa0 <(ano=
nymous namespace)::m_MainTaskStart>, mutex=3D0xfeaf60 <(anonymous namespace=
)::m_TaskMutex>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:313
#1  0x000000000046377c in conditionvar_wait (pData=3D0xfeafa0 <(anonymous n=
amespace)::m_MainTaskStart>, pMutex=3D0xfeaf60 <(anonymous namespace)::m_Ta=
skMutex>) at ../../alib/src/alib/posix/conditionvar.c:66
#2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (thi=
s=3D0xfeafa0 <(anonymous namespace)::m_MainTaskStart>, lock=3D...) at ../..=
/alib/include/alib/alib_conditionvar_posix.h:67
(More stack frames follow...)

Thread 3 (LWP 683):
#0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=3D0x7fd72f2658c0=
, mutex=3D0x7fd72f265890) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond=
.c:313
#1  0x000000000046377c in conditionvar_wait (pData=3D0x7fd72f2658c0, pMutex=
=3D0x7fd72f265890) at ../../alib/src/alib/posix/conditionvar.c:66
#2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (thi=
s=3D0x7fd72f2658c0, lock=3D...) at ../../alib/include/alib/alib_conditionva=
r_posix.h:67
(More stack frames follow...)

Thread 2 (LWP 675):
#0  0x00007fd73129aea4 in __cobalt_pthread_mutex_lock (mutex=3D<optimized o=
ut>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/mutex.c:375
#1  0x000000000046390a in mutex_lock (pData=3D0xfeaf60 <(anonymous namespac=
e)::m_TaskMutex>) at ../../alib/src/alib/posix/mutex.c:33
#2  0x000000000040a530 in HIPASE::Posix::CAlib_Mutex::lock (this=3D0xfeaf60=
 <(anonymous namespace)::m_TaskMutex>) at ../../alib/include/alib/alib_mute=
x_posix.h:67
(More stack frames follow...)

Thread 1 (LWP 681):
#0  __cobalt_pthread_cond_wait (cond=3D0xfeafe0 <(anonymous namespace)::m_D=
ispatcherTaskStart>, mutex=3D0xfeaf60 <(anonymous namespace)::m_TaskMutex>)=
 at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:316
#1  0x000000000046377c in conditionvar_wait (pData=3D0xfeafe0 <(anonymous n=
amespace)::m_DispatcherTaskStart>, pMutex=3D0xfeaf60 <(anonymous namespace)=
::m_TaskMutex>) at ../../alib/src/alib/posix/conditionvar.c:66
#2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (thi=
s=3D0xfeafe0 <(anonymous namespace)::m_DispatcherTaskStart>, lock=3D...) at=
 ../../alib/include/alib/alib_conditionvar_posix.h:67
(More stack frames follow...)



[1] - https://xenomai.org/pipermail/xenomai/2020-January/042299.html


Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com
andritz.com

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

