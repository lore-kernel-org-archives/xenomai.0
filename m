Subject: Re: [ANNOUNCE] Xenomai v3.1-rc3 available
References: <y27Ah4Xs-t8bhib0n5wvb0RE8X2b-B4GbVUz2PHHbETtMbl4SjmsFQP7GPGLfWozQrc_BW9MqoZFFIq0RYnMjvl_VQ0ecJz5Tp5fcaXPKcg=@codecraftsmen.org>
 <e2ceb276-09e5-2a11-ac34-3926668615e0@siemens.com>
 <6A8KLFuCLPtKt-g8GWZEP4G0rMK4ZA6RRo-1DSBHkySvKYcPcyydk9ON5HCyWrTPvdMz7BQdFAVYWPmkAs1zuogrEDjXI0dWDwVnFJYiIFc=@codecraftsmen.org>
 <ThBEK6LcImOy7l4McXiAt42fRQ1jdF6qmnYznYFw-AYdDnGzGhs3gs4FHzjpMJxODeg3PDylWkmWB1xgTr-b_wbB4eJ79rvqTny2vlYq9ZA=@codecraftsmen.org>
 <f5bfb2f7-6352-e49b-47a5-1efa06ca8a8d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <81b51127-ecdd-e3d2-050e-8f3e8f3dadd7@xenomai.org>
Date: Wed, 27 Nov 2019 17:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <f5bfb2f7-6352-e49b-47a5-1efa06ca8a8d@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/26/19 6:38 PM, Jan Kiszka via Xenomai wrote:
> On 26.11.19 18:29, Jeff Webb wrote:
>> On 11/15/19 5:14 PM, Jeff Webb via Xenomai wrote:
>>> On Friday, November 15, 2019 4:40 AM, Jan Kiszka
>>> <jan.kiszka@siemens.com> wrote:
>>>> On 15.11.19 01:31, Jeff Webb via Xenomai wrote:
>>>>> I am building a Xenomai cobalt kernel under Ubuntu 18.04 based on:
>>>>>
>>>>>       Linux 4.19.75
>>>>>       Xenomai 3.1-rc3
>>>>>       ipipe-core-4.19.75-x86-7.patch
>>>>>
>>>>>
>>>>> After running prepare-kernel.sh and "makeolddefconfig" (using the
>>>>> unmodified default .config), I get this error:
>>>>>
>>>>>       WARNING: unmet direct dependencies detected for PARAVIRT
>>>>>         Depends on [n]: HYPERVISOR_GUEST [=y] && !IPIPE [=y]
>>>>>         Selected by [m]:
>>>>>         - HYPERV [=m] && X86 [=y] && ACPI [=y] && X86_LOCAL_APIC [=y]
>>>>> && HYPERVISOR_GUEST [=y]
>>>>>
>>>>>
>>>>> I turned off HYPERVISOR_GUEST manually to fix the warning. I hadn't
>>>>> seen this type of error before, but perhaps something could be done in
>>>>> the patch to make the default config consistent... Just FYI.
>>>>
>>>> It's HYPERV what causes this, by also pulling PARAVIRT which is not
>>>> compatible with I-pipe. We need to tag that config as well to avoid this.
>>>>
>>>>> Otherwise, everything went fine with the build process and initial
>>>>> testing. I will be giving this build some more testing over the next
>>>>> week or so and will let you know if I find any issues.
>>>>
>>>> Great to hear, thanks.
>>>
>>> I haven't done extensive testing yet, but I tried several of our
>>> real-time applications with the new build, and things seem to be working
>>> so far.  Even on a different (but perhaps similar), older set of
>>> hardware from the one that has the intremap issues, I get the same
>>> kernel BUG messages (using the same 4.19 kernel build) mentioned in my
>>> other email:
>>>
>>>     https://xenomai.org/pipermail/xenomai/2019-November/041988.html
>>>
>>> but things appear to be functioning properly as far as I can tell.
>>>
>>> This is just some more feedback on the latest kernel / xenomai release
>>> candidate.
>>
>> All is going well so far with Xenomai v3.1-rc3 /
>> ipipe-core-4.19.84-x86-8.patch.  Given the recent patches posted to the
>> list, are there plans for another RC, or will the next release be the
>> official 3.1?
>>
> 
> Thanks for validating!
> 
> The scheduler changes qualify for another -rc, yes, I'm just waiting for an
> update from Philippe for a closing patch on this topic.
> 

Patiently reviewing all call sites kicking the rescheduling procedure here.
The picture does not look as simple as I originally thought. No blocker,
but a bit more work to prevent the root stage from rescheduling with hard
irqs on.

-- 
Philippe.

