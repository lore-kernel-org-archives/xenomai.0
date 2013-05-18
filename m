From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D5AE3DA-87FF-4AC2-B888-4116ED22A9BF@mah.priv.at>
Date: Sat, 18 May 2013 23:39:24 +0200
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: [Xenomai] Beagleboard 3.8 regression results
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

using Stephan's 3.8 patch for the BeagleBoard and running

arm:/usr/xenomai/bin# ./xeno-regression-test -l =
"/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2

gives=20

select service with posix message queues: success
++ start_load
++ echo start_load
++ check_alive /usr/xenomai/bin/switchtest
++ echo check_alive /usr/xenomai/bin/switchtest
++ check_alive /usr/xenomai/bin/switchtest -s 1000
++ echo check_alive /usr/xenomai/bin/switchtest -s 1000
++ check_alive /usr/xenomai/bin/latency -t 2
./xeno-regression-test failed: dead child 1988 not found!

not sure what to make of it - any recommendations how to proceed?

- Michael=

