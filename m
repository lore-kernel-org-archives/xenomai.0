Message-ID: <4C74E022.8030105@domain.hid>
Date: Wed, 25 Aug 2010 11:19:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>	
	<1278071401-13880-2-git-send-email-wolfgang.mauerer@domain.hid>	
	<1282725843.1709.12.camel@domain.hid>	
	<4C74D948.6010906@domain.hid>	
	<1282726435.1709.22.camel@domain.hid>	
	<4C74DB38.3010104@domain.hid>
	<1282727242.1709.26.camel@domain.hid>
In-Reply-To: <1282727242.1709.26.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/2] ipipe: Pass NTP-corrected time
 information from Linux to higher domains
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "adeos-main@gna.org" <adeos-main@gna.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>

Philippe Gerum wrote:
> On Wed, 2010-08-25 at 10:58 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2010-08-25 at 10:50 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2010-07-02 at 13:50 +0200, Wolfgang Mauerer wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>> diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
>>>>>> index 4a1cb1b..86f13e0 100644
>>>>>> --- a/include/linux/ipipe_tickdev.h
>>>>>> +++ b/include/linux/ipipe_tickdev.h
>>>>>> @@ -25,6 +25,7 @@
>>>>>>  #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
>>>>> Since we should have CONFIG_HAVE_IPIPE_HOSTRT by now, let's use it.
>>>> Don't get yet how this fits here.
>>> arch-dep would define CONFIG_HAVE_IPIPE_HOSTRT [if IPIPE]
>>>
>> Still don't see the relation to the line you cited above.
>>
> 
> That is because you chose to have CONFIG_IPIPE_HOSTRT and
> CONFIG_HAVE_IPIPE_HOSTRT. I would have only defined the latter, the way
> you define the former. I'm looking for the hostrt support to be compiled
> in if CONFIG_HAVE_IPIPE_HOSTRT is available from the arch-dep section,
> so we don't need CONFIG_IPIPE_HOSTRT. Generic bits may depend on HAVE_*
> as well.

First of all, the code you cited _above_ is not changed by our patches,
so the context still puzzles me (but maybe you are referring to some
other place in fact).

Second, CONFIG_HAVE_IPIPE_HOSTRT is designed to be set independently of
CONFIG_IPIPE - it's a static arch feature like all the other
CONFIG_HAVE_* in arch/*/Kconfig. So it takes a second, generically
defined CONFIG switch if the generic support also depends on
CONFIG_IPIPE like in this case. That's a kernel convention we follow. If
you want us to do it I-pipe-specific, no problem, I just want to have
this pointed out.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

