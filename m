Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 May 2009 15:44:08 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0198FCE1@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] sem_wait increments fault counter
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

Dear Gurus,

every time I call sem_wait a fault counter is incremented (TRAP 0).
sem_wait itself does not return an error :

uc101 # cat /proc/xenomai/faults
TRAP         CPU0
  0:            1    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)

what could be the reason for this? Is this serious?
I have to add that sem_wait is called form a Linux-Prozess (linked with
xenomai libraries, but no xenomai thread is created) when this happens.

System: PPC Linux 2.4.25; Xenomai 2.3.5=20

Thank you for your help
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

