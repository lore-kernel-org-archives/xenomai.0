Message-ID: <fd6a47a90711290850w5d21c703na1af5eab5eee928c@domain.hid>
Date: Thu, 29 Nov 2007 17:50:58 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <474ED223.9040009@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7370_5718800.1196355059007"
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>
	<822923.79799.qm@domain.hid>
	<fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
	<47450B49.2060907@domain.hid>
	<fd6a47a90711220342y119217aei841a2b7bce90acb0@domain.hid>
	<47459517.20003@domain.hid> <47459716.50508@domain.hid>
	<fd6a47a90711221100t6baff4bej3d42e4440c2d452f@domain.hid>
	<474ED223.9040009@domain.hid>
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled.
	Disabling IRQ line.
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

------=_Part_7370_5718800.1196355059007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> I'm sorry for replying late.  my interrupt conflicts could be solved by
> using only one NIC or upgrade to Linux 2.6.23.9.  Interestingly I
> noticed that the kernel 2.6.23.9 assigned different IRQ for each PCI
> device.


That's exactly what I meant by trying to have ACPI reorganize the interrupts
for you. Never compile without CONFIG_ACPI=yes... And beware, I believe that
the IRQ config may vary, theoretically even upon every reboot.

Jeroen.

------=_Part_7370_5718800.1196355059007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I&#39;m sorry for replying late.&nbsp;&nbsp;my interrupt conflicts could be solved by<br>using only one NIC or upgrade to Linux 
<a href="http://2.6.23.9">2.6.23.9</a>.&nbsp;&nbsp;Interestingly I<br>noticed that the kernel <a href="http://2.6.23.9">2.6.23.9</a> assigned different IRQ for each PCI device.</blockquote>
<div>&nbsp;</div>
<div>That&#39;s exactly what I meant by trying to&nbsp;have ACPI reorganize the interrupts for you. Never compile without CONFIG_ACPI=yes... And beware, I believe that the IRQ config may vary, theoretically even upon every reboot.
</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></div>

------=_Part_7370_5718800.1196355059007--

