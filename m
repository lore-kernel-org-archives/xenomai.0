Message-ID: <437466fb-9835-b8eb-652e-556e5a636908@siemens.com>
Date: Tue, 14 Jun 2022 20:11:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86: ipipe: Enable FPU tests unconditionally
Content-Language: en-US
References: <20220525095627.40521-1-florian.bezdeka@siemens.com>
 <20220525095627.40521-3-florian.bezdeka@siemens.com>
 <f8c2aab0-03a1-76a4-c484-0cfe55308c6c@siemens.com>
 <5d33d62362ec47029af74396682292f756f0de25.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5d33d62362ec47029af74396682292f756f0de25.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.06.22 18:59, Bezdeka, Florian (T CED SES-DE) wrote:
> On Wed, 2022-06-08 at 17:02 +0200, Jan Kiszka wrote:
>> On 25.05.22 11:56, Florian Bezdeka wrote:
>>> Parts of the FPU tests were skipped when one of the following config
>>> options was enabled, shadowing a real test issue that was triggered by
>>> high load on the system. The options:
>>>   - CONFIG_X86_USE_3DNOW
>>>   - CONFIG_MD_RAID456
>>>   - CONFIG_MD_RAID456_MODULE
>>>
>>> As the FPU initialization is fixed now, we can enable the tests
>>> unconditionally.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  .../arch/x86/ipipe/include/asm/xenomai/fptest.h     | 13 -------------
>>>  1 file changed, 13 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
>>> index ccf7afa11..7a2b17d75 100644
>>> --- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
>>> +++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
>>> @@ -36,19 +36,6 @@ static inline void fp_init(void)
>>>
>>>  static inline int fp_linux_begin(void)
>>>  {
>>> -#if defined(CONFIG_X86_USE_3DNOW) \
>>> -   || defined(CONFIG_MD_RAID456) || defined(CONFIG_MD_RAID456_MODULE)
>>> -   /* Ther kernel uses x86 FPU, we can not also use it in our tests. */
>>> -   static int once = 0;
>>> -   if (!once) {
>>> -           once = 1;
>>> -           printk("%s:%d: Warning: Linux is compiled to use FPU in "
>>> -                  "kernel-space.\nFor this reason, switchtest can not "
>>> -                  "test using FPU in Linux kernel-space.\n",
>>> -                  __FILE__, __LINE__);
>>> -   }
>>> -   return -EBUSY;
>>> -#endif /* 3DNow or RAID 456 */
>>>     kernel_fpu_begin();
>>>     /* kernel_fpu_begin() does no re-initialize the fpu context, but
>>>        fp_regs_set() implicitely expects an initialized fpu context, so
>>
>> Hmm, I'm not yet fully convinced from reading both commit logs that the
>> one fix actually obsoletes this check. Did it really only paper over a
>> simple bug?
> 
> I don't have the full history here, but it seems that this was kind of
> double protection.
> 
> So far all tests did not bring up any further issues.
> 
> On systems with RAID (=systems with one of the mentioned options
> enabled) FPU usage is much more likely and bugs would trigger more
> likely. I would like to enable the FPU systems especially on such
> systems.
> 
> But: In case we have more undiscovered bugs in this area, it might
> happen that we damage a RAID based file system. It seems Gilles had
> such a system and tried to prevent FS damage this way.
> 

OK, it's just a test setup in the end - let's dare it.

Applied both to stable/v3.2.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

