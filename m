References: <57B41CA5.5040103@allwinnertech.com>
 <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
 <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
 <57B67DAD.8060707@allwinnertech.com> <57B6FA48.4070609@allwinnertech.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3abb8d06-cf67-d90f-de3f-6e3d935d93d3@xenomai.org>
Date: Sun, 21 Aug 2016 20:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <57B6FA48.4070609@allwinnertech.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [help] porting I-pipe patch on linux-3.4
 ARM(cortex-a7) soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xielinfei <xielinfei@allwinnertech.com>, xenomai@xenomai.org

On 08/19/2016 02:23 PM, xielinfei wrote:
> Hi Philippe,
> 
> 
> test-3.4.6-patch: it is the official I-pipe patch 
> ipipe-core-3.4.6-arm-4.patch
> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch>
> test-3.4.v3s-patch: It is the vendor sdk with the modified I-pipe patch 
> (mainly based on ipipe-core-3.4.6-arm-4.patch
> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch>)
> 
> The mainly differ as follow:
> --------------------------------------------------------------------------------------------------------------------------------------
> diff -r test-3.4.6-patch/arch/arm/kernel/entry-armv.S
> test-3.4.v3s-patch/arch/arm/kernel/entry-armv.S
> 269a270,282
>> __und_fault:
>>     @ Correct the PC such that it is pointing at the instruction
>>     @ which caused the fault.  If the faulting instruction was ARM
>>     @ the PC will be pointing at the next instruction, and have to
>>     @ subtract 4.  Otherwise, it is Thumb, and the PC will be
>>     @ pointing at the second half of the Thumb instruction.  We
>>     @ have to subtract 2.
>>     ldr    r2, [r0, #S_PC]
>>     sub    r2, r2, r1
>>     str    r2, [r0, #S_PC]
>>     b    do_undefinstr
>> ENDPROC(__und_fault)
>>
> 295c308
> < #ifndef    CONFIG_THUMB2_KERNEL


Please always send unified diffs (diff -u) to express changes in source
code, this is easier to analyze than the antiquated original diff format.

I don't see any hunks fixing up the architected timer to make it
pipeline-aware. Those changes should take place in
drivers/clocksource/arm_arch_timer.c. Some of them also allow a userland
code to read the MMIO registers taping into the clock source, this will
be required for running Xenomai apps.

On a general note, I would not try to upgrade ipipe-3.4.6 for supporting
the architected timer, I would rather downgrade ipipe-3.18 to match your
3.4.6 kernel. This way, the port would include all the post-3.4 fixes,
and the support for the arch timer as well.

If you chose to do so, you only need to port the changes affecting the
devices provided by your SoC, ignoring any hunk which belong to other
ARM SoC/variants (e.g. timers, clock sources, irq chip controllers, gpio
modules etc).

You could run splitdiff -a on the ipipe-3.18 patch, cherry-picking all
the needed changes.

-- 
Philippe.

