Date: Mon, 18 Dec 2017 09:53:57 +0800
From: Peng Fan <van.freenix@gmail.com>
Message-ID: <20171218015355.kze6vkclxukbfj2v@linux-u7w5.ap.freescale.net>
References: <20171214102348.tkgnln3xvzxkx5bc@linux-u7w5.ap.freescale.net>
 <26353124-2b4f-b911-8729-c621d565757e@xenomai.org>
 <20171215095342.sjwcih77zq5zrbqj@linux-u7w5.ap.freescale.net>
 <20171216133149.abhzge7bpguhyd2r@linux-u7w5.ap.freescale.net>
 <ea8ccf3f-db54-767e-98ee-871205300437@xenomai.org>
 <20171217110702.xpxrnm4zczbwosy4@linux-u7w5.ap.freescale.net>
 <66047886-ce80-132a-4940-38b2724319d4@xenomai.org>
 <16c673db-7fdd-7072-877e-41ab0991718b@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c673db-7fdd-7072-877e-41ab0991718b@xenomai.org>
Subject: Re: [Xenomai] xenomai on ARM64 question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez <jro@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Dec 17, 2017 at 02:50:39PM +0100, Jorge Ramirez wrote:
>On 12/17/2017 02:47 PM, Jorge Ramirez wrote:
>> On 12/17/2017 12:07 PM, Peng Fan wrote:
>> > Hi Jorge,
>> > 
>> > On Sat, Dec 16, 2017 at 07:28:38PM +0100, Jorge Ramirez wrote:
>> > > On 12/16/2017 02:31 PM, Peng Fan wrote:
>> > > > On Fri, Dec 15, 2017 at 05:53:43PM +0800, Peng Fan wrote:
>> > > > > Hi Philippe,
>> > > > > On Thu, Dec 14, 2017 at 05:39:10PM +0100, Philippe Gerum wrote:
>> > > > > > On 12/14/2017 11:23 AM, Peng Fan wrote:
>> > > > > > > Hi,
>> > > > > > > 
>> > > > > > > I am trying xenomai on ARM64 with GICV3, but met
>> > > > > > > the following error.
>> > > > > > > I have no good idea on this. I disabled
>> > > > > > > KVM/CPUFREQ/CPUIDLE, enabled DEBUG.
>> > > > > > > I use ipipe-core-4.9.51-arm64-3.patch with these
>> > > > > > > patches applied from 4.9.y branch
>> > > > > > > "
>> > > > > > > ipipe: printk: fix unprotected check for deferrable output
>> > > > > > > ipipe: drop obsolete ipipe_probe_kernel*() calls
>> > > > > > > lib/ipipe: make dump_stack() domain-aware
>> > > > > > > ipipe: gicv3: [v3] Enable interrupt pipelining.
>> > > > > > > ipipe: add back migration notifiers
>> > > > > > > "
>> > > > > > > 
>> > > > > > > Do you know what this issue maybe related about?
>> > > > > > > 
>> > > > > > > Log:
>> > > > > > > [   20.236548] dhd_module_init out
>> > > > > > > [   20.239689] ALSA device list:
>> > > > > > > [   20.242750]   #0: amix-audio-sai
>> > > > > > > [   20.246170] Unable to handle kernel NULL
>> > > > > > > pointer dereference at virtual addr0
>> > > > > > > [   20.254331] mm_pgd = ffff000009469000, hw_pgd = ffff8000015a4000
>> > > > > > > [   20.260341] [00000000] *pgd=00000008bfffe003,
>> > > > > > > *pud=00000008bfffd003, *pmd=000
>> > > > > > > [   20.268640] Internal error: Oops: 86000004 [#1] PREEMPT SMP
>> > > > > > Some irqchip driver enabled in your kernel is not aware of interrupt
>> > > > > > pipelining, i.e. not handled by the I-pipe patch. The
>> > > > > > ->irq_hold/release() handlers for this interrupt
>> > > > > > controller are likely
>> > > > > > missing.
>> > > > > Thanks. It is a dummy irqchip driver used for wakeup
>> > > > > causes this issue.
>> > > > > 
>> > > > > I still have a question on my platform. with "maxcpus=1",
>> > > > > kernel could runs
>> > > > > into login shell. But if using default 4 CPUs, kernel stops at:
>> > > > > 
>> > > > > [    4.305046] audit: initializing netlink subsys (disabled)
>> > > > > [    4.305111] audit: type=2000 audit(4.032:1): initialized
>> > > > > [    4.305526] [Xenomai] scheduling class idle registered.
>> > > > > [    4.305530] [Xenomai] scheduling class rt registered.
>> > > > > ---- Stops here.
>> > > > > 
>> > > > >From the code, I found it stops at
>> > > > >                          /*
>> > > > >                           * Ensure all CPUs consumed the IPI to avoid
>> > > > >                           * running __ipipe_cpu_sync
>> > > > > prematurely. This
>> > > > >                           * usually resolves the deadlock reason too.
>> > > > >                           */
>> > > > >                          while (!cpumask_equal(&online,
>> > > > > &__ipipe_cpu_pass_map))
>> > > > >                                  cpu_relax();
>> > > > > 
>> > > > > Seems online not equal to __ipipe_cpu_pass_map. I am not
>> > > > > sure IPI is send
>> > > > > to other cores, I am using GICV3. Still debugging.
>> > > > > 
>> > > > > Any hints?
>> > > > Resolved. It is my arm trusted firmware issue, not configured
>> > > > ipi critical
>> > > > correctly.
>> > > is your ATF in some public repository (ie, are you upstreaming
>> > > it)? just
>> > > curious...
>> > This is the ATF public,
>> > https://source.codeaurora.org/external/imx/imx-atf/
>> > Currently I use internal development tree. Cod not upstreamed.
>> 
>> and the patch fixing your issue?

Just a temperoray hack:
Interrupt 6 is for IPIPE CRITICAL in Linux, should not be configured in g1s.

diff --git a/plat/freescale/common/plat_imx8_gic.c b/plat/freescale/common/plat_imx8_gic.c
index 245cf4c7..5573b3e0 100644
--- a/plat/freescale/common/plat_imx8_gic.c
+++ b/plat/freescale/common/plat_imx8_gic.c
@@ -39,7 +39,7 @@ uintptr_t rdistif_base_addrs[PLATFORM_CORE_COUNT];

 /* array of Group1 secure interrupts to be configured by the gic driver */
 const unsigned int g1s_interrupt_array[] = {
-       6
+       9


>
>just trying to determine if I need to add anything to my supported board for
>the future
>https://source.codeaurora.org/external/imx/imx-atf/commit/?h=github.com/integration&id=e35d0edbbf5f55f2da5fa54ab5518149c18de622

I think no. It already have g1s interrupt configured correctly.

Regards,
Peng.

>
>
>
>
>> 
>> > 
>> > Thanks,
>> > Peng.
>> > > 
>> 
>

-- 

