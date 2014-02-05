Message-ID: <52F20E32.3010706@xenomai.org>
Date: Wed, 05 Feb 2014 11:10:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com> <52F1F749.2030501@xenomai.org>
 <52F1FB24.4090603@siemens.com> <52F1FD3B.1070304@xenomai.org>
 <52F1FEFC.9070708@siemens.com> <52F20604.4020200@xenomai.org>
 <52F20780.9010002@siemens.com>
In-Reply-To: <52F20780.9010002@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 02/05/2014 10:42 AM, Jan Kiszka wrote:
> On 2014-02-05 10:36, Philippe Gerum wrote:
>> On 02/05/2014 10:06 AM, Jan Kiszka wrote:
>>> On 2014-02-05 09:58, Philippe Gerum wrote:
>>>> On 02/05/2014 09:49 AM, Jan Kiszka wrote:
>>>>> On 2014-02-05 09:33, Philippe Gerum wrote:
>>>>>> On 02/04/2014 07:03 PM, Jan Kiszka wrote:
>>>>>>> On 2014-02-04 18:53, Philippe Gerum wrote:
>>>>>>>> On 02/04/2014 06:48 PM, Philippe Gerum wrote:
>>>>>>>>> On 02/04/2014 06:44 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 02/04/2014 06:39 PM, Philippe Gerum wrote:
>>>>>>>>>>> On 02/04/2014 06:32 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>>> On 02/04/2014 06:27 PM, Philippe Gerum wrote:
>>>>>>>>>>>>> If g++ chokes on the initializer part because it is outdated,
>>>>>>>>>>>>> then
>>>>>>>>>>>>> using
>>>>>>>>>>>>> old-fashioned ones may be an option. Actually, I find
>>>>>>>>>>>>> macroizing
>>>>>>>>>>>>> this
>>>>>>>>>>>>> definition quite bad.
>>>>>>>>>>>>>
>>>>>>>>>>>>> static const RT_TASK no_alchemy_task = {
>>>>>>>>>>>>> -    .handle = 0,
>>>>>>>>>>>>> -    .thread = 0
>>>>>>>>>>>>> +    handle: 0,
>>>>>>>>>>>>> +    thread: 0
>>>>>>>>>>>>>         };
>>>>>>>>>>>>
>>>>>>>>>>>> No, the previous version is better, it is standard compliant
>>>>>>>>>>>> C and
>>>>>>>>>>>> C++,
>>>>>>>>>>>> the second version is a gcc extension, which works only when
>>>>>>>>>>>> compiling
>>>>>>>>>>>> C, if I remember correctly.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Recent g++ is happy with both (no -std forced though). But the
>>>>>>>>>>> former is
>>>>>>>>>>> allowed by the C++ parser only since recently.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Well, on the other hand:
>>>>>>>>>> static const RT_TAKS no_alchemy_task;
>>>>>>>>>>
>>>>>>>>>> Will zero initialized the structure just as well...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In that case you will have the object exist in the .bss.
>>>>>>>>>
>>>>>>>>
>>>>>>>> It turns out that old gcc 4.x releases will create a private bss
>>>>>>>> entry
>>>>>>>> for this symbol in any case, which recent ones won't produce
>>>>>>>> regardless
>>>>>>>> of the optimizing level (unless I messed up with nm, but it does not
>>>>>>>> seem so).
>>>>>>>>
>>>>>>>
>>>>>>> Then what is so bad about the symbolic NO_ALCHEMY_TASK? The code
>>>>>>> will be
>>>>>>> the same anyway.
>>>>>>>
>>>>>>> BTW, there are way more issues with C++ when enabling standard
>>>>>>> compliance. Not sure where all the errors come from and if they
>>>>>>> easy to
>>>>>>> fixing. But I think we should try to be as clean as possible in out
>>>>>>> external interfaces.
>>>>>>>
>>>>>>
>>>>>> Mmm, no. I don't want to rush merging all kinds of isolated fixes for
>>>>>> all sorts of pedantic modes. I see the other one following with typeof
>>>>>> constructs, later we will get other changes triggered by other
>>>>>> restrictions on gcc extensions, and this general trend is not
>>>>>> acceptable. The fact that the external API headers still share
>>>>>> portions
>>>>>> with the implementation does not help, but this is not a reason for
>>>>>> downgrading the C dialect of the latter with ugly work arounds.
>>>>>>
>>>>>> If you really want to go this way, I suggest that you issue a single,
>>>>>> all-in-one patch making the current code base conforming with the
>>>>>> C/C++
>>>>>> standard you aim at, so that we have a general overview of the
>>>>>> changes.
>>>>>> With that information, we should be able to address strict standard
>>>>>> conformance better, which may involve addressing the
>>>>>> interface/implementation issue with headers.
>>>>>
>>>>> It's pointless to make the core standard-compliant, C or even C++. But
>>>>
>>>> This has never been considered for sure.
>>>>
>>>>> we are exposing an interface that definitely has to be compatible with
>>>>> C++ (most of my patches) as we do not have control over the user's
>>>>> toolchain and language (there would be no good reason to restrict it).
>>>>> And if it is trivial to get the interface even ANSI compliant (last
>>>>> patch) and also recommended by GCC to do so in libraries, what pain
>>>>> does
>>>>> it cause to us to follow this road?
>>>>>
>>>>
>>>> The pain is that we seem to be adding more and more restrictions to the
>>>> C dialect usable by the implementation, because of that sharing with the
>>>> interface. This is not acceptable.
>>>
>>> Were do we restrict us here? Give me one example.
>>
>> Forcing cast on assigning generic pointers is a restriction, the same
>> way disabling arithmetic on them is yet another artificial restriction
>> with absolutely no upside on our side, only obfuscation.
>
> Unfortunately required for ordinary C++ support, not only strict
> standard compliance. So it is pointless to moan about it IMHO - unless
> we want to drop C++ completely.
>
>>
>>>
>>>>
>>>>> Yes, the amount of internals currently exposed via the external headers
>>>>> should be optimized. But I guess this is something to be done as
>>>>> cleanup
>>>>> once the code base, including Mercury, settled a bit more.
>>>>>
>>>>
>>>> This is a copperplate issue, regardless of whether you stack it over the
>>>> dual or single kernel system, and in this respect, the copperplate API
>>>> is stable (although I really have to document it at some point though).
>>>
>>> Well, I can have a look at that patch again and try to get those inline
>>> helpers out of the public. Or are they supposed to be used, directly or
>>> indirectly, by applications?
>>
>> Some of them may be, such as pvmalloc(), which guarantees a rt-capable,
>> private memory allocation regardless of the underlying real-time core.
>> Others won't, such as all of the threadobj_* routines, which are for
>> API/skin designers instead.
>>
>> This is the reason why I suggest again to have all the required changes
>> for building for -ansi/c++11 introduced in place first, without even
>> trying to move code around, all in a single patch. With that
>> information, we may then define some coding rules for the exposed API
>> headers for the future, and possibly rearrange the implementation so
>> that it is not exposed uselessly to external interfaces.
>
> So you just want me to fold patch 2 and 3 together? I don't fully get it
> yet.

