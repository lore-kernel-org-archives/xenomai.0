Subject: Re: dovetail: add prctl() call form
References: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
 <87a6iepm0x.fsf@xenomai.org>
 <f636f600-cf0f-54fd-149d-003fc2d10c28@siemens.com>
 <871r3ppq5w.fsf@xenomai.org>
 <dba3602a-a80f-7628-6166-2e7bda09d177@siemens.com>
 <87k0hhdwkn.fsf@xenomai.org>
 <5fae03f0-0129-05b6-fcce-0be07707a501@siemens.com>
 <875yt0ct4b.fsf@xenomai.org>
 <345ce43f-ce6f-703f-89b2-b82b3fa5b4c6@siemens.com>
 <87y25wbcu2.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a41295f-63f0-c6e7-5769-8c19b2235051@siemens.com>
Date: Wed, 10 Nov 2021 12:03:51 +0100
MIME-Version: 1.0
In-Reply-To: <87y25wbcu2.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>

On 10.11.21 09:58, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 10.11.21 08:38, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 09.11.21 14:35, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 09.11.21 11:23, Philippe Gerum wrote:
>>>>>>>
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> On 08.11.21 18:57, Philippe Gerum wrote:
>>>>>>>>>
>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>
>>>>>>>>>> Hi Philippe,
>>>>>>>>>>
>>>>>>>>>> this dovetail commit makes the pipeline go red, crashing the kernels
>>>>>>>>>> (e.g. [1][2]). I hope this is something we can quickly fix in dovetail,
>>>>>>>>>> maybe via a config option?
>>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348118#L966
>>>>>>>>>> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348121#L1429
>>>>>>>>>
>>>>>>>>> Cobalt needs some update to cope with this now. I'll send a fix either
>>>>>>>>> way (dovetail or xenomai) tomorrow morning.
>>>>>>>>
>>>>>>>> This should be fixed in dovetail - API breakage. We can update Xenomai
>>>>>>>> later, along with enabling this feature again.
>>>>>>>>
>>>>>>>
>>>>>>> We now have a change in the Dovetail tree which handles the fact that
>>>>>>> some Dovetail-based core might lag behind a bit API-wise regarding the
>>>>>>> new prctl-based call form. Since this simplifies the handling for any
>>>>>>> companion core in that particular case, this seems legitimate to add
>>>>>>> it. Tested on kvm-x86, -aarch64, and i.MX6-sabre with both Cobalt and
>>>>>>> EVL cores. Both test suites run properly, so far so good.
>>>>>>
>>>>>> I'm not against this change, but activating it is no Xenomai 3.2
>>>>>> material as it will break the ABI.
>>>>>
>>>>> No, the ABI has never been affected by this series, the old call form
>>>>> Cobalt uses is still supported, the new prctl() call form is a mere
>>>>> addition, not a replacement. The problem did only affect the kernel
>>>>> interface between the pipeline core and Cobalt, which is strictly a
>>>>> kernel API issue, not revealed by my tests mainly with Xenomai4/EVL
>>>>> unfortunately.
>>>>
>>>> The whole purpose of having this addition is using it. And that does
>>>> make a lot of sense, as you described. So the plan is to activate AND
>>>> use this feature in Xenomai 3.3 - with the aforementioned impact on the ABI.
>>>>
>>>> Xenomai 3.2 will continue to use the old syscall range extension scheme,
>>>> thus as no need and no desire to enable reporting of prctl calls to the
>>>> core. Therefore, Dovetail should continue to refrain from doing that for
>>>> Xenomai 3.2. The easiest way to achieve that is making the extension
>>>> build-time configurable. Other cores can then still enable it for their
>>>> *use*, and the fresh Xenomai 3.2 release will not break over the next
>>>> dovetail patch revision (which is urgently needed do to the apic-ack fix).
>>>>
>>>> Makes sense?
>>>>
>>>
>>> It falls short of solving the real problem.
>>
>> Nor does your approach. If it were consequently ignoring stable
>> interfaces - there is no need for it in your in-tree model -, it would
>> have simply dropped the old syscall interface. Instead, it only provided
>> a half-stable solution for its users.
>>
> 
> It looks ok so far on this end, thanks for caring anyway.
> 
>>>
>>>> I really like to avoid avoid diverging developments again, but stability
>>>> trumps features and would enforce this if we cannot find a better solution.
>>>>
>>>
>>> I agree, the best way is to decouple the code bases at this point, so
>>> that all development efforts can progress at their own pace, according
>>> to their own agenda and schedule, which are not compatible. Opening a
>>> new tree for maintaining a Xenomai3-specific pipeline will:
>>>
>>> - make things clearer to Xenomai3 users, providing them an unambiguous
>>>   source for getting Dovetail support that works for it.
>>>
>>> - give you full control over this Dovetail tree, what goes there from
>>>   the upstream code and what does not, when it does if it does.
>>>
>>> - keep all options open for the Dovetail upstream development.  The
>>>   whole point of starting Dovetail was to be able to evolve the dual
>>>   kernel integration technique based on the evolving implementation of
>>>   the mainline kernel, instead of being stuck for ages with legacy
>>>   kernel interfaces. Kernel API changes are part of this process.
>>>
>>> We can cross-pollinate the trees, until Xenomai3 rebases on the next
>>> linux SLTS release which Dovetail upstream would support, and so on.
>>>
>>
>> As I said, this is very unfortunate, and I hope you will reconsider your
>> decisions.
>>
> 
> I don't think this is a bad thing. This clarifies the intent, making
> things easier in the long run.
> 
>> Meanwhile, I will stop 5.10.y-dovetail and instead start
>> linux-dovetail-stable.git with related branches. CI will be migrated as
>> well, stopping coverage of linux-dovetail head.
> 
> Please call it linux-xenomai3-dovetail or anything you see fit except
> linux-dovetail-stable. Stability has a different meaning, and this name
> should be reserved for an upstream Dovetail tree. TIA,
> 

The result will not be Xenomai 3 specific. It will just use stable APIs
as additional requirement, perform the merge-based development process
for stable branches and provide regular CI-qualified releases again.
Just like under I-pipe.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

