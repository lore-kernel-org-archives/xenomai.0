Message-ID: <4CC2C361.5020608@domain.hid>
Date: Sat, 23 Oct 2010 13:13:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>
	<1283531433.789315367@domain.hid>
	<1283590285.1709.2153.camel@domain.hid>
	<1287134519.029617765@domain.hid>
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
	<1287496324.10921156@domain.hid> <4CBDF92F.20403@domain.hid>
	<1287832106.517512323@domain.hid>
In-Reply-To: <1287832106.517512323@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Thanks, this script sounds like exactly what I need. I downloaded the
> latest snapshot of mkrootfs from git, but I don't want to install that
> on my rootfs. I'd just download the script alone, but looking at it I
> see it would want to run a script in /ltp as well, so I guess I need ltp
> too. Can you tell me an easier way to set up dohell that might save me
> sifting through the whole of ltp and mkrootfs to figure it out?

Well, you need to compile LTP. Building LTP (at least the version we use
to validate Xenomai) is a bit peculiar in cross-compiled environment,
but should be straight-forward if you are not cross-compiling. You
should find some documentation here:
http://ltp.sourceforge.net/documentation/how-to/ltp.php


-- 
                                                                Gilles.

