Subject: Re: x86_64 kernel does not start under qemu
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <d2d0dff8-bfb6-6df2-6d0c-2fa0b4127d5f@siemens.com>
 <089ad64d-f76c-44a7-a1f4-75c215b6ab29@siemens.com>
 <3942851.pmMsEQ3ikD@blindfold>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77bd8c5c-9961-35f0-e2fd-4c6df8a78a14@siemens.com>
Date: Wed, 6 Mar 2019 17:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <3942851.pmMsEQ3ikD@blindfold>
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
To: Richard Weinberger <richard@nod.at>, "henning.schild@siemens.com" <henning.schild@siemens.com>
Cc: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 06.03.19 16:33, Richard Weinberger wrote:
> Am Mittwoch, 6. März 2019, 14:43:55 CET schrieb Jan Kiszka:
>> On 06.03.19 14:10, Jan Kiszka wrote:
>>> On 06.03.19 12:28, Lange Norbert via Xenomai wrote:
>>>> Hello,
>>>>
>>>> I have a similar issue on real hardware (cc Philippe). Can you try booting
>>>> with notscdeadline?
>>>>
>>>
>>> I would be surprised if it's that: QEMU does not emulate this APIC feature, only
>>> KVM does.
>>>
>>> I need to reproduce. Which QEMU version?
>>>
>>
>> Just booted current ipipe-x86-4.14.y (4.14.103) in QEMU 3.1+ (some development
>> snapshot) with -smp 4 - works fine. But these are likely quite a few variations
>> from your setup.
> 
> I'm on qemu 2.11.2.

That one might still be serializing SMP, thus only use one core on the host. 
Currently trying to emulate that as it changes timing.

> Is this plain ipipe? Just figured that you need to prepare the kernel
> with Xenomai to trigger the problem.
> Xenomai is 3.0.8.

I have Xenomai stable/v3.0.x running as well.

Jan

> 
> Kernel config is defconfig.
> 
> Thanks,
> //richard
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

