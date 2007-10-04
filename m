From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4704AEF3.4030105@domain.hid>
References: <4704AEF3.4030105@domain.hid>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 11:34:11 +0200
Message-Id: <1191490451.20623.54.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] IO-APIC stall due to broken fasteoi
	handling
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Thu, 2007-10-04 at 11:14 +0200, Jan Kiszka wrote:
> Hi all,
> 
> after a really long search I'm now quite sure to have found the reason
> for the lockups I'm seeing over 2.6.22-i386. I'm yet struggling to
> understand why this issue is not visible over 2.6.19 and .20 for me, but
> maybe it is just far less likely there.
> 
> Here is a short write-up of the I-pipe trace I was able to catch with
> some hacking from a locked up box:
> 
> Scenario: I-pipe active, Xenomai not loaded or compiled out (but loading
> Xenomai just increases the probability)
> 
> 1. IRQ 20 arrives, Linux starts serving it, but no one talks to the
>    IO-APIC so far because this is a fasteoi type IRQ.
> 
> 2. Linux reenables IRQs due to IRQF_DISABLED not set for IRQ 20.
> 
> 3. IRQ 23 arrives and gets delivered as it is of higher priority in the
>    APIC. From this point on, things start to fall apart.
> 
> 4. I-pipe stops the delivery in __ipipe_synch_stage because the
>    IPIPE_SYNC_FLAG is still set for the root domain. Linux switches back
>    to the IRQ 20 handler so that the usual handling order gets inverted
>    -- the first I-pipe bug.
> 

This means that the synchronization flag must become a per-IRQ thing; it
was introduced to prevent timer IRQs from piling up on behalf of the
syncer on overloaded low-end hardware.

> 5. IRQ 20 completes and sends an EOI to the APIC. Linux means that this
>    is for IRQ 20, but the APIC considers it for IRQ 23!
> 
> 6. IRQ 23 is re-enabled and arrives before its last event was handled.
>    Thus two IRQ-23-events get merged into one, and eoi is only executed
>    once instead of twice. This causes all IRQs < 23 being blocked from
>    now on. :(
> 
> Well, this trace also reveals a second bug that can cause nasty priority
> inversion: a high-prio domains executes when a fasteoi-IRQ arrives for a
> low-prio domain. This will now block all IRQs until the low-prio domain
> was able to run its IRQ handler completely. Thus we must _mask_ fasteoi
> IRQs for low-prio domains while high-prio ones are running!
> 

This code was actually there up to 2.6.17-1.5-02, and was removed at
some point in the 2.6.19 series, due to some severe conflicts with the
vanilla IO-APIC support which used to be a hell of a moving target at
that time. I guess it's time to bring this code back.

> These bugs should impact at least x86_64 as well, not sure about how
> powerpc looks like.

Powerpc has the same problem, even if it already mask+acks fasteois to
prevent interrupt flooding on MPIC hardware.

> 
> Jan
> 
-- 
Philippe.



