Message-ID: <4BCC78D5.3010405@domain.hid>
Date: Mon, 19 Apr 2010 17:37:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid> <4BCC6CEE.70907@domain.hid>
	<4BCC6E3C.3090301@domain.hid> <4BCC7092.1030809@domain.hid>
	<4BCC71AF.4030903@domain.hid> <4BCC77BD.9040900@domain.hid>
In-Reply-To: <4BCC77BD.9040900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] fix XENO_OPT_DEBUG bugs.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I found some code which was referencing directly some
>>>>>> CONFIG_XENO_OPT_DEBUG_ variables with things like:
>>>>>>
>>>>>> #ifdef CONFIG_XENO_OPT_DEBUG_FOO
>>>>>>
>>>>>> This usage is incompatible with the pre-requisites of the assert.h
>>>>>> header that CONFIG_XENO_OPT_DEBUG_FOO should be defined at all times.
>>>>>> While grepping for CONFIG_XENO_OPT_DEBUG_, I found that we also have
>>>>>> many duplicates of construction like:
>>>>>> #ifndef CONFIG_XENO_OPT_DEBUG_FOO
>>>>>> #define CONFIG_XENO_OPT_DEBUG_FOO 0
>>>>>> #endif /* CONFIG_XENO_OPT_DEBUG_FOO */
>>>>>>
>>>>>> So, a patch follows which:
>>>>>> - replace the #ifdef with some #if XENO_DEBUG(FOO)
>>>>> Should probably come as a separate patch.
>>>> Come on, the patch is simple, one patch for this is enough.
>>> One part is an obvious fix, the other a refactoring under discussion.
>>>
>>>>>> - move all the initializations to assert.h
>>>>>>
>>>>>> This will make any reference to CONFIG_XENO_OPT_DEBUG_FOO outside of
>>>>>> assert.h suspicious, and easy to detect.
>>>>> How many duplicates did you find?
>>>> A lot, especially for CONFIG_XENO_OPT_DEBUG_NUCLEUS
>>> That's because the CONFIG_XENO_OPT_DEBUG_NUCLEUS defines were misplaced.
>>> Besides that we had one CONFIG_XENO_OPT_DEBUG_QUEUE duplicate, but tons
>>> of proper users. I don't see such an immediate need.
>>>
>>> When adding this kind of switching, it's till more handy to have things
>>> locally in your subsystem. That also makes reviewing easier when you
>>> only find changes in files that belong to a subsystem.
>> That is not the main point, the main point is that putting all these
>> defines in one files allow to detect easily direct references to the
>> symbols.
>>
>>>>> Generally, I'm more a fan of decentralized management here (e.g. this
>>>>> avoids needless patch conflicts in central files).
>>>> If we maintain the list in alphabetical order (which I have done), we 
>>>> reduce the likeliness for conflicts. The aim of doing this is also that 
>>>> I can check that the sources are clean with:
>>>>
>>>> find xenomai-2.5 ! -name 'assert.h' -name '*.[ch]' | xargs grep CONFIG_XENO_OPT_DEBUG_
>>>>
>>>> And that I can add this test to the automated build test.
>>>>
>>>> Note that forgetting to add a #define to the list yields an immediate
>>>> compilation error. So, the patch makes things completely safe.
>>> What did you change to make this happen (for new users of XENO_DEBUG)?
>> Nothing. If you forget to add the define, and do not enable the debug
>> option (which everybody does most of the time), you get a compilation
>> error.
> 
> The alternative (and decentralized) approach for fixing this consists of
> Kconfig magic for generating the value:
> 
> config XENO_OPT_DEBUG_FOO
> 	bool "..."
> 
> config XENO_OPT_DEBUG_FOO_P
> 	int
> 	default "1" if XENO_OPT_DEBUG_FOO
> 	default "0"
> 
> and XENO_DEBUG() could be extended to test for
> CONFIG_XENO_OPT_DEBUG_FOO_P when given "FOO". I'm just not sure if this
> can be expressed for legacy 2.4 kernels, so it might have to wait for
> Xenomai 3.

We can do something like that. But I still find this more complicated
than simply moving three lines to assert.h.

What is your problem exactly? Do you have some customer code which
defines some more debug symbols? In that case there is no problem, you
can keep the code as is. I plan to do the debug check part of the build
test, not part of the makefiles.

-- 
					    Gilles.

