From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A48D9A1.40509@domain.hid>
References: <4A48D9A1.40509@domain.hid>
Content-Type: text/plain
Date: Mon, 29 Jun 2009 17:39:07 +0200
Message-Id: <1246289947.4040.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] DYNAMIC_FTRACE vs. I-pipe tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Mon, 2009-06-29 at 17:11 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> I saw this for 2.6.30, but it obviously also made it into 2.6.29:
> 
> http://git.denx.de/?p=ipipe-2.6.git;a=commitdiff;h=d302f7638b9b52ea90e3c042edd940449cedb7a1
> 
> What precise problem does it try to solve? Is it a 2.6.30-only problem?
> The point is that, last time I checked, the dynamic ftrace approach was
> by far not I-pipe compatible. So I suspect we rather need a fix for the
> core issue, but keep DYNAMIC_FTRACE off.

There are compatible for basic usage at least, but the way the tracer
forced activation of the ftrace layer in 2.6.29+ was wrong in the first
place, and this basically wrecked the ppc64 boot sequence. But now that
it is right (at least non-x86s are happy with this now), we need
DYNAMIC_FTRACE to enable the tracepoints; otherwise we would only get a
few xenomai symbols in the trace log (seen on x86*/ppc*). As it is, we
do get meaningful traces via /proc/ipipe/trace, but I would not assume
that we could not break the kernel when fiddling with ftrace's debugfs
interface.

Quite frankly, moving the tracer over ftrace brought quite a lot of
issues to the non-x86 ports unfortunately (including significant
overhead issues on ppc64); the fact that ftrace is a moving target did
not help either. This integration probably requires more work.

> 
> Jan
> 
-- 
Philippe.



