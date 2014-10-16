Date: Thu, 16 Oct 2014 20:58:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141016185819.GF30661@sisyphus.hd.free.fr>
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141016181711.GB24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 16, 2014 at 02:17:11PM -0400, Lennart Sorensen wrote:
> On Thu, Oct 16, 2014 at 10:16:18AM +0200, Gilles Chanteperdrix wrote:
> > Also, vfpv3-d16 looks suspicious to me: you may be uselessly limiting
> > the number of vfp registers available to the compiler. If cat
> > /proc/cpuinfo tells you vfpv3 and not vfpv3-d16, you can use
> > -mfpu=vfpv3, if it tells you neon, you can use -mfpu=neon. I am almost
> > sure the beaglebone processor has 32 double vfp registers, not 16.
> > 
> > This page:
> > http://www.ti.com/product/AM3358/datasheet
> > 
> > Seems to imply that the beaglebone processor has NEON.
> 
> Neon is mandetory on Cortex-A8.  Only Cortex-A9 made it optional
> (unfortunately) and I believe nvidia was pretty much the only one to
> not include Neon.  Of course non Cortex designs don't have it either
> (Marvell JP4 cores for example), but those are pretty rare.  I have no
> idea if qualcomm's designs have it or not.

Well, I toyed with NEON a bit, and was surprised to discover that it
has no instruction to accelerate 64 bits maths despite the fact that
it has 128bits vectors, which for me means that you can not do any
serious math with it. After implementing a routine to average pixels
from a bayer pattern on cortex A8 (where I could use NEON) I got a
factor gain of 2 or 3, far from what could have been expected from
processing 16 pixels at once, and I got a biggest gain by inserting
the non-NEON "pld" instruction at key points (which I could do in
the non NEON code as well). I also do not really understand how NEON
accelerates memcpy, why is a NEON multiple registers load/store
faster than ldm/stm, is not it a problem in ldm/stm rather than a
virtue of NEON?

All this to say, is NEON that useful?

-- 
					    Gilles.

