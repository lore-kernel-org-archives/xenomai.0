Message-ID: <52E3FEEF.9050205@xenomai.org>
Date: Sat, 25 Jan 2014 19:14:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52E1D646.8050907@steinkuehler.net>
In-Reply-To: <52E1D646.8050907@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM/BeagleBone Thumb2 Kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 01/24/2014 03:56 AM, Charles Steinkuehler wrote:
> So when I try to build a Xenomai patched kernel for the BeagleBone using
> Thumb2 instructions, I get the following linker errors:
> 
>>   LD      init/built-in.o
>> arch/arm/kernel/built-in.o: In function `__irq_usr':
>> :(.kprobes.text+0x3c2): relocation truncated to fit: R_ARM_THM_JUMP19
>> against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
>> section in arch/arm/kernel/built-in.o
>> arch/arm/kernel/built-in.o: In function `ret_from_exception':
>> :(.kprobes.text+0x600): relocation truncated to fit: R_ARM_THM_JUMP19
>> against symbol `__ipipe_ret_to_user_irqs_disabled' defined in .text
>> section in arch/arm/kernel/built-in.o
>> make: *** [vmlinux] Error 1
>>
>> The link error goes away if I disable CONFIG_THUMB2_KERNEL, which wasn't
>> set in the original kernel config.
> 
> This has recently become more of a problem, as the default BeagleBone
> kernel has switched to enabling CONFIG_THUMB2_KERNEL.
> 
> A bit of Googling turned up the following patch to fix a similar problem
> on the Tegra (not Xenomai related):
> 
>   http://patchwork.ozlabs.org/patch/236760/
> 
> I applied a similar if-then patch (see below) to the two Xenomai calls
> that generate the linker errors, and the result is a working kernel.

Applied, thanks, I could reproduce the issue, and thinking about it
having entry-common.o close to entry-arm.o should not bring any
performance improvement in fact.

Regards.

-- 
                                                                Gilles.

