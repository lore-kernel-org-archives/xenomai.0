Message-ID: <8659178.81831292179675169.JavaMail.defaultUser@domain.hid>
Date: Sun, 12 Dec 2010 19:47:55 +0100 (CET)
From: "mau.salvi@domain.hid" <mau.salvi@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Interrupt handling vs. scheduler
Reply-To: "mau.salvi@domain.hid" <mau.salvi@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello to all,

I observed a strange behaviour on oscilloscope during=20
interrupt handling when RT periodic tasks reschedule happens.

I have=20
an interrupt generated every 1ms by a PCI card: the interrupt was=20
handled into user-space with a RT task (priority 99) that sleeps on=20
rt_intr_wait(), and the handler was created with I_NOAUTOENA flag, so=20
there is a rt_intr_enable() call each cycle immediately before=20
rt_intr_wait(). Into my code there is another task that works=20
periodically on this PCI card data.

Due to a "slip" between PC and PCI=20
card hardware timers, sometimes there is an overlap between interrupt=20
handling and periodic task wakeup: in detail, during interrupt=20
handling, the periodic time for latter task expires, so wakeup must=20
take place. In this (and only in this) condition I observe a wrong call=20
to interrupt handling task immediately after the end of right handling:=20
so, I have two consecutive interrupt calls, as the expire timer signal=20
was delivered also to my interrupt handler. Task wakeup takes=20
regularily place.

This behaviour happens only if there is some other=20
periodic task into my executable: without that, interrupts was properly=20
handled every 1ms. "Strange" behaviour also happens if periodic task=20
does nothing (waits rescheduling only).

I'm working on Ubuntu 10.04=20
x86 with Xenomai 2.5.5.2 on a vanilla kernel 2.6.35.7, Adeos patch 2.7-
04.
Hardware:  Intel Celeron M 512 MHz processor, motherboard with SMI=20
services disabled by Xenomai at startup.

I've seen that a new Adeos=20
patch (2.8) was released for x86 arch, with more modifies into IRQ=20
code: does new patch fixes this problem?

Thanks in advance, bye



Supera i limiti: raddoppia la velocit=C3=A0 da 10 a 20 Mega!   Risparmia co=
n Tutto Incluso: telefono + adsl 20 mega a soli 29,95 =E2=82=AC al mese per=
 due anni!  SCONTO DI 240 EURO!  http://abbonati.tiscali.it/telefono-adsl/p=
rodotti/tc/tuttoincluso/?WT.mc_id=3D01fw 

