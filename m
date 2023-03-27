Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469D2596
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679958071; i=jan.kiszka@web.de;
	bh=nNp6H1Z7X54VRIQqafobpSZY2f+qw1bhdipF5pPbBhw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=edhkAyEuGev6AAr9P2aQ2GVSdyiNAmIGOmLZUoYrofynTjsoqQv/SjXAP0fptexyk
	 P9UjSv+o49Cp7gQAMKCkyN12nDLphN2evacP1Z3kSpoN33hmFe/cgfYFdV0eNdyQ2q
	 yLNKXd+22v5+ueWWMc8wikOnIe9Zm+xRKklZHTPCJoSf5Xm0AGcexA4j/+If9yXls8
	 0OuvYTk/WIKxEgi8ogDddfhw9cj+7WNPE8XzUGjzx1KEW+7fAf4GGjRpwhKrCECLiL
	 35GFbD8RHsYCatDULjXMQ31KKn//NbZ2O31rw3LI/41AexMJL+kGEB7AVqSKNV+2Hw
	 auwB/3+NprVKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([94.217.148.24]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eCL-1qPvyC1dot-011Ih4; Tue, 28
 Mar 2023 01:01:11 +0200
Message-ID: <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
Date: Tue, 28 Mar 2023 01:01:10 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RFC: System hang / deadlock on Linux 6.1
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kU84tsmgA0wLCslN3KHMzP8UwTWJSNjsRoxxWE2otpZH6sZLXL+
 kYkoabGuIxpntvWyd183HwwahpUCYL/4Hq/1jgswj22/tInlhM0SUrcMneskuoPLoIayphW
 RfJyY9xcLbaM1R3nEBRIl3WjzD/aXxReDIjvp7ZWjfHOZKhmdbM/rXFfG4lYBApmBqOuiY+
 uWy34nECyfo4rAND3UGPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AhjBXv8KvGM=;mGJnGIluwfCI7eqa5WMOAyPfwtn
 FBWRIVtQcBTcNPZzpR4cbhWrhU3G0/CmN/LCsRSaF/aHkQxa+U6xrHjDgfFLrEkVzY02rJFl9
 KAGUYM/9Tw8xQZlfotNGJ1t02F8Mgz+7K2yZzP4Y82TuYoisv182+WRTmA0rbJSqDNcHZv4VF
 GUO9pCtYAX283AQmVJJIbhX8jwX8Xz4KK+5TkQdNOq/nI0JeTTElA9eirzoF7kBMPJpDIb7pc
 rtEJVmlzKJtKTVomHY/p11i0yRPpYpVa7e6MeJkmlAxMPxjH3+swacPNo2ifzYmnoQN2IYO9N
 V6vLxQa5S3Dsq5Id6AwKFoM1wQ2rVPPs/Wt8VXMu+gUldw1JZHNWYiTxSE0FJ4UF0R1q2eQGn
 B8usbezQyKb86iWgfTU0yzTxxQ4R+P+2zJ3JWSFH53pwotHjUpaH0DOv7LeoOI4GhXnArehqs
 oueU4Q0ZyyFQBJFQ6s2lYVAoMjlORvhnMuXBJrKJLajG59QGiQb2yWLvrwvRiTkLp1sRK4/sB
 JIHx3t82YEXfkeugB8EBYFSe/U2xvG3BhmqJuado53UHgmnfm9hQqlP4NWe7QgxHkXIXHmSAY
 f6uxV29VpYnh3Mw1t3Q7tgT8dGPFXR5syy8ZpstjMlOm+m14SRbJldxghDdranlqHNOjJoVWC
 3jZHVUI6Jw/njOl5Zg+DerH+u10lVLkfWResw090sIZz58B5Zx1nv787bXJMnW+zwtVDqNXSG
 rD0RmkohMyFJi0wddh6/9VczG9sOFeHj9gGZkWUdvzBjYP+Zfl3DpuEw2XNlu2EKdNy+ThaL+
 YgLn6efep3lyB5PQB9nM5ehOCcpnfBAdoQVyiyUljBTKSnubbLwTfNSAy1UMRcjfLE1waadvn
 yQDJK0RfYq6L2qZCob+Hw+sKO8UZIeHaOx9f2S8wiW5FzdLgVe++mR4sZD/9XagVlpT9yo28Y
 dsfkZw==

On 27.03.23 19:30, Florian Bezdeka wrote:
> Hi all,
>
> I'm currently investigating an issue reported by an internal customer. W=
hen
> trying to run Xenomai (next branch) on top of Dovetail (6.1.15) in an vi=
rtual
> environment (VirtualBox 7.0.6) a complete system hang / deadlock can be
> observed.
>
> I was not able to reproduce the locking issue myself, but I'm able to "s=
tall"
> the system by putting a lot of load on the system (stress-ng). After 10-=
20
> minutes there is no progress anymore.
>
> The locking issue reported by the customer:
>
> [    5.063059] [Xenomai] lock (____ptrval____) already unlocked on CPU #=
3
> [    5.063059]           last owner =3D kernel/xenomai/pipeline/intr.c:2=
6 (xnintr_core_clock_handler(), CPU #0)
> [    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted 6.1.15-xe=
nomai-1 #1
> [    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS V=
M 12/01/2006
> [    5.063075] IRQ stage: Xenomai
> [    5.063077] Call Trace:
> [    5.063141]  <TASK>
> [    5.063146]  dump_stack_lvl+0x71/0xa0
> [    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
> [    5.063158]  xnintr_core_clock_handler+0xa4/0x140
> [    5.063166]  lapic_oob_handler+0x41/0xf0
> [    5.063172]  do_oob_irq+0x25a/0x3e0
> [    5.063179]  handle_oob_irq+0x4e/0xd0
> [    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
> [    5.063213]  arch_handle_irq+0x5d/0x1e0
> [    5.063218]  arch_pipeline_entry+0xa1/0x110
> [    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> ...
>
> After reading a lot of code I realized that the so called paravirtualize=
d
> spinlocks are being used when running under VB (VirtualBox):
>
> [    0.019574] kvm-guest: PV spinlocks enabled
>
> vs. Qemu:
>
> Qemu (with -enable-kvm):
> [    0.255790] kvm-guest: PV spinlocks disabled, no host support
>
> The good news: With CONFIG_PARAVIRT_SPINLOCKS=3Dn (or "nopvspin" on the =
kernel
> cmdline) the problem disappears.
>
> The bad news: As Linux alone (and dovetail without Xenomai patch) runs f=
ine,
> even with all the stress applied, I'm quite sure that we have a (maybe
> longstanding) locking bug.
>
> RFC: I'm now testing the patch below, which is already running fine for =
some
> hours now. Please let me know if all of this makes sense. I might have
> overlooked something.
>
> If I'm not mistaken the following can happen on one CPU:
>
> // Example: taken from tick.c, proxy_set_next_ktime()
> xnlock_get_irqsave(&nklock, flags);
> // root domain stalled, but hard IRQs are still enabled

OOB + hard IRQs stalled (xnlock_get_irqsave -> splhigh -> oob_irq_save).

>
> 	// PROXY TICK IRQ FIRES
> 	// taken from intr.c, xnintr_core_clock_handler()
> 	xnlock_get(&nklock);	// we already own the lock

If this code runs under the assumption that hard-IRQs and OOB is stalled
while they are not, we indeed have a problem. Please check where that
may have gone wrong.

Jan

> 	xnclock_tick(&nkclock);
> 	xnlock_put(&nklock);	// we unconditionally release the lock
> 	// EOI
>
> // back in proxy_set_next_ktime(), but nklock released!
> // Other CPU might already own the lock
> sched =3D xnsched_current();
> ret =3D xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE);
> xnlock_put_irqrestore(&nklock, flags);
>
>
> To avoid unconditional lock release I switched to xnlock_{get,put}_irqsa=
ve() in
> xnintr_core_clock_handler. I think it's correct. Additionally stalling t=
he
> root domain should not be an issues as hard IRQs are already disabled.
>
> diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr=
.c
> index a9459b7a8..ce69dd602 100644
> --- a/kernel/cobalt/dovetail/intr.c
> +++ b/kernel/cobalt/dovetail/intr.c
> @@ -22,10 +22,11 @@ void xnintr_host_tick(struct xnsched *sched) /* hard=
 irqs off */
>  void xnintr_core_clock_handler(void)
>  {
>         struct xnsched *sched;
> +       unsigned long flags;
>
> -       xnlock_get(&nklock);
> +       xnlock_get_irqsave(&nklock, flags);
>         xnclock_tick(&nkclock);
> -       xnlock_put(&nklock);
> +       xnlock_put_irqrestore(&nklock, flags);
>
> Please let me know what you think!
>
> Best regards,
> Florian
>

