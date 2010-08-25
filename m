Message-ID: <4C74DB38.3010104@domain.hid>
Date: Wed, 25 Aug 2010 10:58:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>	
	<1278071401-13880-2-git-send-email-wolfgang.mauerer@domain.hid>	
	<1282725843.1709.12.camel@domain.hid>	
	<4C74D948.6010906@domain.hid>
	<1282726435.1709.22.camel@domain.hid>
In-Reply-To: <1282726435.1709.22.camel@domain.hid>
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
> On Wed, 2010-08-25 at 10:50 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2010-07-02 at 13:50 +0200, Wolfgang Mauerer wrote:
>>>
>>> <snip>
>>>
>>>> diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
>>>> index 4a1cb1b..86f13e0 100644
>>>> --- a/include/linux/ipipe_tickdev.h
>>>> +++ b/include/linux/ipipe_tickdev.h
>>>> @@ -25,6 +25,7 @@
>>>>  #if defined(CONFIG_IPIPE) && defined(CONFIG_GENERIC_CLOCKEVENTS)
>>> Since we should have CONFIG_HAVE_IPIPE_HOSTRT by now, let's use it.
>> Don't get yet how this fits here.
> 
> arch-dep would define CONFIG_HAVE_IPIPE_HOSTRT [if IPIPE]
> 

Still don't see the relation to the line you cited above.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

