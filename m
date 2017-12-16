Date: Sat, 16 Dec 2017 21:31:51 +0800
From: Peng Fan <van.freenix@gmail.com>
Message-ID: <20171216133149.abhzge7bpguhyd2r@linux-u7w5.ap.freescale.net>
References: <20171214102348.tkgnln3xvzxkx5bc@linux-u7w5.ap.freescale.net>
 <26353124-2b4f-b911-8729-c621d565757e@xenomai.org>
 <20171215095342.sjwcih77zq5zrbqj@linux-u7w5.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215095342.sjwcih77zq5zrbqj@linux-u7w5.ap.freescale.net>
Subject: Re: [Xenomai] xenomai on ARM64 question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Dec 15, 2017 at 05:53:43PM +0800, Peng Fan wrote:
>Hi Philippe,
>On Thu, Dec 14, 2017 at 05:39:10PM +0100, Philippe Gerum wrote:
>>On 12/14/2017 11:23 AM, Peng Fan wrote:
>>> Hi,
>>> 
>>> I am trying xenomai on ARM64 with GICV3, but met the following error.
>>> I have no good idea on this. I disabled KVM/CPUFREQ/CPUIDLE, enabled DEBUG.
>>> I use ipipe-core-4.9.51-arm64-3.patch with these patches applied from 4.9.y branch
>>> "
>>> ipipe: printk: fix unprotected check for deferrable output
>>> ipipe: drop obsolete ipipe_probe_kernel*() calls
>>> lib/ipipe: make dump_stack() domain-aware
>>> ipipe: gicv3: [v3] Enable interrupt pipelining.
>>> ipipe: add back migration notifiers
>>> "
>>> 
>>> Do you know what this issue maybe related about?
>>> 
>>> Log:
>>> [   20.236548] dhd_module_init out
>>> [   20.239689] ALSA device list:
>>> [   20.242750]   #0: amix-audio-sai
>>> [   20.246170] Unable to handle kernel NULL pointer dereference at virtual addr0
>>> [   20.254331] mm_pgd = ffff000009469000, hw_pgd = ffff8000015a4000
>>> [   20.260341] [00000000] *pgd=00000008bfffe003, *pud=00000008bfffd003, *pmd=000
>>> [   20.268640] Internal error: Oops: 86000004 [#1] PREEMPT SMP
>>
>>Some irqchip driver enabled in your kernel is not aware of interrupt
>>pipelining, i.e. not handled by the I-pipe patch. The
>>->irq_hold/release() handlers for this interrupt controller are likely
>>missing.
>
>Thanks. It is a dummy irqchip driver used for wakeup causes this issue.
>
>I still have a question on my platform. with "maxcpus=1", kernel could runs
>into login shell. But if using default 4 CPUs, kernel stops at:
>
>[    4.305046] audit: initializing netlink subsys (disabled)
>[    4.305111] audit: type=2000 audit(4.032:1): initialized
>[    4.305526] [Xenomai] scheduling class idle registered.
>[    4.305530] [Xenomai] scheduling class rt registered.
>---- Stops here. 
>
>From the code, I found it stops at
>                        /*
>                         * Ensure all CPUs consumed the IPI to avoid
>                         * running __ipipe_cpu_sync prematurely. This
>                         * usually resolves the deadlock reason too.
>                         */
>                        while (!cpumask_equal(&online, &__ipipe_cpu_pass_map))
>                                cpu_relax();
>
>Seems online not equal to __ipipe_cpu_pass_map. I am not sure IPI is send
>to other cores, I am using GICV3. Still debugging.
>
>Any hints?

Resolved. It is my arm trusted firmware issue, not configured ipi critical
correctly.

Thanks,
Peng.

>
>Thanks,
>Peng.
>
>>
>>-- 
>>Philippe.
>
>-- 

-- 

