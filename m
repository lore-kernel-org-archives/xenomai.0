References: <79e94bdb-b97c-6f65-c3e7-1a62793855e9@siemens.com>
 <87y29d42bm.fsf@xenomai.org>
 <b8fd767c-9adc-4fba-ac5c-cdafb8f03e0b@siemens.com>
 <87pmun4ztg.fsf@xenomai.org>
 <4b29def3-7900-7be2-a66b-e2e3482c9476@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Arm userland not building with gcc-9 and later
In-reply-to: <4b29def3-7900-7be2-a66b-e2e3482c9476@siemens.com>
Date: Sun, 08 Aug 2021 19:55:49 +0200
Message-ID: <87mtpr4y8q.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.08.21 19:21, Philippe Gerum wrote:
>>=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> On 07.08.21 19:00, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi all,
>>>>>
>>>>> just wanted to debug the RTnet issues we now see in CI on arm and arm=
64.
>>>>> I picked arm as first target, but that apparently starts to break with
>>>>> gcc-9 or newer (tried 9.2 and 10.2):
>>>>>
>>>>> make[5]: Entering directory '/xenomai/lib/cobalt/arch/arm'
>>>>>   CC       libarch_la-features.lo
>>>>> features.c: In function 'cobalt_arch_check_features':
>>>>> features.c:82:1: error: r7 cannot be used in 'asm' here
>>>>>    82 | }
>>>>>       | ^
>>>>>
>>>>> That seems to be related to passing the syscall number via r7 on ARM.=
 Is
>>>>> our ABI soon no longer compilable, or can we fix this?
>>>>>
>>>>
>>>> Just tried to reproduce this issue with the latest stable (10.3-2021.0=
7)
>>>> from ARM [1], and a fairly recent linaro snapshot (11.0.1-2021.03) [2],
>>>> to no avail. I tried with --enable-debug=3Dsymbols, --disable-debug,
>>>> --enable-debug=3Dfull, no issue so far.
>>>>
>>>> Can you please share you configure settings?
>>>
>>> I'm on ARM gcc 10.3-2021.07 as well. Debian's gcc from bullseye show=20
>>> this, too.
>>>
>>> ./configure --host=3Darm-none-linux-gnueabihf --enable-debug=3Dfull
>>>
>>> on master. And that results in
>>>
>>>   CC       libarch_la-features.lo
>>> ../../../../../lib/cobalt/arch/arm/features.c: In function =E2=80=98cob=
alt_arch_check_features=E2=80=99:
>>> ../../../../../lib/cobalt/arch/arm/features.c:82:1: error: r7 cannot be=
 used in =E2=80=98asm=E2=80=99 here
>>>    82 | }
>>>       | ^
>>>
>>=20
>> Confirmed, found it. next is fine with this compiler, which is the
>> version I tested. However, building stable and master does break.
>>=20
>
> Yeah, I've already pushed the two related fixes into next for testing.
> Can still be changed if we find a better solution.
>

Ack.

--=20
Philippe.

