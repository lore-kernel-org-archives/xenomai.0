Message-ID: <fd6a47a90711220342y119217aei841a2b7bce90acb0@domain.hid>
Date: Thu, 22 Nov 2007 12:42:08 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <47450B49.2060907@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13365_29316597.1195731728558"
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
	<822923.79799.qm@domain.hid>
	<fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
	<47450B49.2060907@domain.hid>
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
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_13365_29316597.1195731728558
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> The Xenomai disabled the interrupt when it saw the sharing.


I may have mislooked, but doesn't xnintr_shirq_handler only disable the line
after XNINTR_MAX_UNHANDLED problematic IRQs (which is by default set to
1000) ? If you get the error immediately after loading the driver, it looks
like either the interrupt doesn't get properly acknowledged in the I-pipe
(after which the driver gets pounded by 999 stray interrupts, causing it to
return 'unhandled') or the driver fails to acknowledge it on the card.


> The NICs worked normally with 8139too.ko and 8139cp.ko drivers.


Ok. I think that means that at least no weird things happen in the I-pipe or
that the cards are defective (or poorly inserted in slot).


> I have three difference types of PCs: pentium III 650 Mhz, Core2, and
> AMD athlon 2Ghz. on different mother boards.  All of them have conflict
> IRQs with xenomai and RTnet.  I swapped the slots but it did not
> changed.  I'm thinking of giving the NICs  fixed IRQ but I don't know how.


As said before, you can only practically do that in the BIOS or using ACPI.

Does the rtnet driver work correctly with only one card ?


Jeroen.

------=_Part_13365_29316597.1195731728558
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">The Xenomai disabled the interrupt when it saw the sharing.</blockquote>
<div>&nbsp;</div>
<div>I may have mislooked, but doesn&#39;t xnintr_shirq_handler only disable the line after XNINTR_MAX_UNHANDLED problematic IRQs (which is by default set to 1000) ? If you get the error immediately after loading the driver, it looks like either the interrupt doesn&#39;t get properly acknowledged in the I-pipe (after which the driver gets pounded by 999 stray interrupts, causing it to return &#39;unhandled&#39;) or the driver fails to acknowledge it on the card.
</div>
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">The NICs worked normally with 8139too.ko and 8139cp.ko drivers.</blockquote>
<div>&nbsp;</div>
<div>Ok. I think that means that at least no weird things happen in the I-pipe or that the cards are defective (or poorly inserted in slot).</div>
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I have three difference types of PCs: pentium III 650 Mhz, Core2, and<br>AMD athlon 2Ghz. on different mother boards.&nbsp;&nbsp;All of them have conflict
<br>IRQs with xenomai and RTnet.&nbsp;&nbsp;I swapped the slots but it did not<br>changed.&nbsp;&nbsp;I&#39;m thinking of giving the NICs&nbsp;&nbsp;fixed IRQ but I don&#39;t know how.</blockquote>
<div>&nbsp;</div>
<div>As said before, you can only practically do that in the BIOS or using ACPI.</div>
<div>&nbsp;</div>
<div>Does the rtnet driver work correctly with only one card ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></div>

------=_Part_13365_29316597.1195731728558--

