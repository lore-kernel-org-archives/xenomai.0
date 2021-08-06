Subject: Re: Arm userland not building with gcc-9 and later
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <79e94bdb-b97c-6f65-c3e7-1a62793855e9@siemens.com>
 <874kc267pa.fsf@xenomai.org>
 <0aadf91d-5269-3e1b-13c4-7d79fbc0d335@siemens.com>
 <871r7666js.fsf@xenomai.org>
 <2ed731b6-7501-989c-6c1a-8a5569bb0cae@siemens.com>
Message-ID: <8fa1cd5f-337c-9f5c-1a3e-f20978b66ed0@siemens.com>
Date: Fri, 6 Aug 2021 19:12:39 +0200
MIME-Version: 1.0
In-Reply-To: <2ed731b6-7501-989c-6c1a-8a5569bb0cae@siemens.com>
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
Cc: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

On 06.08.21 18:16, Jan Kiszka wrote:
> On 06.08.21 15:34, Philippe Gerum wrote:
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 06.08.21 15:09, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi all,
>>>>>
>>>>> just wanted to debug the RTnet issues we now see in CI on arm and arm64.
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
>>>>> That seems to be related to passing the syscall number via r7 on ARM. Is
>>>>> our ABI soon no longer compilable, or can we fix this?
>>>>>
>>>>> Jan
>>>>
>>>> r7 may be used as a scratch register by gcc in some
>>>> cases. -fomit-frame-pointer for debug builds may help (i.e. when the
>>>> optimizer is switched off).
>>>>
>>>
>>> Good hint. I had --enable-debug=full set, and it builds without it (and
>>> now reports other issues that Debian's gcc-10 sees).
>>>
>>> But how to resolve this properly?
>>>
>>> Jan
>>
>> XENOMAI_SYSCALL2(sc_cobalt_archcall) in features.c is likely the issue.
>>
>> Either move those bits into some new syscall wrapper which would live in
>> lib/cobalt/internal.c, where there is no register allocation conflict so
>> far. Or discourage gcc from using r7 as a scratch register in
>> arm/features.c entirely? e.g.:
>>
>> diff --git a/lib/cobalt/arch/arm/Makefile.am b/lib/cobalt/arch/arm/Makefile.am
>> index a5095be3d..d5e542ebe 100644
>> --- a/lib/cobalt/arch/arm/Makefile.am
>> +++ b/lib/cobalt/arch/arm/Makefile.am
>> @@ -6,6 +6,7 @@ libarch_la_SOURCES = features.c
>>  
>>  libarch_la_CPPFLAGS =			\
>>  	@XENO_COBALT_CFLAGS@ 		\
>> +	-fomit-frame-pointer		\
>>  	-I$(srcdir)/../..		\
>>  	-I$(top_srcdir)/include/cobalt	\
>>  	-I$(top_srcdir)/include
>>
> 
> -fomit-frame-pointer does not help with -O0. It even keeps the problem
> alive with -O2.
> 
> Looks like arm needs a non-unlined helper function for syscalls, to be safe.
> 

What might be cheaper, a call-out to a helper or some push/pop around
the syscall like below? But I suspect the helper will do push/pop as well...

#define __SYS_CALLOP "push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

