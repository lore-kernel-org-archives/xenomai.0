From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17429.43814.412464.35016@domain.hid>
Date: Mon, 13 Mar 2006 18:25:58 +0100
Subject: Re: [Xenomai-core] RTDM and Timer functions
In-Reply-To: <4411C646.80802@domain.hid>
References: <200603091443.25714.lbocseg@domain.hid> <4410911F.4070507@domain.hid>
	<200603101054.41122.lbocseg@domain.hid> <4411C646.80802@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > > Sometimes the result is "Should be near 84000: 100000", that is kind of 
 > > correct, since the tickval is 100000, although I think that those functions 
 > > in the RTDM driver context should be independent of the tick value set by the 
 > > user program... Maybe using oneshot in the driver calls and periodic in the 
 > > application... I really don't know what would be the best approach here...
 > 
 > rtdm_clock_read always uses the nucleus clock. Using something different
 > (e.g. always TSC) would break applications specifying absolute times
 > derived from the return values of other skins' functions.

Maybe adding a service to RTDM would allow users to measure short time
intervals with RTDM using the TSC ?

The native (rt_timer_tsc()) and posix (clock_gettime(CLOCK_MONOTONIC))
skins have a way to do this.

-- 


					    Gilles Chanteperdrix.

