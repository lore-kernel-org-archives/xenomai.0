From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Sat, 3 Nov 2012 08:00:18 +0100
Message-Id: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read() semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm porting the LinuxCNC realtime support to Xenomai, and that has its =
own latency-test program.

I observe:
- the xenomai latency test is generally acceptable
- with the LinuxCNC latency-test program I see occasional spikes up to =
maybe 80-100uS


the only difference in the code I could discern is:

the xenomai src/testsuite/latency/latency.c code uses rt_timer_tsc() to =
read the timestamp
my port currently uses rt_timer_read()

the question is:

a) did I commit a blunder and should just change rt_timer_read() to use =
rt_timer_tsc() and all be fine, because that could be the explanation =
for the spike
b) should I look elsewhere for the cause?


thanks in advance,

Michael

ps: looks like a bit of a Heisenspike to me: if I simultaneously run =
*both* latency tests, I dont see the spike (which of course doesnt prove =
it wont come eventually :-/)






