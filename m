Message-Id: <4A28FAD7.3E52.00F8.0@domain.hid>
Date: Fri, 05 Jun 2009 11:00:36 +0200
From: "Karl Tyss" <tyss.k@domain.hid>
References: <4A28F029020000F80002DB14@domain.hid>
	<4A28FAD4020000F80002DB27@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: [Xenomai-help] IRQ-Latency when in idle State on ARM
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

Hi,

I am running Xenomai 2.4.7 and linux-2.6.28 on ATMELs AT91SAM9G20-EK. I
noticed a strange thing while measuring IRQ latency with a logic
analyser. Basically I just insert a module with insmod into the kernel.
The module creates an interrupt with "rt_intr_create" and the isr only
triggers a gpio pin up and down.

I also turned I- and D-caches off to avoid the effects of cache-flushes
on a context switch. If the kernel runs the idle process (cpu_idle) the
latency is about 2us larger than with a load. It seems be irrelevant
what kind of load I generate. To generate load I am now using a "stress"
application I found. The simplest case is that it runs a loop and calls
the rand() function.

The "idle"-latency is about 25us in this case and the "stressed" one
about 23 us.

If i run the same test on a kernel without the xenomai extensions i
dont get an difference between the latencies.

Has anyone any ideas why this is happening?

Best Regards,
Karl Tyss




Mit Freundlichen Grüßen,
Karl Tyss




---------------------------------------------------------------------------------------
This email including its attachments is intended for the person or
entity only to which it is addressed. It may contain confidential and/or
privileged material. Any review, forwarding, dissemination, other use
of, or taking of any action in reliance upon this information by persons
or entities other than the intended recipient is prohibited.
If you received this email in error, please contact the sender and 
delete the material from any computer system. 
---------------------------------------------------------------------------------------

Eppendorf AG, Hamburg, Barkhausenweg 1, 22339 Hamburg,
Amtsgericht Hamburg HRB 76249
Vors. des Aufsichtsrats: Dipl.-Ing. Adrian Déteindre
Vorstand: Klaus Fink (Vorsitzender), Detmar Ammermann,
Dr. Heinz G. Koehn, Dr. Michael Schroeder

Eppendorf Instrumente GmbH, Hamburg, Amtsgericht Hamburg, HRB 69077
Geschäftsführer: Rainer Treptow

Eppendorf Biochip Systems GmbH, Hamburg, Amtsgericht Hamburg, HRB 96641
Geschäftsführer: Dr. Sven Buelow

Eppendorf Liquid Handling GmbH, Hamburg, Amtsgericht Hamburg, HRB 92250
Geschäftsführer: Boris von Beichmann

