References: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B9BC6A.9070501@xenomai.org>
 <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53BD10C2.60109@xenomai.org>
 <1404942153.53492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BE5DC6.9040406@xenomai.org>
Message-ID: <1405012399.63072.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Thu, 10 Jul 2014 18:13:19 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53BE5DC6.9040406@xenomai.org>
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

=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xeno=
mai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai=
.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Thursday, July 10, 2014 11:3=
2 AM=0A> Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()=0A> =0A> O=
n 07/09/2014 11:42 PM, Matthias Schneider wrote:=0A>>  ----- Original Messa=
ge -----=0A>> =0A>>>  From: Philippe Gerum <rpm@xenomai.org>=0A>>>  To: Mat=
thias Schneider <ma30002000@yahoo.de>; =0A> "xenomai@xenomai.org" <xenomai@=
xenomai.org>=0A>>>  Cc:=0A>>>  Sent: Wednesday, July 9, 2014 11:52 AM=0A>>>=
  Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()=0A>>> =0A>>>  On =
07/08/2014 06:10 PM, Matthias Schneider wrote:=0A>>>> =A0  ----- Original M=
essage -----=0A>>>> =0A>>>>> =A0  From: Philippe Gerum <rpm@xenomai.org>=0A=
>>>>> =A0  To: Matthias Schneider <ma30002000@yahoo.de>;=0A>>>  "xenomai@xe=
nomai.org" <xenomai@xenomai.org>=0A>>>>> =A0  Cc:=0A>>>>> =A0  Sent: Sunday=
, July 6, 2014 11:15 PM=0A>>>>> =A0  Subject: Re: [Xenomai] Issue with coba=
lt_monitor_wait()=0A>>>>> =0A>>>>> =A0  On 07/06/2014 10:16 PM, Matthias Sc=
hneider wrote:=0A>>>>> =0A>>>>> =A0  [snip]=0A>>>>> =0A>>>>>> =A0 =A0  On t=
hing I do not understand is:=0A>>>>>> =0A>>>>>> =A0 =A0  in kernel cobalt_m=
onitor_wait(), the synch object is =0A> unlocked via=0A>>>>>> =A0 =A0  xnsy=
nch_release(). What happens if this synchobj was =0A> locked via=0A>>>>>> =
=A0 =A0  mon->gate.fastlock ? Shouldnt that also be released?=0A>>>>>> =0A>=
>>>> =0A>>>>> =A0  xnsynch_release() handles fastlocks as well.=0A>>>>> =0A=
>>>>> =0A>>>>>> =A0 =A0  What other reason could there be if the synch obje=
ct =0A> was released=0A>>>>>> =A0 =A0  via xnsynch_release, xnsynch_acquire=
 was interrupted =0A> for=0A>>>>>> =A0 =A0  xnsynch_release to block?=0A>>>=
>>> =0A>>>>> =0A>>>>> =A0  Since the issue seems to be easily reproducible,=
 could you =0A> send a=0A>>>>> =A0  self-contained piece of code illustrati=
ng it?=0A>>>>> =0A>>>>> =A0  Also, please mention if you are seeing this is=
sue only when =0A> running=0A>>>  your=0A>>>>> =A0  app over GDB, or if it =
currently happens without any debugger =0A> attached.=0A>>>>> =0A>>>>> =A0 =
 TIA,=0A>>>> =0A>>>> =0A>>>> =A0  It seems I have not described the problem=
atic scenario completely =0A> -=0A>>>> =0A>>>> =A0  there were two other th=
reads that call called syncobj_lock()=0A>>>> =A0  / cobalt_monitor_enter() =
at about the same time. (Actually there=0A>>>> =A0  are three concurrent on=
 the queue that is being tested, two =0A> receive=0A>>>> =A0  operation and=
 one send operation). I am pretty sure that the =0A> issue is=0A>>>> =A0  e=
