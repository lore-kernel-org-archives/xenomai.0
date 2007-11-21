Message-ID: <fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
Date: Thu, 22 Nov 2007 00:44:14 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <822923.79799.qm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31018_21636862.1195688654644"
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
	<822923.79799.qm@domain.hid>
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled. Disable
	IRQ line.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DENNIS NGUYEN <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_31018_21636862.1195688654644
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Yes, I have problem with sharing the IRQ 11.
> my questions are:
> How can I set the rteth0 to a known not sharing IRQ in the system?


- You already said you don't have BIOS options.
- If you have multiple PCI slots, try swapping the cards. Usually, adjacent
slots have different interrupt lines. But you might end up sharing with
something else.
- Avoid the use of the sharing device (possible with audio, some USB, ...)
- Check if ACPI configures the interrupt lines for you (bypassing the BIOS).
I don't know for sure, but I think you can use the acpi_irq_pci kernel
parameter to somehow influence the mapping of the physical interrupt lines
to logical IRQ lines (numbers).
- You could also try to share the same IRQ for both cards (again by
replacing them in the PCI slots).

But, in all fairness, I think your problem lies elsewhere, because both
IRQ10 and 11 are affected and disabling only occurs after a lot (1000 or so)
of unhandled requests have happened.



> How can I pass a known IRQ from RTnet to the Xenomai xnintr_shirq_handler?


The PCI interrupts are fixed after BIOS (or ACPI) has done its job. If you
change the number of the IRQ line by moving it or using the BIOS/ACPI,
it should also change correctly.


What does the dmesg log say ? Perhaps you can turn on debugging for the
rtnet driver and get more info.

Last but not least: do the cards work correctly in parallel using the
standard Linux driver (8139too) ?


Jeroen.

------=_Part_31018_21636862.1195688654644
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Yes, I have problem with sharing the IRQ 11.<br>my questions are:<br>How can I set the rteth0 to a known not sharing IRQ in the system?
</blockquote>
<div>&nbsp;</div>
<div>- You already said you don&#39;t have BIOS options.</div>
<div>- If you have multiple PCI slots, try swapping&nbsp;the cards. Usually, adjacent slots have different interrupt lines. But you might end up sharing with something else.</div>
<div>- Avoid the use of the sharing device (possible with audio, some USB, ...)</div>
<div>-&nbsp;Check if&nbsp;ACPI configures the interrupt lines for you (bypassing the BIOS). I don&#39;t know for sure, but I think you can use the acpi_irq_pci kernel parameter to somehow influence the mapping of the physical&nbsp;interrupt lines to logical IRQ lines (numbers).
</div>
<div>- You could also try to share the same IRQ for both cards (again by replacing them in the PCI slots).</div>
<div>&nbsp;</div>
<div>But, in all fairness, I think your problem lies elsewhere, because both IRQ10 and 11 are affected and&nbsp;disabling only occurs after a lot (1000 or so) of unhandled requests have happened. </div>
<div><br>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">How can I pass a known IRQ from RTnet to the Xenomai xnintr_shirq_handler?</blockquote>
<div>&nbsp;</div>
<div>The PCI interrupts are fixed after BIOS (or ACPI) has done its job. If you change the number of the IRQ line by moving it or using the BIOS/ACPI, it&nbsp;should also change correctly.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>What does the dmesg log say ? Perhaps you can turn on debugging for the rtnet driver and get more info.</div>
<div>&nbsp;</div>
<div>Last but not least: do the cards work correctly in parallel using the standard Linux driver (8139too) ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>

------=_Part_31018_21636862.1195688654644--

