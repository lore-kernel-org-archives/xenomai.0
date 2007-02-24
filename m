From: Paul <paul_c@domain.hid>
Date: Sat, 24 Feb 2007 12:34:14 +0000
References: <1170205077.21219.67.camel@domain.hid>
	<1172247508.26738.67.camel@domain.hid>
	<17887.18450.939044.430454@domain.hid>
In-Reply-To: <17887.18450.939044.430454@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702241234.14579.paul_c@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] Re: Heads up: Xenomai port over
	x86_64 has started
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: xenomai@xenomai.org, xenomai@xenomai.org


Hi Gilles

On Friday 23 February 2007 20:01, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Wed, 2007-01-31 at 01:58 +0100, Philippe Gerum wrote:
>  > > Ok, no more distant rumblings about x86_64: a Xenomai port to this
>  > > architecture has officially started. A preliminary version of the
>  > > I-pipe for x86_64 is now available, which I'm going to use to port the
>  > > Xenomai core.
>  >
>  > Here we are. The following revised I-pipe patch is stable enough to run
>  > the Xenomai trunk/ on a 4-way Opteron, and on qemu-x86_64 0.8.2 too:
>  > http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.19-x86
>  >_64-1.0-02.patch
>  >
>  > The status of the Xenomai/x86_64 port is as follows:
>  >
>  > - real-time support in user-space is mostly ok, except the FPU
>  > management over the Xenomai domain which is broken beyond all
>  > recognition. Gilles, as already discussed, I won't resist to let you
>  > bang your head on this wall instead of mine, because 1) this will allow
>  > me to switch to the pending issues people have raised on the lists so
>  > far, 2) I'm fundamentally evil, 3) the fact that you once did dare
>  > rewriting the FPU support for Xenomai/x86 clearly shows that you do have
>  > some masochistic tendencies anyway.
>
> Ok, I will do it. Do you have an URL of a datasheet at hand (since the
> x86 code does not work, there must be some difference) ?

http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_7044,00.html 
has links for assorted low level docs - Vol.5 should cover the area in 
question.

> By the way, there is a change that I made to the i386 context switching
> routine which I think you should make to the x86_64 one: mark all
> register as output registers, this prevent the compiler from considering
> that the value of a particular register survived the context
> switch.


Regards, Paul.


