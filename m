Message-ID: <4CA1CD00.3080508@domain.hid>
Date: Tue, 28 Sep 2010 13:09:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>	<4C9D0A94.9030501@domain.hid>	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>	<4C9DB383.1050606@domain.hid>	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>	<4C9E6C21.8010403@domain.hid>	<AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>	<4C9F3163.4050106@domain.hid>	<AANLkTimhq+2tOPJyK7tHjz=WYKYa8s+QU_FbV2GAVuyO@mail.gmail.com>	<4C9F3F9F.9090509@domain.hid>	<AANLkTikY8zeWAEQ3=qHhvaRg2C7-K9miUFfTGWrkZpBh@domain.hid>	<4CA0A60D.2010708@domain.hid>	<AANLkTimYM+gKrWpJkRuPLVEBKy-E+mkhAjmj2tPhqA-e@domain.hid>	<4CA0D305.6030306@domain.hid>	<AANLkTint61br_h293TO_7vz0KAeNC=NCSEpVitzGEMzK@mail.gmail.com>	<4CA105E3.5090309@domain.hid>
	<AANLkTin-hQBiCJfiyn5bqNBCiFxWnmQ_b6-vdZTyMnyv@domain.hid>
In-Reply-To: <AANLkTin-hQBiCJfiyn5bqNBCiFxWnmQ_b6-vdZTyMnyv@domain.hid>
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
> Here is the full test result.
> 
> acpi=off -> works
> acpi=hf -> negative (Disables all of ACPI except just enough to enable
> Hyper Threading)
> pci=noacpi -> negative (Disables ACPI for IRQ routing and PCI scanning)
> acpi=noirq -> negative (Disables ACPI for IRQ routing)
> pnpacpi=off -> negative (Disables the ACPI component of the Linux Plug
> and Play code)
> noapic -> negative (Disables the IO-APIC for IRQ routing or PCI scanning)
> nolapic -> ***works*** (Disables the local APIC)
> 
> This PC is to control a kuka-lwr arm, with a Orocos/Xenomai setup and
> using the Kuka FRI (Fast Research Interface, UDP /1~10 ms sampling
> times). What do you think of going ahead with acpi=off. I would like
> to hear your comments.

I think if Linux alone works with ACPI on and Linux + I-pipe does not,
then there is a problem somewhere. We already saw in the past cases
where disabling ACPI resulted in IRQ being routed incorrectly,
indpendently of the I-pipe patch, (the kind of issue you seem to have).
So, setting ACPI to off may result in such issues.

The other issue, is that with acpi=off you get 4 cpus detected instead
of 8, so you are not using the hardware you have completely.

But of course, the choice is yours.

-- 
                                                                Gilles.

