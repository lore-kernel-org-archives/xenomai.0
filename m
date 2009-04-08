MIME-Version: 1.0
Date: Wed, 8 Apr 2009 14:41:43 +0200
Message-ID: <37f89760904080541u4cdff5b2weec809904146cea3@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001485f6d91034447f04670a741f
Subject: [Xenomai-help] IRQ issue :xnintr_irq_handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001485f6d91034447f04670a741f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I wrote a driver to manage GPIO on a PCI card. This PCI card offer UART and
GPIO.
So when I use my GPIO driver with the IRQ10 (automatic assignment), I get
this error message : Xenomai: xnintr_irq_handler: IRQ10 not handled.
Disabling IRQ line.
I program IOCTL command which wait an event. This event is released when a
interrupt is notified on a change state from the input.
I get my error message when I change the state of my input and want to
provocate a interrupt.

I've made a another test; still with the same PCI card (same IRQ 10) but
this time I load the 16550A driver and use the uart with www.captain.at test
on writing and reading on the same uart. Everything works fine.

Can someone can explain me why I get my error ?

Thanks for your help,
Marcel.

--001485f6d91034447f04670a741f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I wrote a driver to manage GPIO on a PCI card. This PCI card off=
er UART and GPIO.<br>So when I use my GPIO driver with the IRQ10 (automatic=
 assignment), I get this error message : Xenomai: xnintr_irq_handler: IRQ10=
 not handled. Disabling IRQ line.<br>
I program IOCTL command which wait an event. This event is released when a =
interrupt is notified on a change state from the input.<br>I get my error m=
essage when I change the state of my input and want to provocate a interrup=
t.<br>
<br>I&#39;ve made a another test; still with the same PCI card (same IRQ 10=
) but this time I load the 16550A driver and use the uart with <a href=3D"h=
ttp://www.captain.at">www.captain.at</a> test on writing and reading on the=
 same uart. Everything works fine.<br>
<br>Can someone can explain me why I get my error ?<br><br>Thanks for your =
help,<br>Marcel.<br><br>

--001485f6d91034447f04670a741f--

