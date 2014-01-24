Message-ID: <52E245E9.6080301@xenomai.org>
Date: Fri, 24 Jan 2014 11:52:25 +0100
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
> 
> Can someone more familiar with iPipeand ARM assembly review the attached
> minor patch and advise on whether or not it seems OK?
> 
> As I understand things, the two bne calls in the default ipipe patch
> don't work when building a kernel using the thumb instructions due to
> the limited range of the conditional branch.  Using the if-then
> construct when THUMB2 is enabled allows for a larger addressing range in
> the branch, thus avoiding the linker errors.  If this seems OK, perhaps
> it should be applied to the master ipipe patch set?  If not, is there a
> better way to avoid the linker errors when building with the thumb
> instructions?

This looks fine, but I have one objection: why does it work for me with
the toolchain I use (linaro 2012.09)?

-- 
                                                                Gilles.

