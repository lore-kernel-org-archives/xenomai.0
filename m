Message-ID: <442D4D73.9030101@domain.hid>
Date: Fri, 31 Mar 2006 17:40:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] gdb and latency
References: <71356528500.20060331105826@domain.hid>
In-Reply-To: <71356528500.20060331105826@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ew@domain.hid
Cc: xenomai@xenomai.org

ew@domain.hid wrote:
> Dear Xenomai team,
> 
> We're using Xenomai 2.1.0 on an PPC based Freescale controller. Kernel
> Version is 2.4.25. Testsuite's latency works fine, except when using GDB.
> While debugging the program, the semaphore in line 220 is not caught and
> line 225 prints  "failed to pend on semaphore, code -512".
> Breakpoints set in this vicinity are ignored. We've tried GDB 5.1 and 6.4.
> Do you have an explanation for this bevaviour?

Bug confirmed here. This is a 2.4-specific issue which needs to be fixed.
After a few tests, 2.6-based configurations seem to be immune to this bug.

> 
> Thanks in advance
> 
> O. Flick
> 
> ---------------------------------------------
> 
> ADC GmbH
> Systems for industry and automation
> 
> Kringelsburg
> 21379 Scharnebeck
> Germany
> 
> Tel. +49 4136/90 00-0
> Fax  +49 4136/90 00-21
> 
> eMail ew@domain.hid
> web   http://www.adcgmbh.de
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

