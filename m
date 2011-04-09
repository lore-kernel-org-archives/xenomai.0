Date: Sat, 9 Apr 2011 20:41:22 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110409184122.GA11908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

After fixing the ipipe big endian issue, I have run into some more
problems on my arm ixp425. Ipipe kernel 2.6.31 with xenomai 2.5.6
boots and runs fine. Ipipe kernel .33 and .35 both boot, but freeze
when xenomai is enabled.

I tried building xenomai as modules, and I found that loading
xeno_nucleus is okay, but the system freezes immediately on loading
xeno_native or xeno_posix.

I tried disabling various CONFIG options, and I found by accident that
enabling IPIPE_DEBUG allows the system to run just fine.

Any hints on where to go from here?

BTW, I also started to compare latency results from various
combinations of ipipe/xenomai. The results a summarized in the table
below.

For the tests, I cleared /proc/xenomai/latency to zero and ran two
instances of "busy.sh", each one in its own xterm, via ssh. Toward the
end of each run, I stopped the scripts at let the system idle for
about ten seconds, in order to get a reading of the minimum latency,
too.

Thanks in advance,
Richard

* latency

  |--------+---------+-------+---------+---------+---------+----------|
  | Kernel | Xeno    | IPIPE |         |         |         |          |
  | Vers   | Vers    | DEBUG | lat min | lat avg | lat max | duration |
  |--------+---------+-------+---------+---------+---------+----------|
  | v30    | v2.4.10 | no    |   8.430 |  17.310 |  63.510 | 00:02:35 |
  | v31    | v2.5.6  | no    |   7.215 |  34.020 |  85.350 | 00:02:58 |
  | v33    | v2.5.6  | yes   |  17.250 |  55.815 | 127.516 | 00:02:00 |
  | v35    | v2.5.6  | yes   |   7.140 |  34.200 |  84.180 | 00:02:17 |
  |--------+---------+-------+---------+---------+---------+----------|

* busy.sh

#!/bin/sh
while [ 1 ] ; do
	find /
	cat /dev/mem > /dev/null
	hackbench -g 1 -T 4 -s 1000 -l 1000
	calibrator 400 1M /tmp/out
done

