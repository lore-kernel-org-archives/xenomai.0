From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17548.4423.616939.905643@domain.hid>
Date: Sun, 11 Jun 2006 14:49:11 +0200
Subject: Re: [Xenomai-help] Can I profile a Xenomai app?
In-Reply-To: <4489C553.2040502@domain.hid>
References: <4489C553.2040502@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brian Hughner <brh@domain.hid>
Cc: xenomai@xenomai.org

Brian Hughner wrote:
 > Hi!
 > 
 > I've been working with Xenomai 2.1 and 2.2 and would like to profile a 
 > daemon that I wrote. Is it possible to profile Xenomai threads in a daemon?

If you are looking for a way to manually instrument your code in order
to measure short time intervals, you may use
clock_gettime(CLOCK_MONOTONIC) with the posix skin, or rt_timer_tsc()
with the native skin.

For a more automated way, have a look at the I-pipe tracer.

If you are able to simulate the low-level part of the daemon you
developed, or if this daemon does not interact too much with hardware,
you may compile this daemon for xenomai simulator, compiled with the
"atomic core" option, and give a try to cachegrind. I do not think
cachegrind will be able to output per-thread results, though.

-- 


					    Gilles Chanteperdrix.

