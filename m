Message-ID: <49EF5149.9090609@domain.hid>
Date: Wed, 22 Apr 2009 19:18:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
	<49ECBEE6.2060201@domain.hid>
	<Pine.LNX.4.64.0904201444200.26654@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904201444200.26654@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Success! (was Re: Tests with 2.5rc1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> On Mon, 20 Apr 2009, Gilles Chanteperdrix wrote:
>> ...and should try to disable high
>> res timers to see if it helps further.
> 
> Excellent suggestion. This has completely fixed the problem. To be
> precise, starting with the config of the last problematic kernel, I
> toggled off the high-res timer option in menuconfig, recompiled the
> kernel, and booted into the new kernel.  I have now booted twice into
> the resulting kernel, and have been unable to provoke a single hang in
> either case, whereas before this change, I could reliably always
> provoke a hang within a few seconds of running "dd if=/dev/zero
> of=/dev/null". I have also now run xeno-test twice, all the way
> through, for the first time.
> 
> Do you have any idea why having the high-resolution timers option
> enabled was causing the system to hang?

Not at all. The issue you have seems to be related with the timer
sub-system, the timer not being reprogrammed or something like that.
We must tell everyone on this list that high-res timers work for the
current hardware we run our tests on, so that people do not conclude
that hi-res timers do not work with Xenomai.

So, I see from previous posts that you have PM-timers enabled, could you
try to re-enable high-res timers, and disable PM-timers ?

-- 
                                                 Gilles.

