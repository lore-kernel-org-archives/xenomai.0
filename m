Message-ID: <46559E9D.7090106@domain.hid>
Date: Thu, 24 May 2007 16:18:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46559AC7.40302@domain.hid>
In-Reply-To: <46559AC7.40302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Newbie question| timer modes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo Bamberg <rolfetas@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Rodolfo Bamberg wrote:
> I am trying to compare latencies between one-shot mode and periodic
> mode. Is there a way to get the system's time expressed in nanoseconds
> if I set the timer to periodic?

With the native API, use rt_timer_tsc and rt_timer_tsc2ns to convert to
nanoseconds. With the posix API, use clock_gettime(CLOCK_MONOTONIC).
Note that what you get is not exactly the system time, but rather the
TSC time, its origin is around the time of the boot, but it is
sufficient for measuring time differences.

Also note that measuring the latency in periodic mode makes little
sense, you will get a variable offset due to the fact that the periodic
task wake up times are aligned on the system timer ticks.

-- 
                                                 Gilles Chanteperdrix

