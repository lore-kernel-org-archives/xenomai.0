Message-ID: <52F1FB24.4090603@siemens.com>
Date: Wed, 05 Feb 2014 09:49:40 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com> <52F1F749.2030501@xenomai.org>
In-Reply-To: <52F1F749.2030501@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-git@xenomai.org, xenomai@xenomai.org

On 2014-02-05 09:33, Philippe Gerum wrote:
> On 02/04/2014 07:03 PM, Jan Kiszka wrote:
>> On 2014-02-04 18:53, Philippe Gerum wrote:
>>> On 02/04/2014 06:48 PM, Philippe Gerum wrote:
>>>> On 02/04/2014 06:44 PM, Gilles Chanteperdrix wrote:
>>>>> On 02/04/2014 06:39 PM, Philippe Gerum wrote:
>>>>>> On 02/04/2014 06:32 PM, Gilles Chanteperdrix wrote:
>>>>>>> On 02/04/2014 06:27 PM, Philippe Gerum wrote:
>>>>>>>> If g++ chokes on the initializer part because it is outdated, then
>>>>>>>> using
>>>>>>>> old-fashioned ones may be an option. Actually, I find macroizing
>>>>>>>> this
>>>>>>>> definition quite bad.
>>>>>>>>
>>>>>>>> static const RT_TASK no_alchemy_task = {
>>>>>>>> -    .handle = 0,
>>>>>>>> -    .thread = 0
>>>>>>>> +    handle: 0,
>>>>>>>> +    thread: 0
>>>>>>>>      };
>>>>>>>
>>>>>>> No, the previous version is better, it is standard compliant C and
>>>>>>> C++,
>>>>>>> the second version is a gcc extension, which works only when
>>>>>>> compiling
>>>>>>> C, if I remember correctly.
>>>>>>>
>>>>>>
>>>>>> Recent g++ is happy with both (no -std forced though). But the
>>>>>> former is
>>>>>> allowed by the C++ parser only since recently.
>>>>>>
>>>>>
>>>>> Well, on the other hand:
>>>>> static const RT_TAKS no_alchemy_task;
>>>>>
>>>>> Will zero initialized the structure just as well...
>>>>>
>>>>
>>>> In that case you will have the object exist in the .bss.
>>>>
>>>
>>> It turns out that old gcc 4.x releases will create a private bss entry
>>> for this symbol in any case, which recent ones won't produce regardless
>>> of the optimizing level (unless I messed up with nm, but it does not
>>> seem so).
>>>
>>
>> Then what is so bad about the symbolic NO_ALCHEMY_TASK? The code will be
>> the same anyway.
>>
>> BTW, there are way more issues with C++ when enabling standard
>> compliance. Not sure where all the errors come from and if they easy to
>> fixing. But I think we should try to be as clean as possible in out
>> external interfaces.
>>
> 
> Mmm, no. I don't want to rush merging all kinds of isolated fixes for
> all sorts of pedantic modes. I see the other one following with typeof
> constructs, later we will get other changes triggered by other
> restrictions on gcc extensions, and this general trend is not
> acceptable. The fact that the external API headers still share portions
> with the implementation does not help, but this is not a reason for
> downgrading the C dialect of the latter with ugly work arounds.
> 
> If you really want to go this way, I suggest that you issue a single,
> all-in-one patch making the current code base conforming with the C/C++
> standard you aim at, so that we have a general overview of the changes.
> With that information, we should be able to address strict standard
> conformance better, which may involve addressing the
> interface/implementation issue with headers.

It's pointless to make the core standard-compliant, C or even C++. But
we are exposing an interface that definitely has to be compatible with
C++ (most of my patches) as we do not have control over the user's
toolchain and language (there would be no good reason to restrict it).
And if it is trivial to get the interface even ANSI compliant (last
patch) and also recommended by GCC to do so in libraries, what pain does
it cause to us to follow this road?

Yes, the amount of internals currently exposed via the external headers
should be optimized. But I guess this is something to be done as cleanup
once the code base, including Mercury, settled a bit more.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

