References: <20171214102348.tkgnln3xvzxkx5bc@linux-u7w5.ap.freescale.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <26353124-2b4f-b911-8729-c621d565757e@xenomai.org>
Date: Thu, 14 Dec 2017 17:39:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171214102348.tkgnln3xvzxkx5bc@linux-u7w5.ap.freescale.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai on ARM64 question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peng Fan <van.freenix@gmail.com>, xenomai@xenomai.org

On 12/14/2017 11:23 AM, Peng Fan wrote:
> Hi,
> 
> I am trying xenomai on ARM64 with GICV3, but met the following error.
> I have no good idea on this. I disabled KVM/CPUFREQ/CPUIDLE, enabled DEBUG.
> I use ipipe-core-4.9.51-arm64-3.patch with these patches applied from 4.9.y branch
> "
> ipipe: printk: fix unprotected check for deferrable output
> ipipe: drop obsolete ipipe_probe_kernel*() calls
> lib/ipipe: make dump_stack() domain-aware
> ipipe: gicv3: [v3] Enable interrupt pipelining.
> ipipe: add back migration notifiers
> "
> 
> Do you know what this issue maybe related about?
> 
> Log:
> [   20.236548] dhd_module_init out
> [   20.239689] ALSA device list:
> [   20.242750]   #0: amix-audio-sai
> [   20.246170] Unable to handle kernel NULL pointer dereference at virtual addr0
> [   20.254331] mm_pgd = ffff000009469000, hw_pgd = ffff8000015a4000
> [   20.260341] [00000000] *pgd=00000008bfffe003, *pud=00000008bfffd003, *pmd=000
> [   20.268640] Internal error: Oops: 86000004 [#1] PREEMPT SMP

Some irqchip driver enabled in your kernel is not aware of interrupt
pipelining, i.e. not handled by the I-pipe patch. The
->irq_hold/release() handlers for this interrupt controller are likely
missing.

-- 
Philippe.

