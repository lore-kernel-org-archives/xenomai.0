Message-Id: <4A294CAB.3E52.00F8.0@domain.hid>
Date: Fri, 05 Jun 2009 16:49:44 +0200
From: "Karl Tyss" <tyss.k@domain.hid>
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid>
	<4A2907EF.3E52.00F8.0@domain.hid><4A2907EF.3E52.00F8.0@domain.hid>
	<4A2920C7.40200@domain.hid>
	<4A294359.3E52.00F8.0@domain.hid><4A294359.3E52.00F8.0@domain.hid>
	<4A29290E.7050609@domain.hid>
In-Reply-To: <4A29290E.7050609@domain.hid>
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

Disabling the I- or D-cache is available as an option by using
menuconfig under system-type.

As to the Jitters - I didn't describe it correctly what i was doing. I
disabled the both caches as a trick to test if there is a difference.
The 2 us timing difference was without the caches. With I- and D-cache
online i had a difference of 13 us as average value (15us idle and 3 us
with user space load)

I have to estimate a critical path in order to decide if a timer
interrupt driven periodic task or a xenomai periodic task is better for
my system. As I noticed this effect of the idle task I had to know why
in order to document it or to change the part of the code.

Well, now I know what to do and I have to find out if disabling the
I-cache is critical at this point and if so, how one can avoid it. My
system doesn't have  to save power if its online and I suppose that
disabling this kind of idleness could be a nice feature in the kernel or
xenomai.

So thank you for your help again and have a nice weekend,

Best regards,
Karl Tyss
 

Mit Freundlichen Grüßen,
Karl Tyss



>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> 06/05/09
4:17 PM >>> 
Karl Tyss wrote:
> Hi,
> 
> 5 minutes ago I found out that one of the caches definately has to
> cause the problem. I believe I would have to spent couple of more
days
> to find out why. 
> 
> Your hint was a bulls eye. I tried a dirty trick and commented out
the
> two lines responsible for disabling the I-cache.  It helped. I wonder
if
> it leads to other problems. I will test it and post my results.
> 
> Thank you both for the quick and productive help.

Also, let me insist: 2 microseconds on ARM is peanuts. Really, it is
insignificant, you will get much worse jitters than that with a
properly
loaded system.

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

