References: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B9BC6A.9070501@xenomai.org>
 <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53BD10C2.60109@xenomai.org>
Message-ID: <1404942153.53492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Wed, 9 Jul 2014 22:42:33 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53BD10C2.60109@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Wednesday, July 9, 2014 11:52 AM=0A>=
 Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()=0A> =0A> On 07/08/=
2014 06:10 PM, Matthias Schneider wrote:=0A>>  ----- Original Message -----=
=0A>> =0A>>>  From: Philippe Gerum <rpm@xenomai.org>=0A>>>  To: Matthias Sc=
hneider <ma30002000@yahoo.de>; =0A> "xenomai@xenomai.org" <xenomai@xenomai.=
org>=0A>>>  Cc:=0A>>>  Sent: Sunday, July 6, 2014 11:15 PM=0A>>>  Subject: =
Re: [Xenomai] Issue with cobalt_monitor_wait()=0A>>> =0A>>>  On 07/06/2014 =
10:16 PM, Matthias Schneider wrote:=0A>>> =0A>>>  [snip]=0A>>> =0A>>>> =A0 =
 On thing I do not understand is:=0A>>>> =0A>>>> =A0  in kernel cobalt_moni=
tor_wait(), the synch object is unlocked via=0A>>>> =A0  xnsynch_release().=
 What happens if this synchobj was locked via=0A>>>> =A0  mon->gate.fastloc=
k ? Shouldnt that also be released?=0A>>>> =0A>>> =0A>>>  xnsynch_release()=
 handles fastlocks as well.=0A>>> =0A>>> =0A>>>> =A0  What other reason cou=
ld there be if the synch object was released=0A>>>> =A0  via xnsynch_releas=
e, xnsynch_acquire was interrupted for=0A>>>> =A0  xnsynch_release to block=
?=0A>>>> =0A>>> =0A>>>  Since the issue seems to be easily reproducible, co=
uld you send a=0A>>>  self-contained piece of code illustrating it?=0A>>> =
=0A>>>  Also, please mention if you are seeing this issue only when running=
 =0A> your=0A>>>  app over GDB, or if it currently happens without any debu=
