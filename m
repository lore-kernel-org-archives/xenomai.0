From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.62.0907232117060.9450@domain.hid>
References: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
	<4A688232.6040403@domain.hid>
	<Pine.LNX.4.62.0907231741280.9450@domain.hid>
	<4A68A3F5.1000705@domain.hid>
	<Pine.LNX.4.62.0907232117060.9450@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Jul 2009 22:27:27 +0200
Message-Id: <1248380847.3998.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX skin,
 simple example with mutex not working...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2009-07-23 at 21:28 +0200, Kolja Waschk wrote:
> Hi,
> 
> > However, I really think we whould fix this issue. Not having access to a
> 
> Sure, but I'm afraid I can't work much on it once I found one working
> combination...

A sane combo for now should be 2.6.28.10, with
http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.28.10-blackfin.git-1.10-00.patch
on top of it, and Xenomai 2.4.8 stock.

> I furthermore have strong problems using GDB here;
> sometimes it doesn't halt at breakpoint main() but the program simply
> runs over it and exits successfully, sometimes it segfaults or reboots.
> > issue with a stable release of xenomai such as xenomai 2.4.8 ?
> 
> It seems to. At least the very same "try", when run on an older
> uClinux-dist release from the Blackfin uClinux site (2008R1.5-RC3, with
> Xenomai 2.4.0), returns zero from all mutex_lock attempts.
> 

2.4.0 is way too old; you may use any later Xenomai version with older
uClinux releases, we try hard to maintain backward compatibility.

If you want to run 2.6.30 kernels though, you will need the current tip
of our maintenance branch for the Xenomai 2.4.x series
(git://xenomai.org/xenomai-2.4.git), or something >= 2.5-rc2
(git://xenomai.org/xenomai-head.git).

> However, the app that I just converted to use the native API now returns
> -1 from one particular rt_mutex_acquire :/ on the old dist, and
> at some point reboots the target on the new...
> 

I confirm that we have a problem with 2.5-rc over blackfin, POSIX mutex
locking attempts do spuriously return EPERM as you reported. This does
not happen on 2.4.x (maintenance branch) with the same test kernel
(2.6.30); I'm suspecting an issue in our non-fastsync code, since 2.4
did not have this new Xenomai feature, and blackfin has it disabled for
now in 2.5. I'll have a look.

> Kolja
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



