Date: Thu, 14 May 2009 17:15:54 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <4A0BC53F.5090505@domain.hid>
Message-ID: <Pine.LNX.4.64.0905141128190.25483@domain.hid>
References: <Pine.LNX.4.64.0905131634150.7706@domain.hid>
	<4A0BC53F.5090505@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Encouraging Xenomai test results
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


On Thu, 14 May 2009, Gilles Chanteperdrix wrote:
> Adeos no longer plays back the missed interrupts. It only plays back one
> interrupt and let Linux' lost tick compensation algorithms do the rest.

Is there a way to get ipipe to report if it has had to drop any
interrupts for a given IRQ number?

> Running real-time tasks for 3 seconds without leaving Linux run is a bad
> idea (it is even surprising that it works at all).

Understood, although I still think that this was a useful exercise,
even if no sane application would lock out linux for so long, because
it showed me how the system will react if a bug or a hardware problem
causes my code to operate seriously out of spec. For safety reasons,
this is useful to know.

Anyway, I have now re-run the test program, this time configured to
only lock out Linux for 3 milliseconds at a time, separated by gaps of
1.5 milliseconds. As expected, this time the Linux clock, with its 4
millisecond period, appeared to be unaffected by the test. To be
precise, the Linux clock on this computer generally drifts at about
-1ms per minute (measured using a couple of tier-1 NTP servers), and
it continued to drift at this rate while I was running the test
program. The min and max roundtrip latencies of the new test run were
unchanged from what I reported earlier.

> For Linux to work correctly, we usually advise people not to let
> real-time task run for a period longer than Linux tick period.

That's a useful bit of information.

Thanks for the help,

Martin

