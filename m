Date: Mon, 11 Apr 2011 19:14:37 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110411171437.GA3715@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA17996.3010103@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA17996.3010103@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Apr 10, 2011 at 11:34:14AM +0200, Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
> > I will try xenomai 2.5 with ipipe 2.6.35 next...

I meant to say, Xenomai 2.4 with ipipe 2.6.35, but this does not work
because the kernel definitions have changed:

 include/asm-generic/xenomai/hal.h: In function 'rthal_get_cpufreq':
 include/asm-generic/xenomai/hal.h:168: error: 'struct ipipe_sysinfo' has no member named 'cpufreq'
 include/asm-generic/xenomai/hal.h: In function 'rthal_get_timerfreq':
 include/asm-generic/xenomai/hal.h:175: error: 'struct ipipe_sysinfo' has no member named 'archdep'

But I think its not worth the effort to try that combination.

> Ok, please try Xenomai 2.5.6 with I-pipe for 2.6.30, in order to know if
> the difference comes from the I-pipe of from Xenomai.

So here is what I measured. Despite all the performance enhancements
added in Xenomai 2.5, it seems that 2.4 still performs better on my
platform. The difference isn't huge, but it is visible.

  |------------+------+------------+-------+---------+---------+---------+----------|
  | Kernel     |      | Xeno       | IPIPE |         |         |         |          |
  | Vers       | FCSE | Vers       | DEBUG | lat min | lat avg | lat max | duration |
  |------------+------+------------+-------+---------+---------+---------+----------|
  | v30        | yes  | v2.4.10    | no    |   8.430 |  17.310 |  63.510 | 00:02:35 |
  | v30        | yes  | v2.5.6 [1] | no    |   7.260 |  32.745 |  80.775 | 00:03:09 |
  | v30        | yes  | v2.5.6 [2] | no    |   7.140 |  34.950 |  78.375 | 00:03:21 |
  |------------+------+------------+-------+---------+---------+---------+----------|
  | v31        | yes  | v2.5.6     | no    |   7.215 |  34.020 |  85.350 | 00:02:58 |
  | v33        | yes  | v2.5.6     | yes   |  17.250 |  55.815 | 127.516 | 00:02:00 |
  | v35        | yes  | v2.5.6     | yes   |   7.140 |  34.200 |  84.180 | 00:02:17 |
  | v35-revert | yes  | v2.5.6     | no    |   7.350 |  29.430 |  85.185 | 00:05:50 |
  | v35        | no   | v2.5.6     | no    |   6.960 | 109.500 | 214.156 | 00:09:41 |
  |------------+------+------------+-------+---------+---------+---------+----------|

  [1] CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
  [2] CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=n

Gilles, I will try your tsc test program later this week...

Thanks,
Richard

