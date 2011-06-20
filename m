Message-ID: <4DFFB2F8.7090301@domain.hid>
Date: Mon, 20 Jun 2011 22:52:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>	<4DFBA305.9000303@domain.hid>	<4DFC7C0E.1090700@domain.hid>	<4DFC9575.1030904@domain.hid>	<4DFC95B7.8070703@domain.hid>	<4DFCA09B.20609@domain.hid>	<4DFCA323.6030704@domain.hid>
	<4DFCA432.3070203@domain.hid>	<4DFCAF07.8020607@domain.hid>
	<4DFE189D.5030908@domain.hid>	<4DFF78AA.9050904@domain.hid>
	<4DFF8476.2000306@domain.hid> <4DFFA19C.30000@domain.hid>
	<4DFFA24F.4050601@domain.hid> <4DFFA27F.3020808@domain.hid>
	<4DFFA4C0.70000@domain.hid> <4DFFB095.2030607@domain.hid>
In-Reply-To: <4DFFB095.2030607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/20/2011 10:41 PM, Jan Kiszka wrote:
> xnarch_switch_to is the central entry point for everyone. It may decide
> to branch to switch_to or __switch_to, or it simply handles all on its
> own - that's depending on the arch.

No, the Linux kernel does not know anything about xnarch_switch_to, so
the schedule() function continues to use switch_to happily.
xnarch_switch_to is only used to switch from xnthread_t to xnthread_t,
by __xnpod_schedule(). Now, that some architecture (namely x86) decide
that xnarch_switch_to should use switch_to (or more likely an inner
__switch_to) when the xnthread_t has a non NULL user_task member is an
implementation detail.

> Can you point out where in those paths irqs are disabled again (after
> entering xnarch_switch_to)

They are not disabled again after xnarch_switch_to, they are disabled
when starting switch_to.

 and left off for each of the unlocked
> switching archs? I'm still skeptical that the need for disable irqs
> during thread switch on some archs also leads to unconditionally
> disabled hard irqs when returning from xnarch_switch_to.
> 
> But even if that's all the case today, we would better set this
> requirement in stone:
> 
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index f2fc2ab..c4c5807 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -2273,6 +2273,8 @@ reschedule:
> 
>  	xnpod_switch_to(sched, prev, next);
> 
> +	XENO_BUGON(NUCLEUS, !irqs_disabled_hw());
> +

You misunderstand me: only after the second half context switch in the
case of xnshadow_relax are the interrupts disabled. Because this second
half-switch started as a switch_to and not an xnarch_switch_to, so,
started as:

#define switch_to(prev,next,last)                                       \
do {                                                                    \
        local_irq_disable_hw_cond();                                    \
        last = __switch_to(prev,task_thread_info(prev),
task_thread_info(next));        \
        local_irq_enable_hw_cond();                                     \
} while (0)

(On ARM for instance).

But that is true, we could assert this in the shadow epilogue case.

-- 
                                                                Gilles.

