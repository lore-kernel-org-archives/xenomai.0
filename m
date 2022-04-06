References: <20220402030919.5104-1-hongzhan.chen@intel.com>
 <20220402030919.5104-2-hongzhan.chen@intel.com>
 <878rsnq20o.fsf@xenomai.org>
 <MN2PR11MB42856C36CFD8CA17393DE52EF2E79@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [linux-dovetail PATCH 2/2] clocksource:
 GENERIC_CLOCKSOURCE_VDSO only supported on ARM
Date: Wed, 06 Apr 2022 09:53:43 +0200
In-reply-to: <MN2PR11MB42856C36CFD8CA17393DE52EF2E79@MN2PR11MB4285.namprd11.prod.outlook.com>
Message-ID: <874k363ao9.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:

>>-----Original Message-----
>>From: Philippe Gerum <rpm@xenomai.org> 
>>Sent: Saturday, April 2, 2022 5:11 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Cc: xenomai@xenomai.org
>>Subject: Re: [linux-dovetail PATCH 2/2] clocksource: GENERIC_CLOCKSOURCE_VDSO only supported on ARM
>>
>>
>>Hongzhan Chen via Xenomai <xenomai@xenomai.org> writes:
>>
>>> Currently, GENERIC_CLOCKSOURCE_VDSO only supported well on ARM.
>>> To fix build issue like following when make allyesconfig on x86 platform.
>>>
>>> arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:145:14:
>>> error: implicit declaration of function clock_open_device
>>>
>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>> ---
>>>  drivers/clocksource/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 5138cd593373..1e8c1cd086d5 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -644,7 +644,7 @@ config CLKSRC_ST_LPC
>>>  	bool "Low power clocksource found in the LPC" if COMPILE_TEST
>>>  	select TIMER_OF if OF
>>>  	depends on HAS_IOMEM
>>> -	select GENERIC_CLOCKSOURCE_VDSO
>>> +	select GENERIC_CLOCKSOURCE_VDSO if ARM
>>>  	help
>>>  	  Enable this option to use the Low Power controller timer
>>>  	  as clocksource.
>>
>>Starting from v5.17, Dovetail has generic support for clocksource access
>>via the vDSO for CONFIG_ARM64 too. Which kernel release is this patch
>>based on?
>
> Sorry, I had not described it clearly. It is based on 5.10.
>

No problem. I just backported the vDSO support to 5.10/arm64 along with
a fix for allyesconfig per your suggestion (v5.10.107-dovetail1-rebase),
so both LTS trees I'm maintaining have it now:

7585543a1ebb arm64: vDSO: export user-visible MMIO clocksources
143579c7945c clocksource/drivers: dovetail: fix dependency on GENERIC_CLOCKSOURCE_VDSO

-- 
Philippe.

