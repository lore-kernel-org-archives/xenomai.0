Message-ID: <4DB83CBE.5040007@domain.hid>
Date: Wed, 27 Apr 2011 17:56:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>
In-Reply-To: <4DB8149A.7080600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
> Hi,
> 
> I'm trying to run Xenomai on MINI2440 board. I use vanilla 2.6.35.9
> kernel patched with adeos-ipipe-2.6.35.9-arm-1.18-01.patch . In kernel
> configuration Xenomai is disabled, the only option (except debug) I
> turned on is CONFIG_IPIPE. It hangs.
> 
> I suspect it is somehow related to TIMER3 which is used along with
> TIMER4 on Samsung ARMs. Any suggestions?

There was a bug some time ago, which was fixed for TIMER3, see commit:
http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=ebf2fac4298e25509ba47942b9fad408dcefce1e

But I think your problem has more to do with the following commit, could
you try reverting it?
http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=6ab29d9c7a4b119f45ef4d93780e894fe1c0c6c6;hp=cd9c5e016092258d4450e137be2d0844d0fe8b38

The same issue was reported on ixp4xx.

-- 
					    Gilles.

