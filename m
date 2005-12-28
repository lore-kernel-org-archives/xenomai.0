Message-ID: <43B27DE4.9070405@domain.hid>
Date: Wed, 28 Dec 2005 12:58:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] I-pipe hosted tracing service
References: <43B1381B.6060001@domain.hid> <43B26587.9090809@domain.hid>
	<43B2789F.2090104@domain.hid>
In-Reply-To: <43B2789F.2090104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>> ...
>>>+#ifdef CONFIG_IPIPE_TRACE
>>>+extern void __ipipe_init_trace_proc(void);
>>>+#else /* !CONFIG_IPIPE_TRACE */
>>>+# define __ipipe_init_trace_proc()
>>>+#endif /* CONFIG_IPIPE_TRACE */
>>>+
>>
>>
>>Better move this to linux/ipipe.h.
> 
> 
> Ok.
> 
> 
>>>+
>>>+#include <linux/kernel.h>
>>>+#include <linux/module.h>
>>>+#include <linux/version.h>
>>>+#include <linux/kallsyms.h>
>>>+#include <linux/seq_file.h>
>>>+#include <linux/proc_fs.h>
>>>+#include <linux/ctype.h>
>>>+#include <linux/ipipe_trace.h>
>>>+#include <asm/uaccess.h>
>>>+
>>>+#ifndef CONFIG_ARM
>>
>>
>>Eeek... Any chance to have such arch-dependent stuff out of the generic
>>core? I'd better see this in asm/ipipe.h.
>>
>>
>>>+# define __CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
>>>+# define __CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
>>>+#else
>>>+# error Implement ipipe_arm_return_addr!
>>>+  unsigned long ipipe_arm_return_addr(int level);
>>>+# define __CALLER_ADDR0 ipipe_arm_return_addr(0)
>>>+# define __CALLER_ADDR1 ipipe_arm_return_addr(1)
>>>+#endif
>>>+
> 
> 
> Ok. Will add something like
> 
> 
> #ifndef BROKEN_BUILTIN_RETURN_ADDRESS
> #define __BUILTIN_RETURN_ADDRESS0 \
>     ((unsigned long)__builtin_return_address(0))
> ...
> #endif
> 
> 
> to linux/ipipe.h and we may later add
> 
> 
> unsigned long ipipe_arm_return_addr(int level);
> 
> #define BROKEN_BUILTIN_RETURN_ADDRESS 1
> #define __BUILTIN_RETURN_ADDRESS0 ipipe_arm_return_addr(0)
> ...
> 
> 
> to an upcoming asm-arm/ipipe.h. Ack?
> 

Ack.

> 
>>>+
>>>+static inline unsigned long ipipe_tsc2us(unsigned long long delta)
>>>+{
>>>+#ifdef CONFIG_X86
>>>+    do_div(delta, cpu_khz/1000+1);
>>>+#elif defined(CONFIG_PPC)
>>>+    delta = mulhwu(tb_to_us, delta);
>>>+#elif defined(CONFIG_ARM)
>>>+    delta = mach_cycles_to_usecs(delta);
>>>+#else
>>>+    #error Implement ipipe_tsc2us.
>>>+#endif
>>
>>
>>Ditto. Actually, recent ipipe patches implement ipipe_tsc2ns already.
>>
> 
> 
> Hmm, switching to ipipe_tsc2ns/1000 for the microsecond calculation may
> work without loosing too much precision (the only exception would be a
> trace over more than a few seconds - not very common). But is
> ipipe_tsc2ns supposed to work on signed arguments on all archs, or do I
> have to continue handling this separately?
> 

Ok, ipipe_tsc2ns is supposed to remain almost trivial for all archs and 
is neither expected to handle signed or 64bit tsc values, so let's have 
the tracer define its own support.

> Jan


-- 

Philippe.

