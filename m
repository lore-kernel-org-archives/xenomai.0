Message-ID: <c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
In-Reply-To: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
Date: Sat, 3 Nov 2012 10:37:20 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
 semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org


Michael Haberler wrote:
> I'm porting the LinuxCNC realtime support to Xenomai, and that has its own
> latency-test program.
>
> I observe:
> - the xenomai latency test is generally acceptable
> - with the LinuxCNC latency-test program I see occasional spikes up to
> maybe 80-100uS
>
>
> the only difference in the code I could discern is:
>
> the xenomai src/testsuite/latency/latency.c code uses rt_timer_tsc() to
> read the timestamp
> my port currently uses rt_timer_read()
>
> the question is:
>
> a) did I commit a blunder and should just change rt_timer_read() to use
> rt_timer_tsc() and all be fine, because that could be the explanation for
> the spike

Using rt_timer_read() instead of rt_timer_tsc() is probably not the cause
for the spike. The difference between rt_timer_read() and rt_timer_tsc() is
that on most platforms, rt_timer_tsc() is implemented without a system
call, so the measured latencies is closer to reality (and smaller).

> b) should I look elsewhere for the cause?

Yes. Two things you can do:
- show us the code of your latency test so that we can have a look at it
for obvious mistakes
- enable the I-pipe tracer in the kernel configuration and trigger a trace
freeze (like latency -f option) when you hit the spike.

http://www.xenomai.org/index.php/I-pipe:Tracer

Also note that if LinuxCNC code runs in kernel-space, you should not be
using the native API, but the RTDM API.

-- 
                    Gilles.


