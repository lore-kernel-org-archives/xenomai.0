Subject: Re: [PATCH] cobalt/kernel: Simplify mayday processing
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
 <08f84d9f-594c-8d82-1da8-f747430226e3@xenomai.org>
 <3b2d567d-b489-723c-41de-9c73fb755763@siemens.com>
 <3327fb5d-3718-3e79-222a-d5730286af2e@xenomai.org>
 <3e3f0811-5528-2c7e-ef29-98b43c08c8a9@siemens.com>
 <d0c9d33a-6656-492c-7b42-7d37a37cb8a9@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44456958-6ebe-65aa-53e1-be118f838758@siemens.com>
Date: Wed, 28 Nov 2018 07:58:29 +0100
MIME-Version: 1.0
In-Reply-To: <d0c9d33a-6656-492c-7b42-7d37a37cb8a9@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

On 27.11.18 19:57, Philippe Gerum wrote:
> On 11/27/18 7:15 PM, Jan Kiszka wrote:
>> On 08.11.18 14:24, Philippe Gerum wrote:
>>> On 11/8/18 2:15 PM, Jan Kiszka wrote:
>>>> On 08.11.18 14:09, Philippe Gerum wrote:
>>>>> On 11/8/18 2:05 PM, Philippe Gerum via Xenomai wrote:
>>>>>> On 11/5/18 1:20 PM, Jan Kiszka wrote:
>>>>>>> The mayday mechanism exists in order to kick a xenomai userspace task
>>>>>>> into secondary mode while it is running userspace code. For that, we
>>>>>>> ask
>>>>>>> I-pipe to call us back when the task was interrupted and is about to
>>>>>>> return to userspace.
>>>>>>>
>>>>>>> So far we defer the relaxation from that callback via a VDSO-like
>>>>>>> mechanism that triggers a special syscall to the return path of that
>>>>>>> very same syscall. However, that is not desirable because it is a
>>>>>>> complex, arch-specific mechanism that can easily break and,
>>>>>>> specifically, that destroys the backtrace of ptraced tasks.
>>>>>>>
>>>>>>> Fortunately, we can fulfill the needs of mayday also by relaxing
>>>>>>> the task directly from the mayday callback. Tested successfully on
>>>>>>> x86-64 and ARM.
>>>>>>
>>>>>> ARM-wise, this change requires ipipe-core-4.14.71-arm-3 or later to
>>>>>> work
>>>>>> properly. This method would cause an interrupt state breakage with any
>>>>>> older ARM patch.
>>>>>>
>>>>>
>>>>> ppc32 is fine back to kernel 4.1 regarding this (did not check earlier
>>>>> stuff), and arm64 needs the 4.14-based split series to work properly
>>>>> (4.9 is wrong).
>>>>
>>>> Is the reason for arm64 on 4.9 the same as for arm?
>>>>
>>>
>>> Yes, same pattern.
>>>
>>
>> Is ARM64 on 4.9 considered stable?
> 
> I don't think so. I would recommend 4.14 as a stable starting point for
> Xenomai/arm64.
> 

Should we add a warning to the nucleus that triggers when ARM64 is built against 
<4.14?

The mayday issue would also be trivial to address in 4.9, 100% analogously to 
the ARM patches, but that would be pointless if no one should use that kernel 
for ARM64.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

