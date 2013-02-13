Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
Date: Wed, 13 Feb 2013 10:26:27 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
References: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
Subject: [Xenomai] puzzled: running switchtest improves latency figures
	permanently
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Schooner <schooner30@tiscali.co.uk>, sam sokolik <samco@empirescreen.com>, John Morris <john@zultron.com>


We have a report from 'the field' which we cannot make sense of.

The situation:
- an AMD board: http://www.asus.com/Motherboard/F1A75M_PRO=20
- dmesg post boot: http://pastebin.com/38XrxNBy
- xeno-regression-test runs well, max 32us jitter
- John's Xenomai kernel packages:  3.5.7/2.6.2.1 [1]
- a native-skin userland RT threads application (linuxcnc[3])
 - 2 threads
 - jitter measured with its own GUI application 'latency-test'
 - successfully tested on several other platforms


what we observed:

1. Problem behaviour
---------------------
- boot
- run LinuxCNC latency-test
- observe massive spikes in latency
 - >100uS on a 25uS thread!
 - http://static.mah.priv.at/public/latency/skunkworks-unprimed.png

now any of 2), 3) or 4) improve latency:

2. run switchtest:  temporary change
------------------------------------
- while still running LinuxCNC latency-test from 1) above,
- running "/usr/lib/xenomai/testsuite/switchtest -s 1000" in a separate
window
- hit 'Reset Statistics' on the latency-test window
- max latency drops massively
- see http://static.mah.priv.at/public/latency/skunkworks-primed.png [3]
- ^C-ing out of the switchtest makes latency rise again


3. running a trivial shell script:  temporary change during script =
execution
=
--------------------------------------------------------------------------=
--
- reboot
- run latency-test, again observe latency spikes
- in a separate window, run:
 - while true; do echo "nothing" > /dev/null; done
- again, latency-test shows rather low latency figures after hitting
'reset statistics' *as long as the above script is running*
- quote from Sam: "BTW - I ran the latency-test all night with the =
donothing scrip and it peaked at about 19.6us latency."
- killing the script makes the latency spikes reappear.


4. running xeno-regression-test and breaking out: permanent drop in =
latency
=
--------------------------------------------------------------------------=

- reboot
- run latency-test, again observe latency spikes
- in a separate window, run:
  sudo xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m =
/tmp 100 " -t 2
- latency drops=20
- the key observation: if you break by ^C out of xeno-regression-test, =
*latency
figures remain low*
- note that breaking out of xeno-regression-test left some processes =
running, obviously dd and ls:  http://pastebin.ca/2313116=20
- once these processes complete ( http://pastebin.ca/2313117) latency =
goes up again.

second data point:
we have a report from another user, same kernel, Intel Q8200 Quad core =
board, which confirms 'dohell 900' in a separate window does drop =
latency significantly. This suggests it might not board specific.


This leaves us puzzled as to the causality here. We would really like to =
get rid of the latency spikes, but the shell script approach isnt =
appealing.

Any suggestions?

- Michael, Sam, John

----

[1] Config:
=
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/config-3.5=
.7.txt
PPA info:  =
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

[2] this screenshot was taken before we isolated the improvement to
running switchtest -s 1000; before we had used 'sudo
xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp 100"
-t 2' and it was observed that breaking out of the test with ^C towards
its end improves latency.

[3] the logic in essence follows trivial-periodic.c. While I have not
separated out the test into a simple program, this is certainly doable
if required.






