Subject: Re: [PATCH] MABC RTNet driver to work with GEM hardware
References: <b7f-5d94bd80-57-344a2840@235462188>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3bae5607-a3f4-6cb1-1d20-8a1743aec630@siemens.com>
Date: Wed, 2 Oct 2019 18:17:32 +0200
MIME-Version: 1.0
In-Reply-To: <b7f-5d94bd80-57-344a2840@235462188>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Xenomai <xenomai@xenomai.org>

Please keep this on the list - readding.

On 02.10.19 17:08, François Legal wrote:
> Le Mercredi, Octobre 02, 2019 16:59 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit:
>   
>> On 02.10.19 15:44, François Legal via Xenomai wrote:
>>> From: François LEGAL <devel@thom.fr.eu.org>
>>>
>>> Make MACB driver compliant with GEM hardware (as mainline linux
>>> driver does). Main fix is about interrupt flag that is never
>>> cleared (write 1 to clear)
> 
> Do you mean I shall move these 3 lines right before "kernel/drivers/net/drivers/Kconfig  |  7 +++++++..." ?
> 

I mean something like this in your git commit:

"Make MACB driver compliant with GEM hardware

Main fix is about interrupt flag that is never
cleared (write 1 to clear)

Signed-off-by: ..."

That will generate a properly formatted e-mail when send that out.

>>>
>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>>
>>> Subject: [PATCH] Make MACB driver compliant with GEM hardware
>>
>> Hmm, two subject lines - which one should I use? Would be better get the first
>> one right already ;).
>>
>>>
>>> ---
>>>    kernel/drivers/net/drivers/Kconfig  |  7 +++++++
>>>    kernel/drivers/net/drivers/Makefile |  1 +
>>>    kernel/drivers/net/drivers/macb.c   | 23 ++++++++++++++++++++---
>>>    3 files changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
>>> index 65f0855..39c976f 100644
>>> --- a/kernel/drivers/net/drivers/Kconfig
>>> +++ b/kernel/drivers/net/drivers/Kconfig
>>> @@ -131,6 +131,13 @@ config XENO_DRIVERS_NET_DRV_MACB
>>>        Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>>>        Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
>>>    
>>> +config XENO_DRIVERS_NET_DRV_GEM
>>> +    depends on XENO_DRIVERS_NET
>>> +    tristate "GEM devices"
>>> +    ---help---
>>> +    Driver for internal MAC-controller on Zynq 7000 SoCs.
>>> +    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
>>> +
>>>    endif
>>>    
>>>    source "drivers/xenomai/net/drivers/experimental/Kconfig"
>>> diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/drivers/Makefile
>>> index d95c5a8..9da1a56 100644
>>> --- a/kernel/drivers/net/drivers/Makefile
>>> +++ b/kernel/drivers/net/drivers/Makefile
>>> @@ -57,6 +57,7 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_SMC91111) += rt_smc91111.o
>>>    rt_smc91111-y := smc91111.o
>>>    
>>>    obj-$(CONFIG_XENO_DRIVERS_NET_DRV_MACB) += rt_macb.o
>>> +obj-$(CONFIG_XENO_DRIVERS_NET_DRV_GEM) += rt_macb.o
>>
>> Only saw this now: What's the idea behind adding XENO_DRIVERS_NET_DRV_GEM when
>> there is XENO_DRIVERS_NET_DRV_MACB already? If a selects both, the build will fail.
> 
> Yes, that's correct. However, the Kconfig selects automatically some AT91 specific stuff when CONFIG_XENO_DRIVERS_NET_DRV_MACB is selected.
> I'm not sure on the best way to handle those situations without breaking the existing function.
> 
> from Kconfig :
> config XENO_DRIVERS_NET_DRV_AT91_ETHER
>      depends on XENO_DRIVERS_NET && SOC_AT91RM9200
>      select XENO_DRIVERS_NET_DRV_MACB
>      tristate "AT91RM9200 Board Ethernet Driver"
> 
> config XENO_DRIVERS_NET_DRV_MACB
>      depends on XENO_DRIVERS_NET && ARCH_AT91
>      select AT91_PROGRAMMABLE_CLOCKS
>      tristate "MACB devices"
>      ---help---
>      Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>      Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
> 
> Maybe I should replace the line select AT91_PROGRAMMABLE_CLOCKS with
> select AT91_PROGRAMMABLE_CLOCKS IF ARCH_AT91
> 
> What do you think ?

What does upstream do? Maybe we copied back than a suboptimal pattern that was 
improved there meanwhile.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

