Date: Sun, 10 Apr 2011 08:52:50 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110410065250.GA28869@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA0B878.9010106@domain.hid>
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

On Sat, Apr 09, 2011 at 09:50:16PM +0200, Gilles Chanteperdrix wrote:
> > 
> > Just to have an idea where the issue come from, could you try reverting
> > all the changes which were made on the tsc and timer? i.e. revert to the
> > original ipipe_mach_get_tsc and ipipe_mach_set_dec?
> > 
> The exact commit to revert is this one:
> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cbd591ed5797f105ff45e04cca3bc939388624ea;hp=a2761e92ecd573bc3a3b068d4ebb7cc06313213c

Okay, with cbd591ed57 reverted, it works fine even without IPIPE_DEBUG.

The performance is still about 20 usec worse than xenomai 2.4 with ipipe 2.6.30.

  |------------+------+---------+-------+---------+---------+---------+----------|
  | Kernel     |      | Xeno    | IPIPE |         |         |         |          |
  | Vers       | FCSE | Vers    | DEBUG | lat min | lat avg | lat max | duration |
  |------------+------+---------+-------+---------+---------+---------+----------|
  | v30        | yes  | v2.4.10 | no    |   8.430 |  17.310 |  63.510 | 00:02:35 |
  | v31        | yes  | v2.5.6  | no    |   7.215 |  34.020 |  85.350 | 00:02:58 |
  | v33        | yes  | v2.5.6  | yes   |  17.250 |  55.815 | 127.516 | 00:02:00 |
  | v35        | yes  | v2.5.6  | yes   |   7.140 |  34.200 |  84.180 | 00:02:17 |
  | v35-revert | yes  | v2.5.6  | no    |   7.350 |  29.430 |  85.185 | 00:05:50 |
  | v35        | no   | v2.5.6  | no    |   6.960 | 109.500 | 214.156 | 00:09:41 |
  |------------+------+---------+-------+---------+---------+---------+----------|

I will try xenomai 2.5 with ipipe 2.6.35 next...

Thanks,
Richard