xtremely timing dependent.=0A>>>> =0A>>>> =A0  Anyway, the testcase would b=
e=0A>>>> =0A>>>> =A0  queue_test_receive_peek_multiple_tasks()=0A>>>> =0A>>=
> =0A>>>  I could not reproduce the issue yet, but could you check if this =
patch=0A>>>  has any influence on this bug? TIA,=0A>>> =0A>>>  diff --git a=
/kernel/cobalt/posix/syscall.c =0A> b/kernel/cobalt/posix/syscall.c=0A>>>  =
index d921d81..3856794 100644=0A>>>  --- a/kernel/cobalt/posix/syscall.c=0A=
>>>  +++ b/kernel/cobalt/posix/syscall.c=0A>>>  @@ -156,7 +156,7 @@ static =
struct xnsyscall cobalt_syscalls[] =3D {=0A>>> =A0 =A0 =A0 =A0 SKINCALL_DEF=
(sc_cobalt_monitor_enter, cobalt_monitor_enter, =0A> primary),=0A>>> =A0 =
=A0 =A0 =A0 SKINCALL_DEF(sc_cobalt_monitor_wait, cobalt_monitor_wait,=0A>>>=
  nonrestartable),=0A>>> =A0 =A0 =A0 =A0 SKINCALL_DEF(sc_cobalt_monitor_syn=
c, cobalt_monitor_sync,=0A>>>  nonrestartable),=0A>>>  -=A0 =A0 SKINCALL_DE=
F(sc_cobalt_monitor_exit, cobalt_monitor_exit, =0A> primary),=0A>>>  +=A0 =
=A0 SKINCALL_DEF(sc_cobalt_monitor_exit, cobalt_monitor_exit, =0A> nonresta=
rtable),=0A>>> =A0 =A0 =A0 =A0 SKINCALL_DEF(sc_cobalt_event_init, cobalt_ev=
ent_init, current),=0A>>> =A0 =A0 =A0 =A0 SKINCALL_DEF(sc_cobalt_event_dest=
roy, cobalt_event_destroy, =0A> current),=0A>>> =A0 =A0 =A0 =A0 SKINCALL_DE=
F(sc_cobalt_event_wait, cobalt_event_wait, primary),=0A>>>  diff --git a/li=
b/cobalt/internal.c b/lib/cobalt/internal.c=0A>>>  index e0d990d..6c1331d 1=
00644=0A>>>  --- a/lib/cobalt/internal.c=0A>>>  +++ b/lib/cobalt/internal.c=
=0A>>>  @@ -230,6 +230,7 @@ int cobalt_monitor_exit(cobalt_monitor_t *mon)=
=0A>>> =A0 =A0 =A0 =A0 struct cobalt_monitor_data *datp;=0A>>> =A0 =A0 =A0 =
=A0 unsigned long status;=0A>>> =A0 =A0 =A0 =A0 xnhandle_t cur;=0A>>>  +=A0=
 =A0 int ret;=0A>>> =0A>>> =A0 =A0 =A0 =A0 __sync_synchronize();=0A>>> =0A>=
>>  @@ -246,9 +247,13 @@ int cobalt_monitor_exit(cobalt_monitor_t *mon)=0A>=
>> =A0 =A0 =A0 =A0 if (xnsynch_fast_release(&datp->owner, cur))=0A>>> =A0 =
=A0 =A0 =A0 =A0 =A0 return 0;=0A>>> =A0 =A0 syscall:=0A>>>  -=A0 =A0 return=
 XENOMAI_SKINCALL1(__cobalt_muxid,=0A>>>  -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
 sc_cobalt_monitor_exit,=0A>>>  -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  mon);=0A>=
>>  +=A0 =A0 do=0A>>>  +=A0 =A0 =A0 =A0 ret =3D XENOMAI_SKINCALL1(__cobalt_=
muxid,=0A>>>  +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sc_cobalt_monitor_ex=
it,=0A>>>  +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mon);=0A>>>  +=A0 =A0 w=
hile (ret =3D=3D -EINTR);=0A>>>  +=0A>>>  +=A0 =A0 return ret;=0A>>> =A0 =
=A0 }=0A>>> =0A>>> =A0 =A0 int cobalt_monitor_wait(cobalt_monitor_t *mon, i=
nt event,=0A>>> =0A>> =0A>> =0A>>  Hm, it seems when I run into the issue, =
cobalt_monitor_exit() isnt=0A>>  called at all...=0A>> =0A>>  Having compil=
ed the cobalt kernel without optimization,=0A>>  I noticed that cobalt_moni=
tor_wait() actually sets u_ret =3D -EINTR and=0A>>  apparently cobalt_monit=
or_enter_inner() seems to work, thus setting ret=0A>>  to 0. However, in in=
ternal.c:cobalt_monitor_wait (in user mode),=0A>> =A0  both ret and opret s=
eem to be set to -EINTR. This would explain that=0A>>  the second call of i=
nternal.c:cobalt_monitor_wait to cobalt_monitor_enter=0A>>  will block inde=
finitely since the sync object is already locked.=0A>> =0A>>  Investigating=
 what else happens on the way back to user mode, it seems=0A>>  that the re=
turn code is changed from 0 to -EINTR by the following stack:=0A>> =0A>>  #=
0=A0 __xn_error_return (regs=3D0xde0fffb0, v=3D-4) at =0A> arch/arm/xenomai=
/include/asm/xenomai/syscall.h:62=0A>>  #1=A0 prepare_for_signal (p=3D<opti=
mized out>, =0A> thread=3Dthread@entry=3D0xde702e08, regs=3Dregs@entry=3D0x=
de0fffb0, =0A> sysflags=3Dsysflags@entry=3D134) at kernel/xenomai/shadow.c:=
1842=0A>>  #2=A0 0xc00c68a8 in handle_head_syscall (regs=3D0xde0fffb0, ipd=
=3D0xc07d63c0 =0A> <xnarch_machdata>) at kernel/xenomai/shadow.c:1996=0A>> =
 #3=A0 ipipe_syscall_hook (ipd=3D0xc07d63c0 <xnarch_machdata>, =0A> regs=3D=
