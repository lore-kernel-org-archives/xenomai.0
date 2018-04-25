From: Philippe Gerum <rpm@xenomai.org>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <1542961.KC98kqrEBl@wirbelwind>
 <cad2a4c9f8b749109afff86f3ef0f201@advaoptical.com>
 <80155073.HUEqfJo2pc@wirbelwind>
 <b2cbe5362c38461d9a2eb817b78fb633@EDB3.wapice.localdomain>
Message-ID: <4715a857-f535-fe49-2506-5abbb16553ed@xenomai.org>
Date: Wed, 25 Apr 2018 18:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <b2cbe5362c38461d9a2eb817b78fb633@EDB3.wapice.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>, Sagi Maimon <SMaimon@advaoptical.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Adnan Ali <adnan.ali@wapice.com>, Sakari Junnila <sakari.junnila@wapice.com>, "Seeger,
 Steven D. (GSFC-444.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>

On 04/25/2018 10:54 AM, Jouko Haapaluoma wrote:
> On Mon, Apr 02, 2018 at 12:56:39PM +0000, Sagi Maimon wrote:
>> Hi all,
>> I am working with: Powerpc e300 SOC.
>> I am using: xenomai-2.6.4 version
>>
>> I am experiencing this exception on my Linux :
>> Unrecoverable FP Unavailable Exception 801 at c0003858
>> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
>>
>> This happens during "alignment exception" (600)
> 
> Hello
> 
> We have also seen this issue recently with Xenomai 2.6.4 and i-pipe 3.1.10-powerpc-2.13-06.
> 
> We have been investigating this and Adnan found that the issue seems to be in arch/powerpc/kernel/process.c: enable_kernel_fp().
> 
> In this function the irqs are disabled and enabled by calling local_irq_save_hw_cond() and local_irq_restore_hw_cond(). In between the FP bit is enabled and written to MSR in giveup_fpu(). However, the local_irq_restore_hw_cond() restores the previous MSR which does not have the FP bit enabled and this leads to the exception 801.
> 
> We have briefly tested that the exception 801 does not occur with the following patch:
> 
> --- a/arch/powerpc/kernel/process.c	2018-04-24 15:54:10.164558970 +0300
> +++ b/arch/powerpc/kernel/process_new.c	2018-04-24 15:53:30.635567659 +0300
> @@ -114,6 +114,11 @@ void enable_kernel_fp(void)
>  #else
>  	giveup_fpu(last_task_used_math);
>  #endif /* CONFIG_SMP */
> +	/*
> +	 * giveup_fpu sets the FP bit in MSR, toggling it off would cause
> +	 * unavailable FP kernel panic. So, keep it on if it was set.
> +	 */
> +	flags |= (mfmsr() & MSR_FP);
>  	local_irq_restore_hw_cond(flags);
>  }
>  EXPORT_SYMBOL(enable_kernel_fp);
> 
> It seems that the implementation is quite similar also in the current I-pipe branch ipipe-4.9.y (only the FP bit is set by msr_check_and_set() and not in giveup_fpu). Therefore the problem seems to exist also in the latest i-pipe.
> 
> Is our fix correct or have we missed something?
> 

The fix makes a lot of sense, thanks. This bug slipped under the radar
for years likely because enabling the ppc fpu in kernel context mainly
happens when fixing up alignment issues, which rt apps tend to avoid in
the first place for performance reason by only using aligned memory
accesses (synchronous exceptions are not that cheap latency-wise).

Regarding the ipipe-4.9.y series, there are several other spots touching
the msr in this file which may be affected the same way (vsx, altivec,
spe, anything that involves calling msr_check_and_set/clear_msr() under
hard masking basically).

Adding a dedicated irq_restore helper which does not touch any other bit
aside of MSR_EE would make sense there. The BOOK-E version of
irq_save/restore specifically uses the wrtee* instructions not to touch
those bits, so we may assume this would be semantically correct to do
the same for BOOK3-S.

PS: CCing Steven who took over the maintenance of the ppc pipeline from
kernel 4.14 and on.

-- 
Philippe.

