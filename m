Message-ID: <4BCC9159.5040802@domain.hid>
Date: Mon, 19 Apr 2010 19:22:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid> <4BCC6CEE.70907@domain.hid>	
	<4BCC6E3C.3090301@domain.hid> <4BCC7092.1030809@domain.hid>	
	<4BCC71AF.4030903@domain.hid> <4BCC77BD.9040900@domain.hid>	
	<4BCC78D5.3010405@domain.hid> <4BCC7D88.4070403@domain.hid>	
	<1271693411.16659.128.camel@domain.hid>	
	<4BCC814C.6050003@domain.hid>	
	<1271694331.16659.136.camel@domain.hid>
	<1271695433.16659.141.camel@domain.hid>
In-Reply-To: <1271695433.16659.141.camel@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Mon, 2010-04-19 at 18:25 +0200, Philippe Gerum wrote:
>> On Mon, 2010-04-19 at 18:14 +0200, Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> On Mon, 2010-04-19 at 17:58 +0200, Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I found some code which was referencing directly some
>>>>>>>>>>>> CONFIG_XENO_OPT_DEBUG_ variables with things like:
>>>>>>>>>>>>
>>>>>>>>>>>> #ifdef CONFIG_XENO_OPT_DEBUG_FOO
>>>>>>>>>>>>
>>>>>>>>>>>> This usage is incompatible with the pre-requisites of the assert.h
>>>>>>>>>>>> header that CONFIG_XENO_OPT_DEBUG_FOO should be defined at all times.
>>>>>>>>>>>> While grepping for CONFIG_XENO_OPT_DEBUG_, I found that we also have
>>>>>>>>>>>> many duplicates of construction like:
>>>>>>>>>>>> #ifndef CONFIG_XENO_OPT_DEBUG_FOO
>>>>>>>>>>>> #define CONFIG_XENO_OPT_DEBUG_FOO 0
>>>>>>>>>>>> #endif /* CONFIG_XENO_OPT_DEBUG_FOO */
>>>>>>>>>>>>
>>>>>>>>>>>> So, a patch follows which:
>>>>>>>>>>>> - replace the #ifdef with some #if XENO_DEBUG(FOO)
>>>>>>>>>>> Should probably come as a separate patch.
>>>>>>>>>> Come on, the patch is simple, one patch for this is enough.
>>>>>>>>> One part is an obvious fix, the other a refactoring under discussion.
>>>>>>>>>
>>>>>>>>>>>> - move all the initializations to assert.h
>>>>>>>>>>>>
>>>>>>>>>>>> This will make any reference to CONFIG_XENO_OPT_DEBUG_FOO outside of
>>>>>>>>>>>> assert.h suspicious, and easy to detect.
>>>>>>>>>>> How many duplicates did you find?
>>>>>>>>>> A lot, especially for CONFIG_XENO_OPT_DEBUG_NUCLEUS
>>>>>>>>> That's because the CONFIG_XENO_OPT_DEBUG_NUCLEUS defines were misplaced.
>>>>>>>>> Besides that we had one CONFIG_XENO_OPT_DEBUG_QUEUE duplicate, but tons
>>>>>>>>> of proper users. I don't see such an immediate need.
>>>>>>>>>
>>>>>>>>> When adding this kind of switching, it's till more handy to have things
>>>>>>>>> locally in your subsystem. That also makes reviewing easier when you
>>>>>>>>> only find changes in files that belong to a subsystem.
>>>>>>>> That is not the main point, the main point is that putting all these
>>>>>>>> defines in one files allow to detect easily direct references to the
>>>>>>>> symbols.
>>>>>>>>
>>>>>>>>>>> Generally, I'm more a fan of decentralized management here (e.g. this
>>>>>>>>>>> avoids needless patch conflicts in central files).
>>>>>>>>>> If we maintain the list in alphabetical order (which I have done), we 
>>>>>>>>>> reduce the likeliness for conflicts. The aim of doing this is also that 
>>>>>>>>>> I can check that the sources are clean with:
>>>>>>>>>>
>>>>>>>>>> find xenomai-2.5 ! -name 'assert.h' -name '*.[ch]' | xargs grep CONFIG_XENO_OPT_DEBUG_
>>>>>>>>>>
>>>>>>>>>> And that I can add this test to the automated build test.
>>>>>>>>>>
>>>>>>>>>> Note that forgetting to add a #define to the list yields an immediate
>>>>>>>>>> compilation error. So, the patch makes things completely safe.
>>>>>>>>> What did you change to make this happen (for new users of XENO_DEBUG)?
>>>>>>>> Nothing. If you forget to add the define, and do not enable the debug
>>>>>>>> option (which everybody does most of the time), you get a compilation
>>>>>>>> error.
>>>>>>> The alternative (and decentralized) approach for fixing this consists of
>>>>>>> Kconfig magic for generating the value:
>>>>>>>
>>>>>>> config XENO_OPT_DEBUG_FOO
>>>>>>> 	bool "..."
>>>>>>>
>>>>>>> config XENO_OPT_DEBUG_FOO_P
>>>>>>> 	int
>>>>>>> 	default "1" if XENO_OPT_DEBUG_FOO
>>>>>>> 	default "0"
>>>>>>>
>>>>>>> and XENO_DEBUG() could be extended to test for
>>>>>>> CONFIG_XENO_OPT_DEBUG_FOO_P when given "FOO". I'm just not sure if this
>>>>>>> can be expressed for legacy 2.4 kernels, so it might have to wait for
>>>>>>> Xenomai 3.
>>>> Well, actually, I would not merge this in Xenomai 3. I find this rather
>>>> overkill; mainline first I mean, and mainline, i.e. the Xenomai code
>>>> base only requires a simple and straightforward way to get debug
>>>> switches right. Having to make Kconfig a kitchen sink for some unknown
>>>> out of tree modules to be happy is not really my preferred approach in
>>>> this particular case.
>>>>
>>>> Don't get me wrong, I'm not opposed to a more decentralized approach on
>>>> the paper, it's just that I only care about the mainline tree here.
>>> The point is not out-of-tree but robustness. Neither the current
>>> decentralized #ifdef-#define nor its centralized brother meet this
>>> criteria. An approach like the above which forces you to provide all
>>> required bits before any of the cases (disabled/enabled) starts to work
>>> does so.
>> Flexibility and robustness have to be combined. Explicit declaration in
>> Kconfig is against flexibility, because this is one external thing more
>> to take care of, for adding something as simple as a debug switch. So if

You already have to take care of Kconfig if you want a debug switch.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