0xde0fffb0) at kernel/xenomai/shadow.c:2164=0A>>  #4=A0 0xc00959a8 in __ipi=
pe_notify_syscall (regs=3Dregs@entry=3D0xde0fffb0) at =0A> kernel/ipipe/cor=
e.c:982=0A>>  #5=A0 0xc0015c90 in __ipipe_syscall_root (scno=3D<optimized o=
ut>, =0A> regs=3D0xde0fffb0) at arch/arm/kernel/ipipe.c:417=0A>> =0A>>  App=
erently, the assumption of internal.c:cobalt_monitor_wait that a=0A>>  sysc=
all return -EINTR indicates a failure to re-lock the sync object=0A>>  does=
 not hold in this case. There are probably other cases where=0A>>  the same=
 scenario may occur=0A>> =0A>>  Unfortunately I do not yet know how to reso=
lve this issue...=0A>> =0A> =0A> Actually, you did it. Thanks for the analy=
sis. As you mentioned, the basic issue =0A> is with relocking the monitor g=
ate upon EINTR, which is wrong: there must be a =0A> reason why we do this =
from userland...=0A> The reason is with any blocking Cobalt syscall which m=
ust be aborted upon Linux =0A> signal receipt, which causes XNBREAK to be p=
resent in the thread state flags =0A> (handle_sigwake_event -> __xnshadow_k=
ick()). And we must not hold the gate =0A> lock until the signal handler ha=
s run.=0A> =0A> When a signal hits the sleeping syscall, we must unwind the=
 context all way down =0A> the regular Linux syscall path, so that a signal=
 frame is built for it. As part =0A> of this process, prepare_for_signal() =
switches the signaled context from primary =0A> to secondary mode.=0A> =0A>=
 In short, receiving EINTR in kernel space waiting for a monitor means unwi=
nding =0A> back to the userland call site first, keeping the monitor gate f=
ree while =0A> running the handler, then grabbing the gate lock anew prior =
to returning to the =0A> caller.=0A> =0A> Unblocking a thread forcibly can =
also happen when the latter receives the =0A> internal/special/not-so-hidde=
n SIGRELS notification (see __cobalt_kill()), in =0A> which case XNBREAK is=
 raised too. In such a case, we will relock from userland =0A> the same way=
.=0A> =0A> I need to review the entire machinery for more non-sense of mine=
, but in the =0A> meantime, could you try this patch?=0A> =0A> TIA,=0A> =0A=
> diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.=
c=0A> index 0ecaa6a..a61d028 100644=0A> --- a/kernel/cobalt/posix/monitor.c=
=0A> +++ b/kernel/cobalt/posix/monitor.c=0A> @@ -283,9 +283,11 @@ int cobal=
t_monitor_wait(struct cobalt_monitor_shadow __user =0A> *u_mon,=0A> =A0=A0=
=A0 =A0=A0=A0 if (list_empty(&mon->waiters) && =0A> !xnsynch_pended_p(&mon-=
>drain))=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 datp->flags &=3D ~COBALT_MONITOR=
_PENDED;=0A> =0A> -=A0=A0=A0 =A0=A0=A0 if (info & XNBREAK)=0A> +=A0=A0=A0 =
=A0=A0=A0 if (info & XNBREAK) {=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 opret =3D=
 -EINTR;=0A> -=A0=A0=A0 =A0=A0=A0 else if (info & XNTIMEO)=0A> +=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 goto out;=0A> +=A0=A0=A0 =A0=A0=A0 }=0A> +=A0=A0=A0 =A0=
=A0=A0 if (info & XNTIMEO)=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 opret =3D -ETI=
MEDOUT;=0A> =0A> =A0=A0=A0 }=0A> =0A> -- =0A> Philippe.=0A> =0A=0AThanks, c=
urrent forge/next including the above patch finally passes the test on=0Amy=
 setup. However I seem to be unable to determine which signal actually inte=
rrupts=0Athe syscall. debugging all signals with gdb does not show a single=
 occurance...=0A=0AMatthias=0A

