Message-ID: <4DFBB08B.5020005@domain.hid>
Date: Fri, 17 Jun 2011 20:52:43 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
	<4DFBA463.3090902@domain.hid> <4DFBAEB9.8060106@domain.hid>
In-Reply-To: <4DFBAEB9.8060106@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>



On 17/06/2011 20:44, Gilles Chanteperdrix wrote:
> On 06/17/2011 09:00 PM, Gilles Chanteperdrix wrote:
>> On 06/17/2011 04:05 PM, Jakub Nowacki wrote:
>>>>
>>>>
>>>> I've added my ID to the table in smi.c file as:
>>>
>>> {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>> PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN+0xa)}
>>>
>>> Everything complies OK but during the startup I get message:
>>>
>>> [    2.137733] Xenomai: SMI-enabled chipset found
>>> [    2.137744] Xenomai: SMI workaround failed!
>>>
>>> Should I do something extra apart from adding it to the table?
>>
>> There are two reasons why it may not work:
>> - the way to globally disable SMIs has changed with the chipset version
>> you are using;
>> - the BIOS of your PC locks the SMI disabling bit.
>>
>> So, the next step is to check the chipset datasheet.
>
>  From your first mail, the chipset you use is a Q57, the datasheet says
> that the GLB_SMI_EN is still there. So, what you should do is check
> whether the SMI_LOCK bit is set. The following (untested) patch should
> print the lock bit value:
>
> diff --git a/ksrc/arch/x86/smi.c b/ksrc/arch/x86/smi.c
> index d80b14b..97e6774 100644
> --- a/ksrc/arch/x86/smi.c
> +++ b/ksrc/arch/x86/smi.c
> @@ -157,7 +157,8 @@ void rthal_smi_disable(void)
>          mask_bits(rthal_smi_masked_bits, rthal_smi_en_addr);
>
>          if (inl(rthal_smi_en_addr)&  rthal_smi_masked_bits)
> -               printk("Xenomai: SMI workaround failed!\n");
> +               printk("Xenomai: SMI workaround failed!, BIOS lock: d\n",
> +                      !!(inl(rthal_smi_en_addr + 0xA0 - SMI_CTRL_ADDR)&  (1<<  4)));
>          else
>                  printk("Xenomai: SMI workaround enabled\n");
>

You were faster. Thanks! Sorry for slight cross posting. I have this 
machine at work so I probably test it on Monday.

Cheers,

Jakub

