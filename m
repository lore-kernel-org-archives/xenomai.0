From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 3 May 2013 23:54:22 +0200
Message-Id: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I've built a 3.8.10 beaglebone kernel using Stephane's patch and =
xenomai-2.6 master ; only config changes from default config were:
disable frequency scaling, and disable smp (but same symptoms as below =
without these changes)

- kernel boots fine
- 'sudo xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m =
/tmp 100" -t 2' aborts like so: =
http://static.mah.priv.at/public/regression.txt
- starting the linuxcnc latency-test (which basically starts two =
userland threads) hangs the board

I'm a bit at wit's end - any suggestions?

dmesg: http://static.mah.priv.at/public/dmesg.txt
config: http://static.mah.priv.at/public/config

thanks in advance,

Michael




