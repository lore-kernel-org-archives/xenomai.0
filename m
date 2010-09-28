MIME-Version: 1.0
In-Reply-To: <4CA105E3.5090309@domain.hid>
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<4C9D0A94.9030501@domain.hid>
	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>
	<4C9DB383.1050606@domain.hid>
	<AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>
	<4C9E6C21.8010403@domain.hid>
	<AANLkTimte2sxk535RfQ4M7b2gT4v1PJAzUiVB_nh7-zO@mail.gmail.com>
	<4C9F3163.4050106@domain.hid>
	<AANLkTimhq+2tOPJyK7tHjz=WYKYa8s+QU_FbV2GAVuyO@mail.gmail.com>
	<4C9F3F9F.9090509@domain.hid>
	<AANLkTikY8zeWAEQ3=qHhvaRg2C7-K9miUFfTGWrkZpBh@domain.hid>
	<4CA0A60D.2010708@domain.hid>
	<AANLkTimYM+gKrWpJkRuPLVEBKy-E+mkhAjmj2tPhqA-e@domain.hid>
	<4CA0D305.6030306@domain.hid>
	<AANLkTint61br_h293TO_7vz0KAeNC=NCSEpVitzGEMzK@mail.gmail.com>
	<4CA105E3.5090309@domain.hid>
Date: Tue, 28 Sep 2010 12:39:41 +0200
Message-ID: <AANLkTin-hQBiCJfiyn5bqNBCiFxWnmQ_b6-vdZTyMnyv@domain.hid>
From: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Hi Gilles,

Here is the full test result.

acpi=3Doff -> works
acpi=3Dhf -> negative (Disables all of ACPI except just enough to enable
Hyper Threading)
pci=3Dnoacpi -> negative (Disables ACPI for IRQ routing and PCI scanning)
acpi=3Dnoirq -> negative (Disables ACPI for IRQ routing)
pnpacpi=3Doff -> negative (Disables the ACPI component of the Linux Plug
and Play code)
noapic -> negative (Disables the IO-APIC for IRQ routing or PCI scanning)
nolapic -> ***works*** (Disables the local APIC)

This PC is to control a kuka-lwr arm, with a Orocos/Xenomai setup and
using the Kuka FRI (Fast Research Interface, UDP /1~10 ms sampling
times). What do you think of going ahead with acpi=3Doff. I would like
to hear your comments.

Best,
Gajan


On 27 September 2010 23:00, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gajamohan Mohanarajah wrote:
>> Hi Gilles,
>>
>> I tried your 3 suggestions. But no luck.
>> I am attaching the config file for reference.
>> The kernel base on this config file boots without any problem with the
>> [nolapic] option (or the [acpi=3Doff] option).
>> (Ref:https://wiki.ubuntu.com/DebuggingACPI)
>> But fails with [acpi=3Dht] option.
>>
>> Gajan
>>
>> I tried the following grub options too:
>> acpi=3Doff =A0-> works fine
>> acpi=3Dht -> doesn't work
>> [according to https://wiki.ubuntu.com/DebuggingACPI : This means the
>> issue is in the ACPI table parsing code itself, or perhaps the SMP
>> code. ]
>
> Since the problem seems to be with IRQ routing, I would suggest
> acpi=3Dnoirq
>
> According to the wiki you found.
>
> In fact, I would try all the options suggested to find the one which
> works...
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

