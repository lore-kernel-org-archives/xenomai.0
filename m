From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BC570A4.1090203@domain.hid>
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
	<1271191271.2365.436.camel@domain.hid>
	<4BC4F8CA.4080202@domain.hid>
	<1271229750.2365.444.camel@domain.hid. org>
	<4BC570A4.1090203@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Apr 2010 11:04:34 +0200
Message-ID: <1271235874.2365.483.camel@domain.hid>
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

On Wed, 2010-04-14 at 09:37 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2010-04-14 at 01:05 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> The steps now:
> >>>
> >>> - we implement the automatic switchback of shadow nrt threads to
> >>> secondary mode, upon return from Xenomai (primary) syscalls. I am
> >>> working on this. The most significant impact is on userland, due to the
> >>> fastsynch support, actually. Kernel-wise, it's rather straightforward.
> >>> The only exception to this would be when the caller owns an exclusive
> >>> resource (like a mutex), in which case the mode downgrade should be
> >>> postponed until the syscall releasing the last resource held returns.
> >> Kernel is clear, but user space sounds indeed interesting. I guess we
> >> need an out-of-band channel to tell the kernel about pending
> >> user-space-only lock ownerships when calling some unrelated syscall. How
> >> does your current approach look like?
> > 
> > I want to keep things simple: shadow nrt will go through the syscalls
> > for acquisition/release of owned resources, instead of fastsynchs.
> 
> Then I'll have to pick this up as that will very likely create unhappy
> customers. In fact, the majority of our Xenomai threads are nrt (yeah,
> that happens if you convert existing applications).

I would understand that people do not want to bother that much with
using the right kind of threads between shadow nrt and plain linux
within the context of an initial port, but at some point, the code
should be made consistent with respect to the real use.

If there is a problem with auto-shadowing in the POSIX skin, or
sched_setscheduler() or whatever, then it should be addressed, but we
just can't pile up code only to satisfy such a corner case, i.e.
situations where applications create Xenomai nrt threads without actual
need for this, to make them run in secondary mode only, without
requiring a single primary-mode service (hence wanting hard to keep
__xn_exec_current for RTDM).

So, I will merge the bits I have in mind as a first step, because they
satisfy the normal usage of Xenomai threads. I will certainly ACK any
improvement to this code which keeps the original fastsynch optimization
for nrt threads, provided the feature/code overhead ratio seems correct.

> 
> > 
> >>> - because of the previous fix, there would be no valid use case of
> >>> forced switches to secondary mode anymore, via
> >>> rt_task_set_mode/pthread_set_mode_np by clearing the T_PRIMARY bit. So
> >>> we may remove that particular call form, that is most often misused.
> >>>
> >>> - it turns out that __xn_exec_conforming is a misnomer, because it
> >>> rightfully causes a Xenomai nrt thread to switch to primary mode, albeit
> >>> that thread is inherently a secondary mode beast most of the time (at
> >>> least it should). We want to describe a syscall that switches the caller
> >>> to the highest domain it can reach instead, so we should rename this
> >>> mode bit as __xn_exec_strict for instance, without changing its
> >>> semantics.
> >>>
> >>> - we provide T_CONFORMING instead of T_PRIMARY for
> >>> rt_task_set_mode()/pthread_set_mode_np(), keeping the ABI (i.e. the bit
> >>> number) and the effect intact for existing callers, who are using this
> >>> to force a Xenomai-enabled rt thread back to primary mode, which could
> >>> make sense in some rare cases. However the semantics changes: invoking
> >>> this service from a Xenomai nrt thread would lead to a nop, because the
> >>> preferred mode of operation is secondary, so any switch to primary shall
> >>> be nucleus-controlled, and reverted upon syscall return asap. Changing
> >>> the macro name should also have the useful side effect of forcing a
> >>> serious code inspection for apps being rebuilt over 2.5.3, so that the
> >>> reason to switch mode eagerly could be reconsidered, and the app fixed
> >>> properly.
> >>>
> >>> To sum up,
> >>>
> >>> 1) rt_task_set_mode(whatever, T_PRIMARY, &oldmode) would become:
> >>> rt_task_set_mode(whatever, T_CONFORMING, &oldmode), actually forcing
> >>> primary mode for SCHED_FIFO Xenomai threads only. Nop otherwise.
> >>>
> >>> 2) rt_task_set_mode(T_CONFORMING, whatever, &oldmode) would always beget
> >>> -EINVAL, just because you can't ask for a thread to stop being
> >>> conformant to its basic nature.
> >> These two still look too complex and inconsistent to grasp.
> >>
> >> Let's just keep the kernel ABI, ie. let the kernel still interpret the
> >> bit (maybe now according to your conforming scheme), but drop T_PRIMARY
> >> from the user-visible defines.
> > 
> > This is exactly what was described: drop T_PRIMARY as a way to fully
> > control the mode from userland, provide T_CONFORMING as a limited action
> > to force a switch back to primary for shadow rt.
> 
> Not exactly: I'm against T_CONFORMING.
> 
> > 
> >>  For the use case of an enforced primary
> >> mode switch-back, add a new service - if it is really required.
> >> rt_task_set_mode is about static property switching, so adding T_PRIMARY
> >> here was already a bad idea from that perspective.
> >>
> > 
> > There is no such limitation to rt_task_set_mode(), and T_CONFORMING is
> > not meant to be used blindly. So, I will stick with this interface.
> 
> T_CONFORMING is a mini-me of T_PRIMARY. If we already clean up the
> latter, it is a unique chance to finally drop that misplaced interface
> from rt_task_set_mode. It's asymmetric and does not really fit into the
> "true" modes that this interface controls.
> 

So, basically T_LOCK is a static switch for you? You mean that locking
the scheduler is a static property of any thread? Same for T_NOSIG and
blocking asynchronous calls? Look, I designed this interface after the
pSOS equivalent, and I can assure you that this was indeed meant to be a
mean to control dynamic properties.

Now, T_CONFORMING may please us or not, I won't argue about this. I do
think that having to switch mode eagerly in the context of an
application is the sign that something went wrong at design level
somehow. But, we are currently in the middle of a stable 2.5.x series,
with a requirement to keep the ABI and the (correct) feature set intact
between releases, so the way to fix the T_PRIMARY mess has to be
two-fold:

- Restrict the usage of T_PRIMARY to the only case where it might make
sense in a very limited number of situations. This implies switching
back to the preferred mode of operation for a Xenomai rt thread, so that
syscall-less sections following a secondary mode switch can still be
executed at full rt privileges.

- Remove all other uses of T_PRIMARY, because they are at best useless
and overkill, at worst plain wrong.

To this end, T_PRIMARY becomes T_CONFORMING, and the ABI is kept for the
acceptable case. This allow people NOT to recompile their app if they
were eargerly switching mode for a valid reason, and force others to fix
their applications.

Under normal circumstances, I would not even have suggested to touch the
API in a stable series for feature removal, but the situation wrt RTDM
and the wrong usage of mode switching that obviously started to slip
into our own code base (e.g. Analogy) was a wake up call.

> Jan
> 


-- 
Philippe.



