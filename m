Subject: Re: Does Xenomai 3.2.x work with 4.14.x kernels?
References: <3e06adcf-fa06-b69c-d91e-972f283d9b08@arcor.de>
 <83bc75cb-db19-1f89-a94c-93f7a7992386@siemens.com>
From: Scott Reed <scott.reed@arcor.de>
Message-ID: <a25b0564-9fc9-7687-ad5c-3c3452a26e12@arcor.de>
Date: Thu, 14 Apr 2022 18:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <83bc75cb-db19-1f89-a94c-93f7a7992386@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


On 4/13/22 8:57 PM, Jan Kiszka wrote:
> On 13.04.22 11:25, Scott Reed via Xenomai wrote:
>> Hello,
>>
>> I am trying to build a 4.14.110 kernel+ipipe+xenomai_3.2.7 and running into
>> issues when trying to compile. Namely, the 4.14.x kernel does not seem
>> to understand the "__kernel_timespec" struct.
>>
>> Is it known if Xenomai 3.2.x works with 4.14.x kernels?
> 
> We stopped supporting 4.14.x actively, and we apparently broke backward
> compatibility at some point. Locally likely fixable, but not
> maintainable for upstream anymore.> 

OK, so Xenomai 3.2.x does not work with Linux 4.14.x.

I am out of the office the next bit of time, but when I get back
I will check how easy local fixes are.

>>
>> Some background information
>> ---------------------------
>> Our platform is based on an ARM iMx6q.
>>
>> I have tried to move to a 5.4.x kernel, but ran into another issue
>> in that we have an RTDM driver which uses PCI MSI interrupts and
>> when I try to register the interrupt with rtdm_irq_request the
>> function returns EINVAL(-22).
>>
>> When working with a vanilla 5.4.x kernel and non-RTDM version of
>> the driver, there are no issues when registering the interrupt.
>>
>> I started to dive into this problem, but saw that as of kernel
>> 4.16, the PCI MSI interrupts for our platform have been changed
>> to be handled as chained interrupts.
>>
>> In this forum, I have seen multiple discussions and patches regarding
>> chained interrupts for X86, but not for ARM and began to think that
>> maybe chained interrupt support in xenomai is not complete for ARM.
>>
>> Could this be the case?
> 
> In fact, those patches are for ARM and not x86 (the latter was always
> fine). Please check latest ipipe-arm releases, or even dovetail (5.10+).
>

The patches I was referring to have to do with the handling of chained 
interrupts and not specifically PCIe MSI interrupts (which I understood 
work well on x86).

The connection for me between ARM PCIe MSI interrupt handling and chained
interrupts is that since Kernel 4.18 (misspoke above with 4.16), the DWC
PCIe host driver handles PCIe MSI interrupts as chained interrupts. The
patches have to do with chained interrupts and gpio RTDM driver which I 
think up until now was the only RTDM driver using chained interrupts.

I am thinking that the reason why when I try to register my PCIe MSI 
interrupt from my RTDM driver the rtdm_irq_request it returns 
EINVAL(-22) is tied to the fact that it is now chained interrupt.
Just a theory.

The patches I was referencing are:
  - [PATCH 3/6] x86/ipipe: fix chained irq handling
     https://xenomai.org/pipermail/xenomai/2020-September/043392.html
  - [PATCH 2/6] gpio: omap: irq_pipeline: enable out-of-band interrupt handling
     https://xenomai.org/pipermail/xenomai/2021-July/045935.html

Dealing with this seemed non-trivial to me and thus the back peddle
to a pre-4.18 kernel namely 4.14.
 
>>
>> For this reason, I backed down to the 4.14.x kernel, but now have run
>> into the compiling issue as mentioned at the start of this email.
> 
> When starting something new, do not use outdated kernels anymore.
> 

OK, I was not aware that 4.14.x is considered outdated.

>>
>> One last piece of background information, my initial motivation to move
>> to a new xenomai was that we moved to GCC 10.2 (in the meantime GCC 11.1)
>> and I was concerned regarding the ARM r7 register clobbering issues/patches
>> posted to the forum as I am fighting against a bug in our system where 
>> registers get corrupted albeit not r7 (typically r0 with a value of 
>> 0xFFFFFFFA (-38)). This problem seems to have come in after we upgraded
>> to GCC 10.2
> 
> If you are in hurry and have a working version based on older things,
> moving backward can be a valid intermediate options. But thinking ahead,
> using a mixture of old (kernel) and new (xenomai, toolchain) components
> is almost never a good idea: You are to far from mainstream, and piece
> will fill off left and right.
> 
> Jan
>

Thanks for the prompt reply and advice!

Short-term I need to get a version recipe that is stable for me which I was
hoping would be 4.14.x + Xenomai 3.2.1. Maybe still possible with local
changes as mentioned above.

Middle-term I want to get closer to mainstream and tried a month back
 - 5.10 + dovetail, but did not get far as with a vanilla 5.10 kernel my
   FEC port on my SECO iMx6q SOC did not work (bits on the line flipped.
   Maybe a clock issue??).
 - 5.4 + ipipe: Registering my RTDM interrupt fails (see above). Chained
   interrupt issue?? Not familiar with chained interrupts so looks for
   me to be non-trivial.

Scott

