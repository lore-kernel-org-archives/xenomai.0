Message-ID: <2ff1a98a0710240856kd84e51fi1e7516ac809de026@domain.hid>
Date: Wed, 24 Oct 2007 17:56:50 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B47622@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47622@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

On 10/24/07, ROSSIER Daniel <Daniel.Rossier@domain.hid> wrote:
>
> Hi all,
>
> I've found a bug in arch/arm/xenomai/switch.S which solved the problem below. It actually comes from the iWMMXT (Intel Wireless MMX) coprocessor which is an extension of the ARM core in Xscale processor (and of course which is not available in the AT91 series ;-).
>
> When a thread switch occurs, rthal_thread_switch(in arch/arm/xenomai/switch.S) is called to perform switching of registers and stacks between threads. The PXA version must also perform a switch of MMX registers by invoking iwmmxt_task_switch(in arch/arm/kernel/iwmmxt.S). This is done in rthal_task_switch() as well.
>
> However, between Linux 2.6.15 and Linux 2.6.20, the general scheme of low-level task switching procedure changed a little bit: it is now relying on a call chain notifier-based mechanism. Therefore, the iwmmxt_task_switch() function has been updated since the function is called now from the notifier, and not directly from  __switch_to() as in 2.6.15. And the ipipe (ARM) patch did not take into account that.. and it fails.

Shame to me, I somehow managed to miss this issue completely.

-- 
                                               Gilles Chanteperdrix

