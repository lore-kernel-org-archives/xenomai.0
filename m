Message-ID: <8fc10c34-6d81-96c6-27cc-4a05f657dffa@siemens.com>
Date: Tue, 15 Mar 2022 12:08:02 +0100
MIME-Version: 1.0
Subject: Re: ipipe-5.4: arm64 regression
Content-Language: en-US
References: <44a716dd-c4aa-17d2-55f4-e5eaf50beb6a@siemens.com>
 <CALLqZ8Sx0DdA853TbhOirYAPM0siuE2eh4NzjXAtB8vxq_xNoA@mail.gmail.com>
 <6892bfa2-eeec-8820-4fe0-04db71994306@siemens.com>
 <CALLqZ8SCN7heaoZYmpCH7U4juOyb_sX9DwfTbLN1bzX+ve9xpA@mail.gmail.com>
 <11285d5a-b095-6e75-eeae-73e4a94a128b@siemens.com>
 <CALLqZ8SYXLe9Z1F5-rxRrZqrBgggFSdNzVu_CkmshV5MHadC1w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8SYXLe9Z1F5-rxRrZqrBgggFSdNzVu_CkmshV5MHadC1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On 14.03.22 14:02, Greg Gallagher wrote:
> 
> 
> On Mon, Mar 14, 2022 at 8:33 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 04.03.22 00:45, Greg Gallagher wrote:
>     >
>     >
>     > On Thu, Mar 3, 2022 at 1:20 PM Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>
>     > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>>
>     wrote:
>     >
>     >     On 02.03.22 16:44, Greg Gallagher wrote:
>     >     >
>     >     >
>     >     > On Wed, Mar 2, 2022 at 1:48 AM Jan Kiszka
>     <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>     >     <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>
>     >     > <mailto:jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com> <mailto:jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>>>
>     >     wrote:
>     >     >
>     >     >     Hi Greg,
>     >     >
>     >     >     something is going wrong on arm64 with latest ipipe version,
>     >     see e.g.
>     >     >
>     >     >   
>     >   
>       https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw
>     <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw>
>     >   
>      <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw
>     <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw>>
>     >     >   
>     >   
>       <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw
>     <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw>
>     >   
>      <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw
>     <https://source.denx.de/Xenomai/xenomai-images/-/jobs/398455/raw>>>
>     >     >     (same thing seen on HiKey as well)
>     >     >
>     >     >     Could you have a look?
>     >     >
>     >     >     Thanks,
>     >     >     Jan
>     >     >
>     >     >     --
>     >     >     Siemens AG, Technology
>     >     >     Competence Center Embedded Linux
>     >     >
>     >     >
>     >     > I'll take a look, it will be close to the end of the week
>     but i'll aim
>     >     > to have it root caused by the weekend.
>     >     >
>     >
>     >     Just tried locally with xenomai-images and qemu-arm64 (just
>     run smokey):
>     >
>     >     [  408.747349] Kernel panic - not syncing: kernel stack overflow
>     >     [  408.747591] CPU: 0 PID: 1577 Comm: systemd-journal Tainted:
>     G   
>     >         W         5.4.180+ #1
>     >     [  408.747762] Hardware name: linux,dummy-virt (DT)
>     >     [  408.747852] I-pipe domain: Xenomai
>     >     [  408.747941] Call trace:
>     >     ...
>     >     [  408.761131]  do_debug_exception+0x94/0x240
>     >     [  408.761255]  el1_dbg+0x18/0x8c
>     >     [  408.761329]  this_cpu_has_cap+0x60/0x7c
>     >     [  408.761423]  erratum_1418040_thread_switch+0x18/0x5c
>     >     [  408.761534]  __switch_to+0xf8/0x154
>     >     [  408.761622]  xnarch_switch_to+0x5c/0xc4
>     >     [  408.761711]  pipeline_switch_to+0x14/0x84
>     >     [  408.761803]  ___xnsched_run+0x154/0x240
>     >     [  408.761889]  pipeline_schedule+0x30/0x40
>     >     [  408.761999]  xnintr_core_clock_handler+0x250/0x260
>     >     [  408.762107]  dispatch_irq_head+0x84/0x120
>     >     [  408.762198]  __ipipe_dispatch_irq+0x19c/0x1c4
>     >     [  408.762293]  __ipipe_grab_irq+0x5c/0xa0
>     >     [  408.762377]  gic_handle_irq+0x54/0xb0
>     >     [  408.762457]  handle_arch_irq_pipelined+0x14/0x60
>     >     [  408.762557]  el0_irq_naked+0x5c/0x84
>     >     [  408.762905] SMP: stopping secondary CPUs
>     >
>     >     This dbg trap from erratum_1418040_thread_switch looks
>     suspicious, and
>     >     if I had to bet, I would say it somehow relates to [1] which
>     came with
>     >     v5.4.176. But more logical would [2] due to its switch from
>     static to
>     >     dynamic cpu_has_cap - but that is already in since v5.4.80...
>     >
>     >     Jan
>     >
>     >     [1]
>     >   
>      https://source.denx.de/Xenomai/ipipe-arm64/-/commit/a6d588572568c7431a9a3dc17f3c75962a2f070b
>     <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/a6d588572568c7431a9a3dc17f3c75962a2f070b>
>     >   
>      <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/a6d588572568c7431a9a3dc17f3c75962a2f070b
>     <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/a6d588572568c7431a9a3dc17f3c75962a2f070b>>
>     >     [2]
>     >   
>      https://source.denx.de/Xenomai/ipipe-arm64/-/commit/71eea3d3df94ccdcf3b616d27d68d6c028c1968f
>     <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/71eea3d3df94ccdcf3b616d27d68d6c028c1968f>
>     >   
>      <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/71eea3d3df94ccdcf3b616d27d68d6c028c1968f
>     <https://source.denx.de/Xenomai/ipipe-arm64/-/commit/71eea3d3df94ccdcf3b616d27d68d6c028c1968f>>
>     >
>     >
>     >     --
>     >     Siemens AG, Technology
>     >     Competence Center Embedded Linux
>     >
>     >
>     > I just built a new image and I’ll have time to look into this probably
>     > tomorrow.
>     >
>     > Thanks for the help :)
>     >
> 
>     Any news on this? Do you need further support?
> 
>     Jan
> 
>     -- 
>     Siemens AG, Technology
>     Competence Center Embedded Linux
> 
> 
> Still working on it, I’ve unfortunately haven’t had a lot of time to
> focus on this. I should have more time this week.
> 
> If anyone has any ideas or patches they’d like me to try I can test them
> as well.
> 

