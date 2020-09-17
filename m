References: <20200917165326.GA6186@linux.intel.com>
 <MWHPR11MB1918305CDA40AB3754C334FDEE3E0@MWHPR11MB1918.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 1/4] cobalt/x86: adapt fpu code with Linux kernel upstream
In-reply-to: <MWHPR11MB1918305CDA40AB3754C334FDEE3E0@MWHPR11MB1918.namprd11.prod.outlook.com>
Date: Thu, 17 Sep 2020 19:51:32 +0200
Message-ID: <87een0z3yz.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>
Cc: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org


Hi,

Meng, Fino via Xenomai <xenomai@xenomai.org> writes:

>>Sent: Friday, September 18, 2020 12:53 AM
>>
>>Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
>>Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
>>---
>> kernel/cobalt/arch/x86/thread.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c index ba807ac1e..c33ad832f 100644
>>--- a/kernel/cobalt/arch/x86/thread.c
>>+++ b/kernel/cobalt/arch/x86/thread.c
>>@@ -26,6 +26,10 @@
>> #include <asm/mmu_context.h>
>> #include <asm/processor.h>
>>
>>+#ifdef IPIPE_X86_FPU_EAGER
>>+extern void fpu__initialize(struct fpu *fpu); #endif
>>+
>
> I sent the patch by  "mutt -H 0001-cobalt-x86-adapt-fpu-code-with-Linux-kernel-upstream.patch", but seems the received
> content is not match with my local patch: 
>
> +#ifdef IPIPE_X86_FPU_EAGER
> +extern void fpu__initialize(struct fpu *fpu);
> +#endif
> +
>
> However I failed to config git send-email, will continue to try tomorrow.
> the 4 patches are for the Xenomai core part of kernel 5.4's porting. 
>

Make sure to post to xenomai@xenomai.org, not xenomai-owner@xenomai.org
in --to. You have been talking to Mailman so far...

-- 
Philippe.

