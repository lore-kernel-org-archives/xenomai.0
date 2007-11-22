Message-ID: <fd6a47a90711221100t6baff4bej3d42e4440c2d452f@domain.hid>
Date: Thu, 22 Nov 2007 20:00:09 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <47459716.50508@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14016_32546935.1195758009895"
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
	<822923.79799.qm@domain.hid>
	<fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
	<47450B49.2060907@domain.hid>
	<fd6a47a90711220342y119217aei841a2b7bce90acb0@domain.hid>
	<47459517.20003@domain.hid> <47459716.50508@domain.hid>
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
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org, Dennis Nguyen <dennisnguy@domain.hid>

------=_Part_14016_32546935.1195758009895
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> post the output of
>
> lspci -v


And while you're at it, please also show the results of

cat /proc/interrupts
cat /proc/xenomai/irq

both just before loading the driver and right after the 'Disabling IRQ.'
message.


Jeroen.






> Roland
>
> Dennis Nguyen wrote:
> > Most of the times the RTnet/Xenomai disabled the IRQ right away. few
> > time it ran for a while.
> > It doesn't matter the system has single or 2 cards, it still have
> > conflict IRQ.  I tried to change the slot but it did not help.
> > Thanks,
> > Dennis
> >
> > Jeroen Van den Keybus wrote:
> >>     The Xenomai disabled the interrupt when it saw the sharing.
> >>
> >>
> >> I may have mislooked, but doesn't xnintr_shirq_handler only disable
> >> the line after XNINTR_MAX_UNHANDLED problematic IRQs (which is by
> >> default set to 1000) ? If you get the error immediately after loading
> >> the driver, it looks like either the interrupt doesn't get properly
> >> acknowledged in the I-pipe (after which the driver gets pounded by 999
> >> stray interrupts, causing it to return 'unhandled') or the driver
> >> fails to acknowledge it on the card.
> >>
> >>
> >>     The NICs worked normally with 8139too.ko and 8139cp.ko drivers.
> >>
> >>
> >> Ok. I think that means that at least no weird things happen in the
> >> I-pipe or that the cards are defective (or poorly inserted in slot).
> >>
> >>
> >>     I have three difference types of PCs: pentium III 650 Mhz, Core2,
> and
> >>     AMD athlon 2Ghz. on different mother boards.  All of them have
> >>     conflict
> >>     IRQs with xenomai and RTnet.  I swapped the slots but it did not
> >>     changed.  I'm thinking of giving the NICs  fixed IRQ but I don't
> >>     know how.
> >>
> >>
> >> As said before, you can only practically do that in the BIOS or using
> >> ACPI.
> >>
> >> Does the rtnet driver work correctly with only one card ?
> >>
> >>
> >> Jeroen.
> >>
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>
>

------=_Part_14016_32546935.1195758009895
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">post the output of<br><br>lspci -v</blockquote>
<div>&nbsp;</div>
<div>And while you&#39;re at it, please also show the results of</div>
<div>&nbsp;</div>
<div>cat /proc/interrupts</div>
<div>cat /proc/xenomai/irq</div>
<div>&nbsp;</div>
<div>both just before loading the driver and right after the &#39;Disabling IRQ.&#39; message.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>
<p>&nbsp;</p>
<div><br>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Roland<br><br>Dennis Nguyen wrote:<br>&gt; Most of the times the RTnet/Xenomai disabled the IRQ right away. few
<br>&gt; time it ran for a while.<br>&gt; It doesn&#39;t matter the system has single or 2 cards, it still have<br>&gt; conflict IRQ.&nbsp;&nbsp;I tried to change the slot but it did not help.<br>&gt; Thanks,<br>&gt; Dennis<br>&gt;
<br>&gt; Jeroen Van den Keybus wrote:<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; The Xenomai disabled the interrupt when it saw the sharing.<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; I may have mislooked, but doesn&#39;t xnintr_shirq_handler only disable
<br>&gt;&gt; the line after XNINTR_MAX_UNHANDLED problematic IRQs (which is by<br>&gt;&gt; default set to 1000) ? If you get the error immediately after loading<br>&gt;&gt; the driver, it looks like either the interrupt doesn&#39;t get properly
<br>&gt;&gt; acknowledged in the I-pipe (after which the driver gets pounded by 999<br>&gt;&gt; stray interrupts, causing it to return &#39;unhandled&#39;) or the driver<br>&gt;&gt; fails to acknowledge it on the card.<br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; The NICs worked normally with 8139too.ko and 8139cp.ko drivers.<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; Ok. I think that means that at least no weird things happen in the<br>&gt;&gt; I-pipe or that the cards are defective (or poorly inserted in slot).
<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; I have three difference types of PCs: pentium III 650 Mhz, Core2, and<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; AMD athlon 2Ghz. on different mother boards.&nbsp;&nbsp;All of them have<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; conflict<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; IRQs with xenomai and RTnet.&nbsp;&nbsp;I swapped the slots but it did not
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; changed.&nbsp;&nbsp;I&#39;m thinking of giving the NICs&nbsp;&nbsp;fixed IRQ but I don&#39;t<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; know how.<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; As said before, you can only practically do that in the BIOS or using
<br>&gt;&gt; ACPI.<br>&gt;&gt;<br>&gt;&gt; Does the rtnet driver work correctly with only one card ?<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; Jeroen.<br>&gt;&gt;<br>&gt;<br>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>&gt; <a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>&gt; <a href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br>&gt;<br>
<br></blockquote><br>

------=_Part_14016_32546935.1195758009895--

