From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C3EF6D6.6040907@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Jul 2010 18:11:38 +0200
Message-ID: <1279210298.1995.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tim Cussins <timcussins@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-07-15 at 13:53 +0200, Gilles Chanteperdrix wrote:
> Tim Cussins wrote:
> > Hi all,
> > 
> > We're looking at migrating to one of Marvell's MV88F series SOC's, and
> > are very keen to deploy Xenomai as part of our solution.
> > 
> > I noticed Sergey Didenko was looking at this a few months back and
> > things looked to be ok - has his (or anyone else's) work made it into a
> > stable release?
> > 
> > I will be able to assist in about a fortnight if that would be useful
> > for squaring that work away.
> > 
> > Let me know if I can help!
> 
> We are interested. I seem to remember that Serguey had unexplained
> latencies issues, so, if you start with his work, please bear this in
> mind, there was probably something wrong with his port. A guide
> explaining how to port the I-pipe patch on ARM exists:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
> 
> The section about chained GPIOs irqs is outdated, if your platform has
> some, I will explain how it should be implemented.
> 
> Please start from the I-pipe git (git://git.denx.de/ipipe-2.6.git),
> merging it with the branch you will use if needed, so that you can
> submit a patch only containing the modifications necessary for the
> Sheeva platform.
> 
> We can also provide you with a root filesystem for validating this platform.
> 

You can also use the patch below as a starting point for your port:
http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch

caveats:

- it is based on an old kernel release, and moving to 2.6.3x would
require some work. If you need so, then you should merge the
arm-dependent bits from the patch above with the generic I-pipe bits
from a newer release as available here (e.g. 2.6.33):
http://download.gna.org/adeos/patches/v2.6/arm/

- the fcse implementation in that patch won't work with the l2 outer
cache enabled. The two options have been made mutually exclusive via
Kconfig.

- you should use Xenomai 2.5.3 or above to get this running.

As a reference point, the worst-case scheduling latency for user-space
threads, observed on a mv88f6290 using that patch with fcse enabled (no
l2), is below 70 us.

HTH,

-- 
Philippe.



