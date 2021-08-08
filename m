Subject: Re: Arm userland not building with gcc-9 and later
References: <79e94bdb-b97c-6f65-c3e7-1a62793855e9@siemens.com>
 <87y29d42bm.fsf@xenomai.org>
 <b8fd767c-9adc-4fba-ac5c-cdafb8f03e0b@siemens.com>
 <87pmun4ztg.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b29def3-7900-7be2-a66b-e2e3482c9476@siemens.com>
Date: Sun, 8 Aug 2021 19:30:15 +0200
MIME-Version: 1.0
In-Reply-To: <87pmun4ztg.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

On 08.08.21 19:21, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 07.08.21 19:00, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi all,
>>>>
>>>> just wanted to debug the RTnet issues we now see in CI on arm and arm64.
>>>> I picked arm as first target, but that apparently starts to break with
>>>> gcc-9 or newer (tried 9.2 and 10.2):
>>>>
>>>> make[5]: Entering directory '/xenomai/lib/cobalt/arch/arm'
>>>>   CC       libarch_la-features.lo
>>>> features.c: In function 'cobalt_arch_check_features':
>>>> features.c:82:1: error: r7 cannot be used in 'asm' here
>>>>    82 | }
>>>>       | ^
>>>>
>>>> That seems to be related to passing the syscall number via r7 on ARM. Is
>>>> our ABI soon no longer compilable, or can we fix this?
>>>>
>>>
>>> Just tried to reproduce this issue with the latest stable (10.3-2021.07)
>>> from ARM [1], and a fairly recent linaro snapshot (11.0.1-2021.03) [2],
>>> to no avail. I tried with --enable-debug=symbols, --disable-debug,
>>> --enable-debug=full, no issue so far.
>>>
>>> Can you please share you configure settings?
>>
>> I'm on ARM gcc 10.3-2021.07 as well. Debian's gcc from bullseye show 
>> this, too.
>>
>> ./configure --host=arm-none-linux-gnueabihf --enable-debug=full
>>
>> on master. And that results in
>>
>>   CC       libarch_la-features.lo
>> ../../../../../lib/cobalt/arch/arm/features.c: In function ‘cobalt_arch_check_features’:
>> ../../../../../lib/cobalt/arch/arm/features.c:82:1: error: r7 cannot be used in ‘asm’ here
>>    82 | }
>>       | ^
>>
> 
> Confirmed, found it. next is fine with this compiler, which is the
> version I tested. However, building stable and master does break.
> 

Yeah, I've already pushed the two related fixes into next for testing.
Can still be changed if we find a better solution.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

