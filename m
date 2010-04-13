From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BB5D4FB.4010901@domain.hid>
References: <4B97BA0C.9000702@domain.hid>  <4B9AD0DE.4020103@domain.hid>
	<1268472523.27899.135.camel@domain.hid>
	<4B9BB9B1.5050003@domain.hid>
	<1268498034.27899.167.camel@domain.hid>
	<4B9C2100.6090806@domain.hid>
	<1268584465.27899.197.camel@domain.hid>
	<4BB4F857.5020906@domain.hid>  <4BB50C8B.2000405@domain.hid>
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid>
	<4BB523E8.705@domain.hid> <4BB5250F.1040409@domain.hid>
	<4BB52769.4080702@domain.hid> <4BB5348B.2070805@domain.hid>
	<4BB5C95E.9060502@domain.hid> <4BB5D0D4.40908@domain.hid>
	<4BB5D1A0.8030007@domain.hid>  <4BB5D4FB.4010901@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 22:41:11 +0200
Message-ID: <1271191271.2365.436.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2010-04-02 at 13:28 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Redirecting to xenomai core.
> >>>
> >>> Jan Kiszka wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Because of __xn_exec_current, people have broken drivers, and user-space
> >>>>> applications using T_PRIMARY as a broken way to workaround these broken
> >>>>> drivers, and by maintaining compatibility, we let them keep their broken
> >>>>> drivers and applications, by changing to the more natural
> >>>>> __xn_exec_conforming and removing T_PRIMARY, we ask them to fix their
> >>>>> drivers and applications.
> >>>> Right goal, wrong approach for the reason I pointed out to Philippe:
> >>>>
> >>>> We cannot map all kinds of driver requirements on a single
> >>>> __xn_exec_current in the RTDM middle layer.
> >>> What requirement can we not handle? It looks to me like with
> >>> __xn_exec_conforming, we can handle any requirement.
> >>>
> >>> The only problem being the "double context switch" issue. But as
> >>> Philippe said, a sane application is calling such ioctls from non
> >>> critical code, so this is in fact a non-issue.
> >> And this is one of the restrictions I don't want to keep for upcoming
> >> versions. Think of a POSIX app that creates threads, even non-RT ones.
> >> Those are automatically shadowed. If those threads perform lots of
> >> non-RT service requests on RTDM drivers, they will suffer.
> > 
> > If those threads perform lots of non-RT service requests on RTDM drivers
> > at a non critical time, then no problem.
> 
> That's is a needless regression as we now do decisions in the wrong
> layer without sufficient knowledge about the case. RTDM is just a
> support layer for the driver, the logic sits in the latter.

You can't regress that much from a wrong situation. It is incorrect
already, and this is definitely much more important than a corner case.
As we all agreed, this is an issue that makes a number of people think
they should or even _have to_ control the current domain their threads
are running in. This leads to a fundamental misunderstanding about: 1)
how to write efficient apps, 2) how to write sane drivers.

This said, I agree that making RTDM syscalls conforming may cause some
pre-2.5.2 drivers to break, and unless there is absolutely no other
route to get things fixed, we should avoid this. So here is another
option I'd like we consider. Actually, it's not a single fix, but rather
several steps to fix the situation with respect to (eager) mode
management in RTDM drivers and elsewhere.

A few assumptions that drive the logic below:

- a shadow nrt thread running in secondary mode won't get a significant
performance advantage with conforming calls, compared to lazy-switching
calls (i.e. __xn_exec_current). The only advantage would come from not
running the RTDM syscall prologue twice when calling a rt service, which
is admittedly no big deal, in the absence of significant pressure on the
RTDM context lock. Since we do want to make nrt shadows automatically
switch back to secondary mode at some point, it turns out that the
preferred mode of operation for them would not be significantly favored
by conforming calls, even when applied to rt services.

- applications using rt_task_set_mode(...T_PRIMARY...) or the POSIX skin
equivalent via pthead_set_mode_np() are very likely to be wrong. At
best, they are adding a useless overhead, at worst, they are assuming
too much from the call. E.g. stepping into such code over GDB will
defeat the purpose of any switch to primary mode, receiving linux
signals as well (and the nucleus may send some of them), and I take for
granted that nobody wants utter crap like sigblock
+set_mode(T_PRIMARY)+syscall+sigunblock to never ever show up as a
common coding pattern in application space.

- as an illustration of the previous issue, attempting to control the
behavior of a RTDM driver by eagerly switching to the so-called "right"
mode before invoking some driver entry points, instead of having the
driver implement the proper logic to handle the adaptive switch if both
modes are supported, is definitely wrong.

- it turns out that we should find a way to leave the mode switch
handling where it belongs to, which is in kernel space (nucleus, skins,
and drivers), and definitely not in userland.

- there is no mode issue wrt shadow rt and plain linux tasks. The
preferred exec mode for the latter shall be primary, and the latter only
supports secondary mode anyway. So we are only discussing about shadow
nrt threads, i.e. Xenomai-enabled SCHED_OTHER threads in userland.

The steps now:

- we implement the automatic switchback of shadow nrt threads to
secondary mode, upon return from Xenomai (primary) syscalls. I am
working on this. The most significant impact is on userland, due to the
fastsynch support, actually. Kernel-wise, it's rather straightforward.
The only exception to this would be when the caller owns an exclusive
resource (like a mutex), in which case the mode downgrade should be
postponed until the syscall releasing the last resource held returns.

- because of the previous fix, there would be no valid use case of
forced switches to secondary mode anymore, via
rt_task_set_mode/pthread_set_mode_np by clearing the T_PRIMARY bit. So
we may remove that particular call form, that is most often misused.

- it turns out that __xn_exec_conforming is a misnomer, because it
rightfully causes a Xenomai nrt thread to switch to primary mode, albeit
that thread is inherently a secondary mode beast most of the time (at
least it should). We want to describe a syscall that switches the caller
to the highest domain it can reach instead, so we should rename this
mode bit as __xn_exec_strict for instance, without changing its
semantics.

- we provide T_CONFORMING instead of T_PRIMARY for
rt_task_set_mode()/pthread_set_mode_np(), keeping the ABI (i.e. the bit
number) and the effect intact for existing callers, who are using this
to force a Xenomai-enabled rt thread back to primary mode, which could
make sense in some rare cases. However the semantics changes: invoking
this service from a Xenomai nrt thread would lead to a nop, because the
preferred mode of operation is secondary, so any switch to primary shall
be nucleus-controlled, and reverted upon syscall return asap. Changing
the macro name should also have the useful side effect of forcing a
serious code inspection for apps being rebuilt over 2.5.3, so that the
reason to switch mode eagerly could be reconsidered, and the app fixed
properly.

To sum up,

1) rt_task_set_mode(whatever, T_PRIMARY, &oldmode) would become:
rt_task_set_mode(whatever, T_CONFORMING, &oldmode), actually forcing
primary mode for SCHED_FIFO Xenomai threads only. Nop otherwise.

2) rt_task_set_mode(T_CONFORMING, whatever, &oldmode) would always beget
-EINVAL, just because you can't ask for a thread to stop being
conformant to its basic nature.

- then, as you pointed out, we should move the RTDM calls back to
__xn_exec_current, and provide rtdm_is_rt_capable() to allow drivers to
control the exec mode efficiently via the adaptive syscall scheme. This
way, there is no more need to play the T_PRIMARY game in order to
implement a syscall differently, depending on whether the caller is a
Xenomai shadow, or a plain linux task. The nucleus, the skins and the
driver always know better.


-- 
Philippe.



