From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Thu, 11 Dec 2014 19:23:24 +0000
Message-ID: <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
References: <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
 <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
 <20141211144711.GD21808@hermes.click-hack.org>
 <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
 <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>,
 <20141211163807.GD27793@hermes.click-hack.org>
In-Reply-To: <20141211163807.GD27793@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> >> > Ok, maybe we have some hope with the tracer though. What should=0A=
>> >> > trigger a trace is the fact that a relax request has been sent, but=
=0A=
>> >> > that the next linux scheduling point does not wake up the said task=
.=0A=
>> >> > This is all debug code, so it does not need to be clean. You can=0A=
>> >> > define a per-cpu variable (if running on SMP systems, otherwise a=
=0A=
>> >> > global variable will do) with the last request posted. And when a=
=0A=
>> >> > linux scheduling happens, test that the newly scheduled task is the=
=0A=
>> >> > task that was passed to the relax, if that is not the case, trigger=
=0A=
>> >> > a trace freeze. The point where the nucleus is informed of a Linux=
=0A=
>> >> > task switch is do_schedule_event(). The trick is that if you have=
=0A=
>> >> > some tasks with a higher priority than the relaxed task, it is=0A=
>> >> > normal that the relaxed task is not scheduled immediately, so if yo=
u=0A=
>> >> > want the condition to hold, you need to run the xenomai tasks which=
=0A=
>> >> > relax with the highest priority. Also, obviously, after the test,=
=0A=
>> >> > the pointer should be reset to NULL, because there are several task=
=0A=
>> >> > queued, and with a global variable you have no way of knowing which=
=0A=
>> >> > is next.=0A=
>> >>=0A=
>> >> I will do so. Do I have to change the gatekeeper's priority behind th=
e relaxing=0A=
>> >> task to assure that the gatekeeper would be scheduled before?=0A=
>> >=0A=
>> > The gatekeeper is not involved.=0A=
>>=0A=
>> Sorry, I wanted to say: "that gatekeeper would NOT be scheduled before?"=
. Otherwise=0A=
>> we see possibly the gatekeeper instead of the relaxed task? Or am I wron=
g?=0A=
>=0A=
> I meant to say the gatekeeper is not involved in the primary to=0A=
> secondary mode switches, only in the secondary to primary mode=0A=
> switches. But yes, since it runs with the highest priority, it may=0A=
> be the one scheduled when back to primary mode. Though I would say=0A=
> it is probably very unlikely, since the events activating the=0A=
> gatekeeper is a secondary mode event, which by definition could not=0A=
> have happened while another task was in primary mode. So what could=0A=
> happen is that one task running in secondary mode tries to switch to=0A=
> primary mode, at which point, before the gatekeeper is even=0A=
> activated, another task running in primary mode is activated=0A=
> (perhaps because it is waiting for an interrupt, may it be atimer).=0A=
=0A=
I have added debug code as described by you. Unfortunately I am not sure=0A=
if I catch the correct point in time to trigger the trace. The problem is t=
hat=0A=
beside gatekeeper their are also some kernel interrupt tasks that have a=0A=
higher priority. =0A=
=0A=
Because of that and to understand whats happening here I have added=0A=
some other debug code. Thereby my goal was to verify if all requests=0A=
of schedule_linux_call() are processed by lostage_handler(). This is =0A=
realized as below:=0A=
=0A=
1) In schedule_linux_call() I check if it's the request for my highest prio=
 =0A=
task. If yes I keep the tasks's pointer in a global variable.=0A=
=0A=
2) In lostage_handler() before wake_up_process() call I check if the global=
 =0A=
pointer is equal to the current request. If true it's the wakeup for my=0A=
high prio task. In that case I keep that information by clearing the global=
=0A=
pointer with NULL.=0A=
=0A=
3) In do_schedule_event() I output some printk() message when the =0A=
global pointer is unequal to NULL.=0A=
=0A=
What I would expect now is to see no message from do_schedule_event(), =0A=
since lostage_handler() should be called before do_schedule_event().=0A=
However after some run-time I see the printk() message of do_schedule_event=
().=0A=
After that all tasks are freezed.=0A=
=0A=
Is my assumption from above wrong or is the outputted printk() message =0A=
the indication that the problem has occurred? =0A=
=0A=
For better understanding find my debug-changes below:=0A=
=0A=
*** tmp/xenomai-2.6.3/ksrc/nucleus/shadow.c     2013-08-20 13:14:38.0000000=
00 +0200=0A=
--- xenomai-2.6.3/ksrc/nucleus/shadow.c 2014-12-11 20:03:22.885493756 +0100=
=0A=
***************=0A=
*** 752,757 ****=0A=
--- 752,758 ----=0A=
        }=0A=
  }=0A=
  =0A=
+ static volatile struct task_struct *__last_requested_task =3D NULL;=0A=
  static void lostage_handler(void *cookie)=0A=
  {=0A=
        int cpu, reqnum, type, arg, sig, sigarg;=0A=
***************=0A=
*** 795,800 ****=0A=
--- 796,803 ----=0A=
  =0A=
                        /* fall through */=0A=
                case LO_START_REQ:=0A=
+                       if (__last_requested_task && p=3D=3D__last_requeste=
d_task)=0A=
+                               __last_requested_task =3D NULL;=0A=
                        wake_up_process(p);=0A=
                        break;=0A=
  =0A=
***************=0A=
*** 843,848 ****=0A=
--- 846,854 ----=0A=
        rq->req[reqnum].task =3D p;=0A=
        rq->req[reqnum].arg =3D arg;=0A=
  =0A=
+     if (strcmp(p->comm, "LApp") =3D=3D 0)=0A=
+               __last_requested_task =3D p;=0A=
+ =0A=
        __rthal_apc_schedule(lostage_apc);=0A=
  =0A=
        splexit(s);=0A=
***************=0A=
*** 2606,2611 ****=0A=
--- 2612,2623 ----=0A=
        if (!xnpod_active_p())=0A=
                return;=0A=
  =0A=
+       if (__last_requested_task)=0A=
+       {=0A=
+               printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D lostage_handler() was not called before!\n");=0A=
+               __last_requested_task =3D NULL;=0A=
+       }=0A=
+ =0A=
        prev_task =3D current;=0A=
        next =3D xnshadow_thread(next_task);=0A=
        set_switch_lock_owner(prev_task);=0A=
=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
=0A=
=0A=

