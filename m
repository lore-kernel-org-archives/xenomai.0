Message-ID: <4CA0A60D.2010708@domain.hid>
Date: Mon, 27 Sep 2010 16:11:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>	<4C9D0A94.9030501@domain.hid>	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>	<4C9DB383.1050606@domain.hid>	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>	<4C9E6C21.8010403@domain.hid>	<AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>	<4C9F3163.4050106@domain.hid>	<AANLkTimhq+2tOPJyK7tHjz=WYKYa8s+QU_FbV2GAVuyO@mail.gmail.com>	<4C9F3F9F.9090509@domain.hid>
	<AANLkTikY8zeWAEQ3=qHhvaRg2C7-K9miUFfTGWrkZpBh@domain.hid>
In-Reply-To: <AANLkTikY8zeWAEQ3=qHhvaRg2C7-K9miUFfTGWrkZpBh@domain.hid>
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
Cc: xenomai@xenomai.org

Gajamohan Mohanarajah wrote:
> Hi Gilles,
> 
>> If you have another computer, user serial console or netconsole.
> Thanks for the tip. I managed to get it via the serial console.
> 
> I am attaching the following two logs
> 1. ACPI is enabled (but CONFIG_ACPI_PROCESSOR is not set) problem
> 2. ACPI disabled - Works fine
> Please note that in both cases ACHI was the BIOS setting.

Ok. I have a few suggestions.

Could you capture without truncating the lines? (option -w of minicom
itf it is indeed the culprit). And your configuration as NUMA enabled,
please disable it.

The only thing different between the two logs seems to be the IRQ routing:
working:
[    2.335156] ahci 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ
19
not working:
[    3.614523] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) ->
IRQ 19

On two core i7 I have access to, one gives PCI-MSI-dege, the other
IO-APIC-fasteoi, none is level. Could you show us the result of
grep ahci /proc/interrupts
in the working and non-working case?

Do you have MSI enabled?

-- 
					    Gilles.

