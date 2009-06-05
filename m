Message-Id: <4A294359.3E52.00F8.0@domain.hid>
Date: Fri, 05 Jun 2009 16:09:57 +0200
From: "Karl Tyss" <tyss.k@domain.hid>
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid>
	<4A2907EF.3E52.00F8.0@domain.hid><4A2907EF.3E52.00F8.0@domain.hid>
	<4A2920C7.40200@domain.hid>
In-Reply-To: <4A2920C7.40200@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

5 minutes ago I found out that one of the caches definately has to
cause the problem. I believe I would have to spent couple of more days
to find out why. 

Your hint was a bulls eye. I tried a dirty trick and commented out the
two lines responsible for disabling the I-cache.  It helped. I wonder if
it leads to other problems. I will test it and post my results.

Thank you both for the quick and productive help.

Best regards,
Karl Tyss
 

Mit Freundlichen Grüßen,
Karl Tyss



>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> 06/05/09
3:42 PM >>> 
Karl Tyss wrote:
> Hi,
> 
> thank you for the quick answer.
> 
> The idea with deactivating the caches is to see if they are
influencing
> this behavior. I also tried out the FCSE option and it did not help.
My
> issue is that if there is a user space application that starts lots
of
> short processes/threads and sleeps for a short time, in this case I
get
> a large jitter. Till this point I was able to find out that it makes
a
> difference if the idle task is running. 
> 
> These simple tests I was running weren't supposed to be relevant
stress
> tests. I only tried to prevent the kernel entering the idle task and
the
> simplest way was to start an endless loop doing noting.
> 
> So my question was actually is there any explanation to this
behavior
> and in both cases (yes or no) is this behavior predictable? Perhaps
one
> can avoid this by modifying the cpu_idle task, so that the system
> doesn't necessarily go in a sleep mode.

Ok. If I understand correctly, the AT91SAM9G20 uses an arm926ejs core,
and in arch/arm/mm/proc-arm926.S, the idle function disables and
re-enables the I-cache, so, that may be the source of your problems.

-- 
					    Gilles.



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

