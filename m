Subject: Re: [PATCH 2/2] cobalt/arm: document the syscall convention
References: <20210524073240.450274-1-rpm@xenomai.org>
 <20210524073240.450274-2-rpm@xenomai.org>
 <06c8d4eb-7153-a48b-381e-81e129b27696@siemens.com>
 <87r1hvclst.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6b75920d-aef5-485c-6931-3b3e02f591df@siemens.com>
Date: Tue, 25 May 2021 09:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <87r1hvclst.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 25.05.21 09:30, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 24.05.21 09:32, Philippe Gerum wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  .../arm/include/asm/xenomai/uapi/syscall.h    | 31 ++++++++++++++++++-
>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
>>> index c079a358c..9146b732a 100644
>>> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
>>> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
>>> @@ -21,9 +21,38 @@
>>>  #ifndef _COBALT_ARM_ASM_UAPI_SYSCALL_H
>>>  #define _COBALT_ARM_ASM_UAPI_SYSCALL_H
>>>  
>>> +/*
>>> + * Argument marshalling for Cobalt syscalls:
>>> + *
>>> + * r7 := XENO_ARM_SYSCALL
>>> + * r0 := Cobalt syscall code (sc_cobalt_xx | __COBALT_SYSCALL_BIT)
>>> + * r1 := first argument
>>> + * r2 := second argument
>>> + * ...
>>> + * r5 := fifth argument
>>> + *
>>> + * r0 := <return value>
>>> + *
>>> + * This marshalling is common to the I-pipe and Dovetail-based
>>> + * configurations so that we have a single ABI convention for both,
>>> + * enabling us to have a single user build which does not depend on
>>> + * the pipeline type.  With Dovetail, CONFIG_IPIPE_COMPAT is enabled
>>> + * to allow this.
>>> + *
>>> + * __COBALT_SYSCALL_BIT is a generic marker for Cobalt system calls we
>>> + * use with all CPU architectures in common code, to distinguish them
>>> + * from native Linux syscalls. For this reason, it must be present in
>>> + * the Cobalt syscall code register (r0) as well.
>>
>> Could we please add the reason for why we have this deviation from the
>> kernel's ABI on ARM? One sentence is likely enough ("it makes things
>> much faster" or "needed because of limited free bits" or whatever), and
>> it would be a perfect place to drop it here.
>>
> 
> There is no reason. Just a fact of history.

That's good to hear: Time to clean up for 3.2. We are fine break ABIs on
major updates.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

