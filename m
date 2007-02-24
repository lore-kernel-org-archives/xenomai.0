From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17887.18450.939044.430454@domain.hid>
References: <1170205077.21219.67.camel@domain.hid>
	<1172247508.26738.67.camel@domain.hid>
	<17887.18450.939044.430454@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 11:17:44 +0100
Message-Id: <1172312265.2161.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] Re: Heads up: Xenomai port over
	x86_64 has started
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, adeos-main@gna.org, xenomai@xenomai.org

On Fri, 2007-02-23 at 21:01 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Wed, 2007-01-31 at 01:58 +0100, Philippe Gerum wrote:
>  > > Ok, no more distant rumblings about x86_64: a Xenomai port to this
>  > > architecture has officially started. A preliminary version of the I-pipe
>  > > for x86_64 is now available, which I'm going to use to port the Xenomai
>  > > core.
>  > 
>  > Here we are. The following revised I-pipe patch is stable enough to run
>  > the Xenomai trunk/ on a 4-way Opteron, and on qemu-x86_64 0.8.2 too:
>  > http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.19-x86_64-1.0-02.patch
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

AFAICS, you still have an i387 to deal with. I would rather suspect an
issue with some revised logic in the regular task switching code.
Sidenote: the Xenomai/x86_64 switch code eliminates the "switch-to-self"
issue we discussed recently for x86, and I noticed this would break our
x86 FPU logic doing so, so maybe there is something to dig here. I'll
check this asap.

> By the way, there is a change that I made to the i386 context switching
> routine which I think you should make to the x86_64 one: mark all
> register as output registers, this prevent the compiler from considering
> that the value of a particular register survived the context
> switch.
> 

Indeed, my clobber list won't help for input registers. Will fix.

-- 
Philippe.



