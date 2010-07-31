From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <638179785.1790459.1280306472842.JavaMail.fmail@domain.hid>
References: <638179785.1790459.1280306472842.JavaMail.fmail@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 31 Jul 2010 12:35:04 +0200
Message-ID: <1280572504.2092.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deadlock with interrupt shield activated / Avoid
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
To: Markus Seemann <International-Asso@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-07-28 at 10:41 +0200, Markus Seemann wrote:
> Hello,
> 
> a more theoretical question:
> 
> Is it possible to provocate a deadlock while switching a RTTask from primary mode to secondary mode when the interrupt shield is activated?
> Perhaps with this kind of scenario:
> - linux process takes semaphore
> - RTTask switches to secondary mode and also tries to take this semaphore
> - The semaphore would be released in ISR context of the linux kernel. But the interrupt shield prevents the execution of this isr.
> 
> How realistic is this scenario?

The I-shield would be disengaged as soon as a non-Xenomai thread is
scheduled in, resuming the linux ISR flow. So unless the CPU remains
100% busy to process Xenomai threads either in primary or secondary mode
- which would be the first problem to solve - this can't happen (the RT
task for one would block, pending on the semaphore, creating an
opportunity for non-RT threads to resume).

This is not to say that the I-shield might not bring other tricky
issue(s) in, but this one is not possible by design.

> 
> 
> Another question:
> Is it possible to avoid mode switches for realtime tasks at compile time for a specific task?
> 

Avoiding a priori would mean to deny compilation when a code path which
may lead to a linux syscall is detected; not quite simple to implement
for userland apps given otherwise valid dependencies on the glibc
Xenomai may have (e.g. for creating threads).

> Thanks in advance,
> Markus
> ___________________________________________________________
> Neu: WEB.DE De-Mail - Einfach wie E-Mail, sicher wie ein Brief!  
> Jetzt De-Mail-Adresse reservieren: https://produkte.web.de/go/demail02
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



