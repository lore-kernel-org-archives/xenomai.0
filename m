Subject: Re: Weird page fault while debugging an application using gdbserver
References: <b80-5dc44e80-14f-62bca880@213436924>
 <e43762f0-b844-d51b-eeef-46ad9c4dbde8@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1eab7ce4-4c73-48ad-69d7-b0b3d2d6cab1@siemens.com>
Date: Fri, 8 Nov 2019 10:22:24 +0100
MIME-Version: 1.0
In-Reply-To: <e43762f0-b844-d51b-eeef-46ad9c4dbde8@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 08.11.19 10:05, Philippe Gerum via Xenomai wrote:
> On 2019-11-07 18:03, François Legal wrote:
>> Le Jeudi, Novembre 07, 2019 16:54 CET, Philippe Gerum <rpm@xenomai.org> a écrit:
>>   
>>> On 2019-11-07 16:37, François Legal via Xenomai wrote:
>>>> Hello,
>>>>
>>>> I'm porting an existing application to xenomai, and trying to debug it using GDBserver.
>>>> I try to set a break to stop at some interesting point in execution. That break is never reached, and each time I get the page fault error with the log copied at the end of the message.
>>>> After that, I get the debug feature of the network driver automatically activated.
>>>>
>>>> Starngely enought, the backtrace does not point to my application code, rather in linux kernel/drivers.
>>>>
>>>> The system is an Arm7 Zynq 7000 reference board, being debugged via ethernet.
>>>> Running linux 4.4.189 vanilla + corresponding ipipe patch and xenomai 3.0.9
>>>
>>> You likely need the following patch. This issue was fixed in the 4.14 time frame:
>>>
>>> commit 8575e8ab404717e3eabafc36920459018bb052a3
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Tue Apr 10 11:34:29 2018 +0200
>>>
>>>      arm/ipipe: re-enable user access in DAC after und_user trap handling
>>>      
>>>      Before returning from an und_user fault we have been asked to
>>>      propagate, the client trap handler might have demoted the caller from
>>>      the head -> root stage, which boils down to performing a (double)
>>>      context switch internally. If CONFIG_CPU_SW_DOMAIN_PAN is set, such
>>>      transition would cause the DAC register to reflect a protected USER
>>>      domain state, denying to the kernel access to user memory.
>>>      
>>>      We need to revert this change, restoring the expected domain
>>>      protection settings originally set by usr_entry.
>>>      
>>>      This fixes page domain errors raised by running into breakpoint traps
>>>      poked by GDB into the debuggee's executable image when
>>>      CONFIG_CPU_SW_DOMAIN_PAN is enabled in the kernel configuration.
>>>
>>> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
>>> index cd2e0b3d8336..3569b3174372 100644
>>> --- a/arch/arm/kernel/entry-armv.S
>>> +++ b/arch/arm/kernel/entry-armv.S
>>> @@ -524,6 +524,7 @@ __und_usr:
>>>   	bl	__ipipe_notify_trap		@ branch to trap handler
>>>   	cmp	r0, #0
>>>   	bne	ret_from_exception
>>> +	uaccess_enable ip
>>>   #endif /* CONFIG_IPIPE */
>>>   
>>>   	mov	r2, r4
>>>
>>> -- 
>>> Philippe.
>>   
>>   Thanks. I do not get the page fault anymore, however, I seem to be unable to halt on breakpoints now.
>>
> 
> Just checked with 4.4.176-arm-10 + this patch, no issue setting and taking a breakpoint in a simple demo program using gdb directly. You may want to check if gdbserver is not involved in the remaining issue. At any rate, the change proposed would not prevent the debug exception to be taken (on the contrary, actually).
> 

I guess that patch would nice to have in ipipe-4.4.y-cip as well. Is 
there more to pick from new kernels?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

