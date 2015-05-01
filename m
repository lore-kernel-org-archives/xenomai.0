From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 1 May 2015 11:33:25 -0400
Message-ID: <20150501153325.GJ24389@csclub.uwaterloo.ca>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430212749.GB1993@hermes.click-hack.org>
 <20150501134547.GF24389@csclub.uwaterloo.ca>
 <20150501135651.GE1993@hermes.click-hack.org>
 <20150501143631.GH24389@csclub.uwaterloo.ca>
 <20150501144428.GI1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150501144428.GI1993@hermes.click-hack.org>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, May 01, 2015 at 04:44:28PM +0200, Gilles Chanteperdrix wrote:
> That is what the cortex A9 did, the twd local timers and the global
> timer are derived from the cpu clock. That said, the twd are still
> available on A15 I guess, so maybe the global timer is also
> available?

Well it looks like the A15 and newer do in fact not have that one.

Looking at the kernel driver for twd, it appears that when the cpu
changes frequency, the timer has to be reprogrammed to match which the
arch timer on the A15 does not because it is a fixed rate.  I suspect
because of the virtualization extensions, having a fixed rate clock that
guests can read and use too was considered important.  Too bad it is
rather low precision.

> I do not know how that is computed. I do not think I did my
> calculations wrong. Maybe the kernel does not use the raw value for
> sched_clock, but something transformed with some shifts and
> multiplies, and it tells you in how much time that transformed
> counter wraps.

There is some talk of a 50% or 12.5% safety margin, but that doesn't
explain it either.  Looks like a bug somehow.

Your calculation looks right, the kernel's looks crazy.

-- 
Len Sorensen

