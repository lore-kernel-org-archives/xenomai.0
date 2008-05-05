Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AF02.35E7EEBE"
Date: Mon, 5 May 2008 18:46:50 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F75@domain.hid>
References: <481F6C7D.1050908@domain.hid> <481F884E.5080201@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Loosing serial interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AF02.35E7EEBE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tomas,

I assume you mean buffer overruns, right?  What type of CPU board are =
you using?  I'm using a Geode and it is notoriously bad in terms of =
non-maskable System Management Interrupts which cause overflows. I had =
to lower the speed of transmission down to 57600 to avoid the overruns.

Take care,

Josh


-----Original Message-----
From: xenomai-help-bounces@domain.hid on behalf of Jan Kiszka
Sent: Mon 5/5/2008 6:21 PM
To: Tomas Kalibera
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Loosing serial interrupt
=20
Tomas Kalibera wrote:
> Hi,
>=20
> I am having problems with lost serial interrupts. Could you please
> explain to me why this happens ? I am probably missing something
> regarding scheduling in Xenomai...
> I prepared a program that triggers the problem, at least on my system.
>=20
> Thanks,
>=20
> Tomas
>=20
> The program works on my system as follows:
>=20
> 1. I run the program, it prints
>=20
> In interrupt, LStatus: 96
> In interrupt, read char, LStatus: 96
>=20
> [which means that it received a serial interrupt, because the
> transmitter receiver is empty]
>=20
> 2. I send a single character to the program over serial line
>=20
> 3. the program wakes up (10 seconds after (1))
>=20
> 4. the program prints
>=20
> I-NFO irq=3D4 hits=3D1
> PIC-ISR:0 PIC-IRR:0 PIC-IMR:128 UART-IIR:4 UART-LSR:97 UART-MSR:176
>=20
> [which means the interrupt at Xenomai level hit only once, although it
> should have twice, second time because of the received character
>  these too lines that repeat indefinitely, the interrupt not coming.
> although interrupts are enabled at PIC level]
>=20
> I use the "XT-PIC-XT" (8259A) interrupt controller. As far as I know,
> Linux sets up the controller to "edge triggering", but uses
> "handle_level_irq" for it. When received by Xenomai, the interrupt is
> masked and acked at PIC level ( "ack" means EOI at 8259A). When the
> interrupt handling in the program finishes, it unmasks the interrupt. =
I
> verified  that my 8259A has a latch that can detect the UART interrupt
> even if masked, so that when unmasked again, it can be delivered.

Try to pass I_EDGE to rt_intr_create. The UART IRQs are edge-triggered,
so you have to enable the appropriate handling at kernel IRQ handler =
level.

Jan



------_=_NextPart_001_01C8AF02.35E7EEBE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] Loosing serial interrupt</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Tomas,<BR>
<BR>
I assume you mean buffer overruns, right?&nbsp; What type of CPU board =
are you using?&nbsp; I'm using a Geode and it is notoriously bad in =
terms of non-maskable System Management Interrupts which cause =
overflows. I had to lower the speed of transmission down to 57600 to =
avoid the overruns.<BR>
<BR>
Take care,<BR>
<BR>
Josh<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: xenomai-help-bounces@domain.hid on behalf of Jan Kiszka<BR>
Sent: Mon 5/5/2008 6:21 PM<BR>
To: Tomas Kalibera<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] Loosing serial interrupt<BR>
<BR>
Tomas Kalibera wrote:<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt; I am having problems with lost serial interrupts. Could you =
please<BR>
&gt; explain to me why this happens ? I am probably missing =
something<BR>
&gt; regarding scheduling in Xenomai...<BR>
&gt; I prepared a program that triggers the problem, at least on my =
system.<BR>
&gt;<BR>
&gt; Thanks,<BR>
&gt;<BR>
&gt; Tomas<BR>
&gt;<BR>
&gt; The program works on my system as follows:<BR>
&gt;<BR>
&gt; 1. I run the program, it prints<BR>
&gt;<BR>
&gt; In interrupt, LStatus: 96<BR>
&gt; In interrupt, read char, LStatus: 96<BR>
&gt;<BR>
&gt; [which means that it received a serial interrupt, because the<BR>
&gt; transmitter receiver is empty]<BR>
&gt;<BR>
&gt; 2. I send a single character to the program over serial line<BR>
&gt;<BR>
&gt; 3. the program wakes up (10 seconds after (1))<BR>
&gt;<BR>
&gt; 4. the program prints<BR>
&gt;<BR>
&gt; I-NFO irq=3D4 hits=3D1<BR>
&gt; PIC-ISR:0 PIC-IRR:0 PIC-IMR:128 UART-IIR:4 UART-LSR:97 =
UART-MSR:176<BR>
&gt;<BR>
&gt; [which means the interrupt at Xenomai level hit only once, although =
it<BR>
&gt; should have twice, second time because of the received =
character<BR>
&gt;&nbsp; these too lines that repeat indefinitely, the interrupt not =
coming.<BR>
&gt; although interrupts are enabled at PIC level]<BR>
&gt;<BR>
&gt; I use the &quot;XT-PIC-XT&quot; (8259A) interrupt controller. As =
far as I know,<BR>
&gt; Linux sets up the controller to &quot;edge triggering&quot;, but =
uses<BR>
&gt; &quot;handle_level_irq&quot; for it. When received by Xenomai, the =
interrupt is<BR>
&gt; masked and acked at PIC level ( &quot;ack&quot; means EOI at =
8259A). When the<BR>
&gt; interrupt handling in the program finishes, it unmasks the =
interrupt. I<BR>
&gt; verified&nbsp; that my 8259A has a latch that can detect the UART =
interrupt<BR>
&gt; even if masked, so that when unmasked again, it can be =
delivered.<BR>
<BR>
Try to pass I_EDGE to rt_intr_create. The UART IRQs are =
edge-triggered,<BR>
so you have to enable the appropriate handling at kernel IRQ handler =
level.<BR>
<BR>
Jan<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AF02.35E7EEBE--

