Date: Wed, 28 Jul 2010 10:41:12 +0200 (CEST)
From: Markus Seemann <International-Asso@domain.hid>
Message-ID: <638179785.1790459.1280306472842.JavaMail.fmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Deadlock with interrupt shield activated / Avoid
 mode switches at compile time
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

Hello,

a more theoretical question:

Is it possible to provocate a deadlock while switching a RTTask from primary mode to secondary mode when the interrupt shield is activated?
Perhaps with this kind of scenario:
- linux process takes semaphore
- RTTask switches to secondary mode and also tries to take this semaphore
- The semaphore would be released in ISR context of the linux kernel. But the interrupt shield prevents the execution of this isr.

How realistic is this scenario?


Another question:
Is it possible to avoid mode switches for realtime tasks at compile time for a specific task?

Thanks in advance,
Markus
___________________________________________________________
Neu: WEB.DE De-Mail - Einfach wie E-Mail, sicher wie ein Brief!  
Jetzt De-Mail-Adresse reservieren: https://produkte.web.de/go/demail02

