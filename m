Message-ID: <4CA0D305.6030306@domain.hid>
Date: Mon, 27 Sep 2010 19:23:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>	<4C9D0A94.9030501@domain.hid>	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>	<4C9DB383.1050606@domain.hid>	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>	<4C9E6C21.8010403@domain.hid>	<AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>	<4C9F3163.4050106@domain.hid>	<AANLkTimhq+2tOPJyK7tHjz=WYKYa8s+QU_FbV2GAVuyO@mail.gmail.com>	<4C9F3F9F.9090509@domain.hid>	<AANLkTikY8zeWAEQ3=qHhvaRg2C7-K9miUFfTGWrkZpBh@domain.hid>	<4CA0A60D.2010708@domain.hid>
	<AANLkTimYM+gKrWpJkRuPLVEBKy-E+mkhAjmj2tPhqA-e@domain.hid>
In-Reply-To: <AANLkTimYM+gKrWpJkRuPLVEBKy-E+mkhAjmj2tPhqA-e@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Gajamohan Mohanarajah wrote:
> Hi Gilles,
> 
>> Could you capture without truncating the lines? (option -w of minicom
>> itf it is indeed the culprit). And your configuration as NUMA enabled,
>> please disable it.
> With NUMA disabled, and minicom -w, I am attaching the log files. I
> spotted one more difference in the log files
> Without APIC (working)
> [    0.000000] Processors: 4
> [    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
> With APIC (not working)
> [    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
> 
> 
>> The only thing different between the two logs seems to be the IRQ routing:
>> working:
>> [    2.335156] ahci 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ
>> 19
>> not working:
>> [    3.614523] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) ->
>> IRQ 19
>>
>> On two core i7 I have access to, one gives PCI-MSI-dege, the other
>> IO-APIC-fasteoi, none is level. Could you show us the result of
>> grep ahci /proc/interrupts
>> in the working and non-working case?
> Without APIC (working)
>  26:       4613          0      16570          0   PCI-MSI-edge      ahci
> 
> With APIC (not working) - from initramfs
> 32:          0          0          0          0          0          0
>         0          0   PCI-MSI-edge      ahci

Please do not confuse APIC with ACPI. The non working configuration also
has only 4 cpus (I guess it does not handle hyperthreading).

> 
>> Do you have MSI enabled?
> yes, CONFIG_ARCH_SUPPORTS_MSI=y (I am attaching my config file with
> ACPI turned off and the diff file between the two configs for your
> reference)
> 
> Thank you very much for your help.

The irq line seems mis-configured.

Could you try progressively:
- removing acpi=force on the command line
- disabling CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
- disabling CONFIG_ATA_ACPI

I am a bit running out of steam here, maybe Philippe or Jan could help
better?

-- 
					    Gilles.

