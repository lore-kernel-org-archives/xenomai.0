MIME-Version: 1.0
Message-ID: <OFADA1BCE9.4C3B5533-ONC1257156.006055A9-C1257156.0062A394@domain.hid>
From: Yann.LEPROVOST@wavecom.fr
Date: Thu, 20 Apr 2006 19:51:41 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0062A390C1257156_="
Subject: [Xenomai-core] Porting xenomai to AT91RM9200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Message en plusieurs parties au format MIME
--=_alternative 0062A390C1257156_=
Content-Type: text/plain; charset="US-ASCII"

Hi all,

I try to port xenomai/adeos to CSB637 Cogent Board featuring an AT91RM9200 
cpu.
My work is based on the integrator and the recent freescale port of adeos 
2.6.14 patch.

Concerning timer's interrupt, the system timer of the AT91RM9200 shares 
IRQ 1 with other peripherals (unlike freescale and integrator)
When I activate adeos ipipe feature in the kernel config, i obtain a 
report_bad_irq concerning IRQ 1.
When I activate xenomai, the kernel seems to freeze after calling idle 
task.

I wonder if adeos irq handling can deal with interrupt sharing ?
Any advice on xenomai porting to arm at91 are welcome.

Regards

Yann Leprovost
--=_alternative 0062A390C1257156_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi all,</font>
<br>
<br><font size=2 face="sans-serif">I try to port xenomai/adeos to CSB637
Cogent Board featuring an AT91RM9200 cpu.</font>
<br><font size=2 face="sans-serif">My work is based on the integrator and
the recent freescale port of adeos 2.6.14 patch.</font>
<br>
<br><font size=2 face="sans-serif">Concerning timer's interrupt, the system
timer of the AT91RM9200 shares IRQ 1 with other peripherals (unlike freescale
and integrator)</font>
<br><font size=2 face="sans-serif">When I activate adeos ipipe feature
in the kernel config, i obtain a report_bad_irq concerning IRQ 1.</font>
<br><font size=2 face="sans-serif">When I activate xenomai, the kernel
seems to freeze after calling idle task.</font>
<br>
<br><font size=2 face="sans-serif">I wonder if adeos irq handling can deal
with interrupt sharing ?</font>
<br><font size=2 face="sans-serif">Any advice on xenomai porting to arm
at91 are welcome.</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br>
<br><font size=2 face="sans-serif">Yann Leprovost</font>
--=_alternative 0062A390C1257156_=--

