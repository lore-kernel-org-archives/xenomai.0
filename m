Message-ID: <BLU436-SMTP1198AACD4723EEAFD9D2C7F01C0@phx.gbl>
References: <BLU436-SMTP14366D8D519BC2A3A82E3DBF01D0@phx.gbl>
 <20151117073416.GC23348@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Tue, 17 Nov 2015 16:44:53 -0800
MIME-Version: 1.0
In-Reply-To: <20151117073416.GC23348@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #4)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-16 11:34 PM, Gilles Chanteperdrix wrote:
> On Mon, Nov 16, 2015 at 08:05:57PM -0800, Mathieu Rondonneau wrote:
>> From fae80ca1c28b6a9e34f597fe63bfce768123337f Mon Sep 17 00:00:00 2001
>> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
>> Date: Mon, 16 Nov 2015 20:03:28 -0800
>> Subject: [PATCH] IPIPE patch for BCM2709/RPI2.
>>
>>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
>>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c
>>  - xenomai: git://git.xenomai.org/xenomai-3.git (stable-3.0.x)
>>    - cb72996a06ae4f29e403e3397324069f1983145e
>> ---
>>  arch/arm/Kconfig                                 |  2 +-
>>  arch/arm/mach-bcm2709/armctrl.c                  |  4 ++++
>>  arch/arm/mach-bcm2709/bcm2708_gpio.c             |  6 ++++--
>>  arch/arm/mach-bcm2709/bcm2709.c                  |  9 +++++++++
>>  arch/arm/mach-bcm2709/include/mach/entry-macro.S | 12 ++++++++++--
>>  5 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 4860d5f..ed45f63 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1058,7 +1058,7 @@ config IPIPE_ARM_KUSER_TSC
>>         bool
>>         select GENERIC_TIME_VSYSCALL
>>         select IPIPE_HAVE_HOSTRT if IPIPE
>> -       default y if ARCH_AT91 || ARM_TIMER_SP804 || ARCH_MXC ||
>> ARCH_OMAP || PLAT_PXA || PLAT_S3C24XX || ARCH_SA1100
>> +       default y if ARCH_AT91 || ARM_TIMER_SP804 || ARCH_MXC ||
>> ARCH_OMAP || PLAT_PXA || PLAT_S3C24XX || ARCH_SA1100 || ARCH_BCM2709
>>  endif
> 
> The patch will generate less conflicts on upgrade if you move the
> selection of IPIPE_ARM_KUSER_TSC to the SOC-specific section. With
> something like:
> 
> 	  select IPIPE_ARM_KUSER_TSC if IPIPE
> 
> 
> 
Good point, will fix in next patch.
Thanks for reviewing,
-Mathieu

