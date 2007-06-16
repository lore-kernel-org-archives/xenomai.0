From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18036.9180.75226.863768@domain.hid>
Date: Sat, 16 Jun 2007 19:54:36 +0200
In-Reply-To: <DB21A0DD952.000005E0ejr@domain.hid>
References: <DB21A0DD952.000005E0ejr@domain.hid>
Subject: Re: [Xenomai-core] HZ, tick timer and scheduler relation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Junior <ejr@domain.hid>
Cc: xenomai@xenomai.org

Junior wrote:
 > Hi all,
 > It was suggested that I ask this question on this list.
 > If I have the wrong list please let me know.
 > 
 > I'm using ARM linux kernel 2.6.18 on a custom board and on my
 > development board the scheduler timeslice was 10ms and
 > on my custom board it's 100ms. I had HZ up'ed to 400 instead of
 > the 200 ARM default.
 > I've tried repeatedly to reduce this to 10ms but for some reason
 > changing HZ has no effect as the scheduler timeslice hovers around
 > 100ms +/- 10ms. My clock tick timer is set the same @ ~3.6MHz.
 > On the 2.6.18 kernel, Changing HZ does have the expected effect but
 > perhaps something changed in 2.6.18.
 > 
 > I'm trying to understand what the relation is between HZ, the clock tick timer
 > and the scheduler timeslice.
 > Could anyone help me understand this? or suggest some good reading materials?

Looking at linux 2.6.19 code, it seems that the scheduler timeslice (as
returned by sched_get_rr_interval) depends on the nice value of a
process. Higher priority processes have a longer timeslice.

-- 


					    Gilles Chanteperdrix.

