Message-ID: <4AEF236F.1000801@domain.hid>
Date: Mon, 02 Nov 2009 19:22:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20091020113724.9069.23594.stgit@domain.hid>		<20091020113725.9069.28060.stgit@domain.hid>		<1256404942.2862.498.camel@domain.hid>		<1257177854.2065.616.camel@domain.hid>		<4AEF0BCC.2020208@domain.hid>	<1257180716.2065.618.camel@domain.hid>	<4AEF0F7F.2060603@domain.hid>	<4AEF1E91.6030407@domain.hid>
	<4AEF22C3.4070303@domain.hid>
In-Reply-To: <4AEF22C3.4070303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on ARMadeus
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pierre Ficheux <pierre.ficheux@domain.hid>
Cc: Xenomai-help@domain.hid

Pierre Ficheux wrote:
> Hi,
> 
> I've just tried to use Xenomai on ARMadeus board (APF9328, kernel
> 2.6.29). I got the following message when starting "latency" :
> 
> Any idea?
> 
> # /usr/xenomai/bin/latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> Unhandled fault: external abort on non-linefetch (0x01a) at 0x40006010
> 
> 
> # uname -a
> Linux armadeus 2.6.29.6 #1 PREEMPT Fri Oct 30 13:11:26 CET 2009 armv4tl
> unknown
> 
> # cat /proc/ipipe/version
> 1.13-00
> 
> 
> Looks like there was a discussion  about a similar problem some days ago
>  with Gilles  (Freescale CPU too).
> 
> http://www.mail-archive.com/xenomai@xenomai.org

Yes, the result of which is that you need some code to allow code not
running in supervisor mode to access I/O addresses.

You can also configure xenomai with --enable-arm-mach=generic, which
will avoid access to I/Os from user-space.

-- 
					    Gilles.

