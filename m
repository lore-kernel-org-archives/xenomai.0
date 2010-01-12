Message-ID: <4B4CC998.8010300@domain.hid>
Date: Tue, 12 Jan 2010 20:12:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>
	<4B4B6D53.8050606@domain.hid>
	<1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>
	<1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
In-Reply-To: <1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai not booting on a dell server
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

Saravanan S wrote:
> I tried out the installation following the guidelines given by xenomai
> documents as per your advice .The details are given below:
> 
> Xenomai-2.4.10 patched on linux 2.6.29.4,host OS-fedora 11
> 
> while patching  xenomai gave arch as x86(Is this correct for my server???)

If you do not know that, we can not know it for you.

> I used the following options following options in the kernel config
> 
> 1.Processor -Pentium Pro(Strangely newer xeon option  doesnt work ..kernel
> doesnt boot...tried several times)

Well, this deserves to be investigated. You can get help by enabling
early printk.

> 
> 2.ACPI-Processor disabled

The important part of my message is that ACPI should be enabled, with
only ACPI-Processor disabled.

> 
> 3.APM disabled
> 
> 4.CPU frequency scaling disabled
> 
> 5.Check for P4 thermal throttling interrupt disabled.(If enabled gives a
> error while making kernel)
> 
> 5.rest all default options.
> 
> After installing i could boot inside xenomai kernel but when i ran xeno-test
> program ,got worst case latency of around 88 us which is not good enough.
> 
> some other points:
> 
> 1.Grepping dmesg showed no message "SMI chipset found"(SMI detection was
> enabled), so my platform surely does not have SMI chipset(Is this assumption
> correct????).

Two things:
- first the dmesg buffer may be too small for kernels with lots of cpus
and USB devices plugged, so you do not get all the messages, better use
a serial console, or network console.
- the fact that you do not see the SMI chipset found may mean that your
chipset is not supported in Xenomai's smi module. To enable its
detection, you have to add the proper PCI ids to the ksrc/arch/x86/smi.c
file.

-- 
					    Gilles.