gger attached.=0A>>> =0A>>>  TIA,=0A>> =0A>> =0A>>  It seems I have not des=
cribed the problematic scenario completely -=0A>> =0A>>  there were two oth=
er threads that call called syncobj_lock()=0A>>  / cobalt_monitor_enter() a=
t about the same time. (Actually there=0A>>  are three concurrent on the qu=
eue that is being tested, two receive=0A>>  operation and one send operatio=
n). I am pretty sure that the issue is=0A>>  extremely timing dependent.=0A=
>> =0A>>  Anyway, the testcase would be=0A>> =0A>>  queue_test_receive_peek=
_multiple_tasks()=0A>> =0A> =0A> I could not reproduce the issue yet, but c=
ould you check if this patch =0A> has any influence on this bug? TIA,=0A> =
=0A> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/sysca=
ll.c=0A> index d921d81..3856794 100644=0A> --- a/kernel/cobalt/posix/syscal=
l.c=0A> +++ b/kernel/cobalt/posix/syscall.c=0A> @@ -156,7 +156,7 @@ static =
struct xnsyscall cobalt_syscalls[] =3D {=0A> =A0 =A0=A0=A0 SKINCALL_DEF(sc_=
cobalt_monitor_enter, cobalt_monitor_enter, primary),=0A> =A0 =A0=A0=A0 SKI=
NCALL_DEF(sc_cobalt_monitor_wait, cobalt_monitor_wait, =0A> nonrestartable)=
,=0A> =A0 =A0=A0=A0 SKINCALL_DEF(sc_cobalt_monitor_sync, cobalt_monitor_syn=
c, =0A> nonrestartable),=0A> -=A0=A0=A0 SKINCALL_DEF(sc_cobalt_monitor_exit=
, cobalt_monitor_exit, primary),=0A> +=A0=A0=A0 SKINCALL_DEF(sc_cobalt_moni=
tor_exit, cobalt_monitor_exit, nonrestartable),=0A> =A0 =A0=A0=A0 SKINCALL_=
DEF(sc_cobalt_event_init, cobalt_event_init, current),=0A> =A0 =A0=A0=A0 SK=
INCALL_DEF(sc_cobalt_event_destroy, cobalt_event_destroy, current),=0A> =A0=
 =A0=A0=A0 SKINCALL_DEF(sc_cobalt_event_wait, cobalt_event_wait, primary),=
=0A> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c=0A> index e=
0d990d..6c1331d 100644=0A> --- a/lib/cobalt/internal.c=0A> +++ b/lib/cobalt=
/internal.c=0A> @@ -230,6 +230,7 @@ int cobalt_monitor_exit(cobalt_monitor_=
t *mon)=0A> =A0 =A0=A0=A0 struct cobalt_monitor_data *datp;=0A> =A0 =A0=A0=
=A0 unsigned long status;=0A> =A0 =A0=A0=A0 xnhandle_t cur;=0A> +=A0=A0=A0 =
int ret;=0A> =0A> =A0 =A0=A0=A0 __sync_synchronize();=0A> =0A> @@ -246,9 +2=
47,13 @@ int cobalt_monitor_exit(cobalt_monitor_t *mon)=0A> =A0 =A0=A0=A0 i=
f (xnsynch_fast_release(&datp->owner, cur))=0A> =A0 =A0=A0=A0 =A0=A0=A0 ret=
urn 0;=0A> =A0 syscall:=0A> -=A0=A0=A0 return XENOMAI_SKINCALL1(__cobalt_mu=
xid,=0A> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0  sc_cobalt_monitor_exit,=
=0A> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0  mon);=0A> +=A0=A0=A0 do=0A> =
+=A0=A0=A0 =A0=A0=A0 ret =3D XENOMAI_SKINCALL1(__cobalt_muxid,=0A> +=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 sc_cobalt_monitor_exit,=0A> +=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mon);=0A> +=A0=A0=A0 whil=
e (ret =3D=3D -EINTR);=0A> +=0A> +=A0=A0=A0 return ret;=0A> =A0 }=0A> =0A> =
=A0 int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,=0A> =0A=0A=0A=
Hm, it seems when I run into the issue, cobalt_monitor_exit() isnt=A0=0Acal=
led at all...=A0=0A=0AHaving compiled the cobalt kernel without optimizatio=
n,=0AI noticed that cobalt_monitor_wait() actually sets u_ret =3D -EINTR an=
d=0Aapparently cobalt_monitor_enter_inner() seems to work, thus setting ret=
=0Ato 0. However, in internal.c:cobalt_monitor_wait (in user mode),=0A=A0bo=
th ret and opret seem=A0to be set to -EINTR. This=A0would explain that=0Ath=
e second call of internal.c:cobalt_monitor_wait=A0to cobalt_monitor_enter=
=A0=0Awill block indefinitely since the sync object is=A0already locked.=A0=
=0A=0AInvestigating what else happens on the way back to user mode, it seem=
s=A0=0Athat the return code is changed from 0 to -EINTR by the following st=
ack:=0A=0A#0  __xn_error_return (regs=3D0xde0fffb0, v=3D-4) at arch/arm/xen=
omai/include/asm/xenomai/syscall.h:62=0A#1  prepare_for_signal (p=3D<optimi=
zed out>, thread=3Dthread@entry=3D0xde702e08, regs=3Dregs@entry=3D0xde0fffb=
0, sysflags=3Dsysflags@entry=3D134) at kernel/xenomai/shadow.c:1842=0A#2  0=
xc00c68a8 in handle_head_syscall (regs=3D0xde0fffb0, ipd=3D0xc07d63c0 <xnar=
ch_machdata>) at kernel/xenomai/shadow.c:1996=0A#3  ipipe_syscall_hook (ipd=
=3D0xc07d63c0 <xnarch_machdata>, regs=3D0xde0fffb0) at kernel/xenomai/shado=
w.c:2164=0A#4  0xc00959a8 in __ipipe_notify_syscall (regs=3Dregs@entry=3D0x=
de0fffb0) at kernel/ipipe/core.c:982=0A#5  0xc0015c90 in __ipipe_syscall_ro=
ot (scno=3D<optimized out>, regs=3D0xde0fffb0) at arch/arm/kernel/ipipe.c:4=
17=0A=0AApperently, the assumption of internal.c:cobalt_monitor_wait that a=
=0Asyscall return -EINTR indicates a failure to re-lock the sync object=0Ad=
oes not hold in this case. There are probably other cases where=0Athe same =
scenario may occur=0A=0AUnfortunately I do not yet know how to resolve this=
 issue...=0A=0ARegards,=0AMatthias

