Message-ID: <538662D9.4050308@xenomai.org>
Date: Thu, 29 May 2014 00:27:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
 <5382E8B1.8070402@xenomai.org>
 <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
 <5383406C.4070902@xenomai.org>
 <CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>
 <CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
 <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
 <5385F190.7050303@xenomai.org>
 <C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>
 <538622C8.6000906@xenomai.org>
 <E8636526-7C80-4789-99F1-C570732F6928@mah.priv.at>
 <538648DB.1000008@xenomai.org>
 <CAO0fa7aDo1fzGfvYUt89-vMrt9oksJhQdGSdfN8LMBzRc_FtVQ@mail.gmail.com>
 <5386505E.2030904@xenomai.org>
In-Reply-To: <5386505E.2030904@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/28/2014 11:08 PM, Gilles Chanteperdrix wrote:
> On 05/28/2014 11:01 PM, Drew wrote:
>> I've only been using the machinekit pre-built kernel so rebuilding might
>> take me a little while figure out.
>>
>> Gilles: you think you have this bug in a corner (entry.S?)
> 
> I can reproduce the bug. It is most certainly related to system call
> restarting, but I am not quite sure of what happens yet. My BUG_ON
> trigs, but I do not understand why, and the reason of the BUG_ON is not
> what causes the -ENOSYS. I can not really use the I-pipe tracer, because
> everything happens in assembly code with very few function calls.
> 
> So, it may be a while before I produce a fix.
> 
The result is embarrassingly simple: the BUG_ON is wrong, and we simply 
need to pass restarted syscalls through __ipipe_syscall_root.


diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 68a80d3..8f29cb1 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -446,6 +446,7 @@ ENTRY(vector_swi)
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
 #endif
 
+local_restart:
 #ifdef CONFIG_IPIPE
 	mov	r1, sp
 	mov	r0, scno
@@ -457,7 +458,6 @@ ENTRY(vector_swi)
 	ldmia	sp, { r0 - r3 }
 #endif /* CONFIG_IPIPE */
 
-local_restart:
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
index abdbe29..3a2266c 100644
--- a/arch/arm/kernel/ipipe.c
+++ b/arch/arm/kernel/ipipe.c
@@ -440,10 +440,6 @@ asmlinkage int __ipipe_syscall_root(unsigned long scno, struct pt_regs *regs)
 
 	fast_irq_enable(flags);
 out:
-#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
-	BUG_ON(ret > 0 && current_thread_info()->restart_block.fn !=
-	       do_no_restart_syscall);
-#endif
 	return ret;
 }
 


-- 
                                                                Gilles.

