References: <308568998.3587071.1477532601674.ref@mail.yahoo.com>
 <308568998.3587071.1477532601674@mail.yahoo.com>
 <4004d7e1-d78f-0f97-ee12-d3a33f16400d@xenomai.org>
 <676757176.2746476.1477937578868@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6a1ac435-0a01-cd4a-5d1a-c512354888d4@xenomai.org>
Date: Tue, 1 Nov 2016 12:56:01 +0100
MIME-Version: 1.0
In-Reply-To: <676757176.2746476.1477937578868@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] accessing mmap'ed memory causes mode switches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/31/2016 07:12 PM, Giulio Moro wrote:
> Thanks Philippe,
> 
>>> //causes mode switches:
>>> rt_printf("%f\n", arr[n]);
>>>
>>
>> This is due to minor faults, when the memory is there but not referenced
>> to by a valid PTE in the page table for the current process yet.
>>
>> Before the 3.10 series, the pipeline used to switch to secondary mode
>> eagerly upon any kind of page fault including minor ones (see
>> do_translation_fault() in arm/mm/fault.c), this is what your code is
>> experiencing with 3.8.
>>
>> Starting from 3.10 and on, those faults should be transparently handled
>> by the pipeline, and should not require any transition to secondary mode
>> for armv6+ CPUs.
>>
>> In short, you need to upgrade the pipeline code.
> 
> 
> I noticed that the mode switch happens over and over again even when accessing the same memory location multiple times.
> e.g., this code will cause 10 mode switches:
> 
> for(j = 0; j < 10; ++j){
>   arr[0] = 1.f; // switches to secondary mode
>   rt_task_sleep(200000000);  // sleep, switches to primary mode
> }
> 
> Is this phenomenon still explained by the issue in pre-3.10 you outlined ?
> 

This fix of an obvious issue we had in pre-3.10 pipelines for ARM should
give a hint:

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index d3259cb..cb46d76 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -440,18 +440,11 @@ do_translation_fault(unsigned long addr, unsigned
int fsr,
 	pgd_t *pgd, *pgd_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
+	unsigned long flags;

 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);

-	if (__ipipe_report_trap(IPIPE_TRAP_ACCESS,regs))
-		return 0;
-
-#ifdef CONFIG_IPIPE
-	ipipe_stall_root();
-	hard_local_irq_enable();
-#endif
-
 	if (user_mode(regs))
 		goto bad_area;

@@ -499,7 +492,20 @@ do_translation_fault(unsigned long addr, unsigned
int fsr,
 	return 0;

 bad_area:
+	if (__ipipe_report_trap(IPIPE_TRAP_ACCESS,regs))
+		return 0;
+
+#ifdef CONFIG_IPIPE
+	flags = ipipe_test_and_stall_root();
+	hard_local_irq_enable();
+#endif
+
 	do_bad_area(addr, fsr, regs);
+
+#ifdef CONFIG_IPIPE
+	hard_local_irq_disable();
+	ipipe_restore_root_nosync(flags);
+#endif
 	return 0;
 }
 #else					/* CONFIG_MMU */

-- 
Philippe.