Looks like we have a bunch of new !preemtible() assertions in the
switching path due to that erratum_1418040_thread_switch. Those
sometimes trigger over Xenomai tasks, and that will cause the debug trap
followed by a ride to fault recursion hell. I've hacked two away, and
things seem to run smoothly again. Needs more careful analysis, though.
Also that path of erratum_1418040_new_exec, if it needs hard preemption 
off.

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1e16c4e00e771..8f74d2830e1b9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -37,7 +37,7 @@ static bool __maybe_unused
 is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry,
 			    int scope)
 {
-	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+	WARN_ON(scope != SCOPE_LOCAL_CPU /*|| preemptible()*/);
 	return is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
 }
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index acdef8d76c64d..0d2242c0fe6b7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2023,7 +2023,7 @@ static void __init mark_const_caps_ready(void)
 
 bool this_cpu_has_cap(unsigned int n)
 {
-	if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
+	if (/*!WARN_ON(preemptible()) &&*/ n < ARM64_NCAPS) {
 		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
 
 		if (cap)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 68c078ab0250c..879ecf0237c88 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -517,9 +517,9 @@ static void erratum_1418040_thread_switch(struct task_struct *next)
 
 static void erratum_1418040_new_exec(void)
 {
-	preempt_disable();
+	unsigned long flags = hard_preempt_disable();
 	erratum_1418040_thread_switch(current);
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 
 /*

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

