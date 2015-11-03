References: <56377A74.6020803@mail.de> <56377B55.8000600@xenomai.org>
 <5638511E.9030606@mail.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5638695A.6020700@xenomai.org>
Date: Tue, 3 Nov 2015 08:59:22 +0100
MIME-Version: 1.0
In-Reply-To: <5638511E.9030606@mail.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel oops in giveup_fpu (file fpu.S)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Moder <ralf.moder@mail.de>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/03/2015 07:15 AM, Ralf Moder wrote:
> Am 02.11.2015 um 16:03 schrieb Philippe Gerum:
>> On 11/02/2015 04:00 PM, Ralf Moder wrote:
>>> Hi,
>>>
>>> i have a powerpc cpu (mpc5200) running linux 3.14.17 with xenomai patch
>>> 2.6.4 on it. I use floating point in kernel, so the (assembly-)function
>>> "giveup_fpu" (in file arch/powerpc/kernel/fpu.S) is called and throws a
>>> kernel-oops. fpu.S is patched with ipipe-core-3.14.17-powerpc-6.patch.
>>> In original linux (kernel 3.14.17) "giveup_fpu" looks like this:
>>>
>> Please send a diff context patch summarizing your changes.
>>
> 
> Here is my diff:
> 
> --- build/linux-3.14.17/arch/powerpc/kernel/fpu.S    2015-10-22
> 12:06:38.167507290 +0200
> +++
> /home/ralf/qx_ralf/quantumx/projects/ppc/workspace/build/linux-3.14.17/arch/powerpc/kernel/fpu.S   
> 2015-11-02 13:11:57.000000000 +0100
> @@ -218,7 +218,7 @@
>      SYNC_601
>      isync
>      PPC_LCMPI    0,r3,0
> -    beq-    2f            /* if no previous owner, done */
> +    beq-    3f            /* if no previous owner, done */
>      addi    r3,r3,THREAD            /* want THREAD of task */
>      PPC_LL    r6,THREAD_FPSAVEAREA(r3)
>      PPC_LL    r5,PT_REGS(r3)
> @@ -245,7 +245,7 @@
>      LOAD_REG_ADDRBASE(r4,last_task_used_math)
>      PPC_STL    r5,ADDROFF(last_task_used_math)(r4)
>  #endif /* CONFIG_SMP */
> -2:
> +3:
>  #ifdef CONFIG_IPIPE        /* restore interrupt state */
>      andi.    r6,r6,MSR_EE
>      beqlr
> 
> As you can see, i only changed the label name (from "2:" to "3:") and
> the branch to this label. I did that because after applying the
> ipipe-patch two labels with name "2:" exists in giveup_fpu and an
> objdump has shown that "beq 2f" jumps to the wrong label.
> 

Ok, I'll pick it, thanks. You may want to pick the patch I mentioned
lately as well, not to rely on r6 for keeping the machine state register.

-- 
Philippe.

