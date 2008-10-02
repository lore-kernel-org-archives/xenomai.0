Message-ID: <48E45E3C.30605@domain.hid>
Date: Thu, 02 Oct 2008 07:38:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>
In-Reply-To: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Rob Wheeler wrote:
> Hello,
> 
> I was recently debugging a problem in our code base and tracked the
> issue down to differences between calling gettimeofday() from our
> non-realtime code and calling clock_gettime() from our realtime
> control loop.  A little poking around with Google led me to clocktest
> program in the Xenomai testsuite.  We are routinely seeing differences
> of around 4 minutes (~240 seconds) between gettimeofday() and
> clock_gettime() immediately after a reboot.  The clocks continue to
> drift apart (or together) at the rate of about 50us/s.
> 
> My question is, is this large of a disparity between clocks normal?
> Are there any tricks or techniques for getting the clocks to be
> synchronized?  In our application we have a realtime control loop
> reading data from motor control boards at a rate of 1KHz.  The data is
> timestamped by the realtime loop.  The non-realtime code can doing
> more heavyweight computation on that data.  It uses the timestamp to
> correlate the data with other data read from non-realtime sensors
> (cameras, laser scanners, etc...).  Some of this data may even be
> collected on other computers running on the robot (and connected via
> gigabit Ethernet).  What do others do to synchronize time between
> realtime, non-realtime, and other network attached computers?
> 
> A little more about my setup:
>   kernel - 2.6.24.3
>   xenomai - v2.4.5
>   adeos patch - adeos-ipipe-2.6.24-x86-2.0-07.patch
>   processor - 2.5 GHz Core 2 Duo
> 
> Thanks for any info you can provide...

Xenomai has no (not yet, this may come) way to correct the clock drift
progressively, like the linux kernel does when using NTP, however, since
version 2.4.x, Xenomai supports setting the clock with clock_settime.
So, as a workaround, you can call clock_settime periodically to
resynchronize Xenomai clock with Linux clock.

Pay attention however: setting the clock has an influence on timers
(like the posix spec asks), so when doing this, you have to carefully
choose whether your timers use CLOCK_REALTIME or CLOCK_MONOTONIC and
whether they are absolute or relative.

http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html

-- 
					    Gilles.

