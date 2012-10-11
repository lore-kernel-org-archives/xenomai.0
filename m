Message-ID: <5076BED1.3020902@xenomai.org>
Date: Thu, 11 Oct 2012 14:42:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com> <5074339F.8050601@xenomai.org>
	<50744677.2090103@gmail.com> <5076B407.30709@gmail.com>
	<5076BE30.50605@xenomai.org>
In-Reply-To: <5076BE30.50605@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops while running "cat /proc/xenomai/stat"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <stefan.roese@gmail.com>
Cc: xenomai@xenomai.org

On 10/11/2012 02:40 PM, Philippe Gerum wrote:
> On 10/11/2012 01:56 PM, Stefan Roese wrote:
>> On 10/09/2012 05:44 PM, Stefan Roese wrote:
>>> On 10/09/2012 04:24 PM, Philippe Gerum wrote:
>>>> On 10/09/2012 08:48 AM, Stefan Roese wrote:
>>>>
>>>>> [   65.601569] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
>>>>> [   65.607440] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
>>>>> [   65.614641] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]
>>>>
>>>> Is any list corruption detected when CONFIG_XENO_OPT_DEBUG_QUEUES is
>>>> enabled?
>>>
>>> No, I don't see any list corruptions with CONFIG_XENO_OPT_DEBUG_QUEUES
>>> enabled. But the crash log is different now. At least part of the
>>> "stat" is printed. And the crash happens now in xnintr_irq_handler().
>>> This different crash seems to result from a change of the kernel
>>> config (I enabled/disabled some other drivers as well in the meantime).
>>> I'm debugging now, how different kernel configurations result in different
>>> crash scenarios.
>>
>> I now strapped down my device driver to the absolute minimum. 
>> "cat /proc/xenomai/stat" still does crash. But not all the time, and not
>> always with the same output. Very strange is the "0x100100" in the
>> output below. This is included in many of the crash reports. Does this
>> ring a bell?
> 
> #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
> 
> Somebody might be doing bad things with memory it does not own anymore?
> 

Just to rule this out, could you try raising the kernel thread stack
size this way?

diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 53fd59d..e8dd57c 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -31,7 +31,7 @@
 #ifdef CONFIG_PPC64
 #define XNARCH_THREAD_STACKSZ   8182
 #else
-#define XNARCH_THREAD_STACKSZ   4096
+#define XNARCH_THREAD_STACKSZ   8192
 #endif

 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)

-- 
Philippe.

