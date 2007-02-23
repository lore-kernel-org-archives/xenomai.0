MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17887.18450.939044.430454@domain.hid>
Date: Fri, 23 Feb 2007 21:01:22 +0100
In-Reply-To: <1172247508.26738.67.camel@domain.hid>
References: <1170205077.21219.67.camel@domain.hid>
	<1172247508.26738.67.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, adeos-main@gna.org, xenomai@xenomai.org

Philippe Gerum wrote:
 > On Wed, 2007-01-31 at 01:58 +0100, Philippe Gerum wrote:
 > > Ok, no more distant rumblings about x86_64: a Xenomai port to this
 > > architecture has officially started. A preliminary version of the I-pipe
 > > for x86_64 is now available, which I'm going to use to port the Xenomai
 > > core.
 > 
 > Here we are. The following revised I-pipe patch is stable enough to run
 > the Xenomai trunk/ on a 4-way Opteron, and on qemu-x86_64 0.8.2 too:
 > http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.19-x86_64-1.0-02.patch
 > 
 > The status of the Xenomai/x86_64 port is as follows:
 > 
 > - real-time support in user-space is mostly ok, except the FPU
 > management over the Xenomai domain which is broken beyond all
 > recognition. Gilles, as already discussed, I won't resist to let you
 > bang your head on this wall instead of mine, because 1) this will allow
 > me to switch to the pending issues people have raised on the lists so
 > far, 2) I'm fundamentally evil, 3) the fact that you once did dare
 > rewriting the FPU support for Xenomai/x86 clearly shows that you do have
 > some masochistic tendencies anyway.

Ok, I will do it. Do you have an URL of a datasheet at hand (since the
x86 code does not work, there must be some difference) ?
By the way, there is a change that I made to the i386 context switching
routine which I think you should make to the x86_64 one: mark all
register as output registers, this prevent the compiler from considering
that the value of a particular register survived the context
switch.

-- 


					    Gilles Chanteperdrix.

