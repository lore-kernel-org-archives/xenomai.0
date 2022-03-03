Message-ID: <6892bfa2-eeec-8820-4fe0-04db71994306@siemens.com>
Date: Thu, 3 Mar 2022 19:20:38 +0100
MIME-Version: 1.0
Subject: Re: ipipe-5.4: arm64 regression
Content-Language: en-US
References: <44a716dd-c4aa-17d2-55f4-e5eaf50beb6a@siemens.com>
 <CALLqZ8Sx0DdA853TbhOirYAPM0siuE2eh4NzjXAtB8vxq_xNoA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8Sx0DdA853TbhOirYAPM0siuE2eh4NzjXAtB8vxq_xNoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02.03.22 16:44, Greg Gallagher wrote:
> 
> 
> On Wed, Mar 2, 2022 at 1:48 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     Hi Greg,
> 
>     something is going wrong on arm64 with latest ipipe version, see e.g.
> 
>     https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw
>     <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw>
>     (same thing seen on HiKey as well)
> 
>     Could you have a look?
> 
>     Thanks,
>     Jan
> 
>     -- 
>     Siemens AG, Technology
>     Competence Center Embedded Linux
> 
> 
> I'll take a look, it will be close to the end of the week but i'll aim
> to have it root caused by the weekend.
> 

Just tried locally with xenomai-images and qemu-arm64 (just run smokey):

[  408.747349] Kernel panic - not syncing: kernel stack overflow
[  408.747591] CPU: 0 PID: 1577 Comm: systemd-journal Tainted: G        W         5.4.180+ #1
[  408.747762] Hardware name: linux,dummy-virt (DT)
[  408.747852] I-pipe domain: Xenomai
[  408.747941] Call trace:
...
[  408.761131]  do_debug_exception+0x94/0x240
[  408.761255]  el1_dbg+0x18/0x8c
[  408.761329]  this_cpu_has_cap+0x60/0x7c
[  408.761423]  erratum_1418040_thread_switch+0x18/0x5c
[  408.761534]  __switch_to+0xf8/0x154
[  408.761622]  xnarch_switch_to+0x5c/0xc4
[  408.761711]  pipeline_switch_to+0x14/0x84
[  408.761803]  ___xnsched_run+0x154/0x240
[  408.761889]  pipeline_schedule+0x30/0x40
[  408.761999]  xnintr_core_clock_handler+0x250/0x260
[  408.762107]  dispatch_irq_head+0x84/0x120
[  408.762198]  __ipipe_dispatch_irq+0x19c/0x1c4
[  408.762293]  __ipipe_grab_irq+0x5c/0xa0
[  408.762377]  gic_handle_irq+0x54/0xb0
[  408.762457]  handle_arch_irq_pipelined+0x14/0x60
[  408.762557]  el0_irq_naked+0x5c/0x84
[  408.762905] SMP: stopping secondary CPUs

This dbg trap from erratum_1418040_thread_switch looks suspicious, and 
if I had to bet, I would say it somehow relates to [1] which came with
v5.4.176. But more logical would [2] due to its switch from static to
dynamic cpu_has_cap - but that is already in since v5.4.80...

Jan

[1] https://source.denx.de/Xenomai/ipipe-arm64/-/commit/a6d588572568c7431a9a3dc17f3c75962a2f070b
[2] https://source.denx.de/Xenomai/ipipe-arm64/-/commit/71eea3d3df94ccdcf3b616d27d68d6c028c1968f 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

