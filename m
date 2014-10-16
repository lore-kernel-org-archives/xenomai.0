From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 16 Oct 2014 16:56:21 -0400
Message-ID: <20141016205621.GC24110@csclub.uwaterloo.ca>
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <20141016181711.GB24110@csclub.uwaterloo.ca>
 <20141016185819.GF30661@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141016185819.GF30661@sisyphus.hd.free.fr>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 16, 2014 at 08:58:19PM +0200, Gilles Chanteperdrix wrote:
> Well, I toyed with NEON a bit, and was surprised to discover that it
> has no instruction to accelerate 64 bits maths despite the fact that
> it has 128bits vectors, which for me means that you can not do any
> serious math with it. After implementing a routine to average pixels
> from a bayer pattern on cortex A8 (where I could use NEON) I got a
> factor gain of 2 or 3, far from what could have been expected from
> processing 16 pixels at once, and I got a biggest gain by inserting
> the non-NEON "pld" instruction at key points (which I could do in
> the non NEON code as well). I also do not really understand how NEON
> accelerates memcpy, why is a NEON multiple registers load/store
> faster than ldm/stm, is not it a problem in ldm/stm rather than a
> virtue of NEON?

Not sure why it is faster on some designs.

> All this to say, is NEON that useful?

Well the vfp on the Cortex-A8 is rather slow, so neon is usually much
faster, however on the A9 and A15 the vfp is much faster and neon is
often no gain at all and often the same speed in fact.

-- 
Len Sorensen

