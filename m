Subject: Re: Dovetail/x86 still broken /wrt exception fixups
References: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d4d00a44-a155-663d-d6c9-7135d2beedb8@siemens.com>
Date: Wed, 2 Jun 2021 17:29:09 +0200
MIME-Version: 1.0
In-Reply-To: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 01.06.21 23:24, Jan Kiszka via Xenomai wrote:
> Hi Philippe,
> 
> we are leaking the inband stall state into user land when the kernel
> takes a fixable exception in oob. The problem is either
> cond_disable_irqs() or its (missing?) counterpart. Where is the stall
> bit set in handle_page_fault->cond_disable_irqs supposed to be cleared
> again?
> 
> I-pipe is fine in that regard, but it took us many years to get it into
> that state - and it didn't have to deal with the impact of ca4c6a9858
> ("x86/traps: Make interrupt enable/disable symmetric in C code") anymore...
> 

A first attempt to fix the issue, but I'm only half-way through with 
understanding the related logic in dovetail:

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5e33248453e7..9f8c51e5f51c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -526,7 +526,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 	 * irqentry_enter() raised it in order to mirror the hardware
 	 * state.
 	 */
-	if (state.stage_info & IRQENTRY_INBAND_STALLED)
+	if (state.stage_info == IRQENTRY_INBAND_STALLED ||
+	    (running_inband() && state.stage_info == IRQENTRY_OOB_ENTRY))
 		unstall_inband();
 #endif
 	return;

State seems now consistent again.

BTW, all those tests for bits in stage_info should likely be converted 
to testing for the state - IRQENTRY_INBAND_STALLED and IRQENTRY_OOB_ENTRY 
are mutually exclusive. Would make the code more readable.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