I'm asking for a clarification: do you have more patches following these 
two? I understood from the past conversation that more work was 
required, so I'm assuming you will have. If so, then we may save a lot 
of time by seeing the complete change set that would fit the bill for 
supporting standard C/C++ restrictions, the way your current port work 
seems to require it.

>
>>
>>>
>>> The no_alchemy_task thing is not a dialect issue, so I think it's clear
>>> now.
>>
>> This issue is only relevant to how smart the compiler you use is with
>> respect to optimizing the output, when it sees a statically-scoped
>> variable which is explicitly read-only.
>
> Right, so one of the issue it causes has nothing to do with [strict] C++
> compliance.

Which is the reason why I tend to suspect patches claiming about fixing 
some perceived ugliness, factual information is better. This construct 
is valid, but does not fit well with the gcc release you are aiming at, 
which is another issue. Xenomai 3.x does impose minimum requirements on 
the compiler/toolchain, including sane/working support of builtin sync 
primitives and tls.

In this respect, your patch about no_alchemy_task would have been better 
explained by the goal of not depending on too recent optimizers, which 
does make sense to me. The language is important so that my limited 
mono-neuronal brain can deal with your commit logs.

>
>>
>>   And the __typeof__ is, IMHO, also clear as gcc clearly recommends
>>> to use the underscore version in public headers. And that's all.
>>>
>>
>> I don't have any issue with using the alternative keywords to please
>> compilers switched to pedantic mode, just like I'm usually preferring
>> __asm__ over asm in code. The fact that I'm arguing about some of the
>> proposed changes toward supporting -ansi or -std=<whatever>, does not
>> mean that I'm asking for all changes to be dropped mindlessly.
>
> Again, the typeof is for ansi, the rest is for [gcc-]C++.
>

By pedantic mode, I do mean strict -ansi. So we basically agree. Again.

-- 
Philippe.

