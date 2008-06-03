Message-ID: <2ff1a98a0806030220y388ffda5x837f4e15cf0f3f71@domain.hid>
Date: Tue, 3 Jun 2008 11:20:36 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <794283247@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <794283247@domain.hid>
Subject: Re: [Xenomai-help] still verification problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Jun 3, 2008 at 9:53 AM, Joachim Meyer <Jogi95@domain.hid> wrote:
> Hi
>
> I still have problems with 2 tests of the testsuite:
> irqloop doesn't seem to work:
> -------------------------------------
> bash-3.00# irqbench/irqloop
> Test mode:    user-space task
> Port type:    serial
> Port address: 0x3f8
> Port IRQ:     4
>
> Received IRQs:     0
> Acknowledged IRQs: 0
> bash-3.00#
> ------------------------------------
>
> latency in kernel mode fails
> -----------------------------------
> bash-3.00# latency/latency -t1
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|------------|------------|------------|--------|-------------------------
> RTS|  267928.028|  805352.732|      32.768|       0|    00:00:40/00:00:40
> bash-3.00#
> -----------------------------------------------------------------------------------
>
> if nobody can give me hints (modules are loaded)

As a novice, you should not care yourself about loading modules. You
should use the "run" scripts which will take care of loading only the
proper modules, and this should work.

So, the proper way of running the latency test with the -t 1 parameter is:
cd /usr/xenomai/share/xenomai/testuite/latency
./run -- -t 1

> where to look for the errors, maybe somebody can
> send me the manpages. I heard they are availible for debian unstable users, but
> I would have to download and in stall it, just for this reason, so maybe someone
> can manage to download and send them to me.

Xenomai sources are publically accessible through svn, help yourself:
https://gna.org/svn/?group=xenomai

-- 
 Gilles

