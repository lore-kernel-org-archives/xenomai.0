Subject: Re: x86_64 kernel does not start under qemu
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <3942851.pmMsEQ3ikD@blindfold>
 <77bd8c5c-9961-35f0-e2fd-4c6df8a78a14@siemens.com>
 <2063425.dnF2CDgauY@blindfold>
 <73309048-fefd-20a4-31ae-1ce41b0fb8a6@siemens.com>
Message-ID: <ddd256e9-0e93-30bc-ddf0-e4f333d24d7f@siemens.com>
Date: Thu, 21 Mar 2019 12:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <73309048-fefd-20a4-31ae-1ce41b0fb8a6@siemens.com>
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
To: Richard Weinberger <richard@nod.at>
Cc: "henning.schild@siemens.com" <henning.schild@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 08.03.19 12:28, Jan Kiszka wrote:
> On 08.03.19 12:19, Richard Weinberger wrote:
>> Am Mittwoch, 6. März 2019, 17:39:38 CET schrieb Jan Kiszka:
>>> On 06.03.19 16:33, Richard Weinberger wrote:
>>>> Am Mittwoch, 6. März 2019, 14:43:55 CET schrieb Jan Kiszka:
>>>>> On 06.03.19 14:10, Jan Kiszka wrote:
>>>>>> On 06.03.19 12:28, Lange Norbert via Xenomai wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I have a similar issue on real hardware (cc Philippe). Can you try booting
>>>>>>> with notscdeadline?
>>>>>>>
>>>>>>
>>>>>> I would be surprised if it's that: QEMU does not emulate this APIC 
>>>>>> feature, only
>>>>>> KVM does.
>>>>>>
>>>>>> I need to reproduce. Which QEMU version?
>>>>>>
>>>>>
>>>>> Just booted current ipipe-x86-4.14.y (4.14.103) in QEMU 3.1+ (some development
>>>>> snapshot) with -smp 4 - works fine. But these are likely quite a few 
>>>>> variations
>>>>> from your setup.
>>>>
>>>> I'm on qemu 2.11.2.
>>>
>>> That one might still be serializing SMP, thus only use one core on the host.
>>
>> Well, why is this a problem for Xenomai?
>> Does it deadlock if you have more than one cpu and these are not truly parallel?
>> This seems a little odd to me.
> 
> I the past, this de-parallelization triggered race conditions more easily as it 
> widened the race windows massively. Whatever came out of it remained a Xenomai 
> or I-pipe bug that could theoretically occur on real hardware as well.
> 
>>
>>> Currently trying to emulate that as it changes timing.
>>
>> Just retried with latest qemu (v3.1.0-2421-g9b748c5e061b), same problem.
> 
> Yeah, I suspect the kernel config. Didn't have time to try defconfig so far.
> 
>>>> Is this plain ipipe? Just figured that you need to prepare the kernel
>>>> with Xenomai to trigger the problem.
>>>> Xenomai is 3.0.8.
>>>
>>> I have Xenomai stable/v3.0.x running as well.
>>
>> What kernel config are you using and what is your qemu command line?
> 
> Currently used config attached, command line:
> 
> qemu-system-x86_64 -drive file=/path/disk.img,discard=unmap,if=none,id=disk 
> -device ide-hd,drive=disk -snapshot -m 1G -serial mon:stdio -s -smp 4 -machine 
> q35,pit=off -fsdev local,path=/path/shared,security_model=none,id=vfs -device 
> virtio-9p-pci,addr=1f.7,mount_tag=host,fsdev=vfs
> 

FWIW, I've just seen this issue as well, with QEMU in KVM mode: I ran into that 
lockup when my host was under full load while Xenomai booted in the VM. And it 
seems reproducible. Debugging...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

