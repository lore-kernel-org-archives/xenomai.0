Date: Thu, 19 Mar 2015 21:06:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150319200657.GB6571@hermes.click-hack.org>
References: <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <20150319164831.GD787@hermes.click-hack.org>
 <20150319172615.GF25508@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319172615.GF25508@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Building with hard float: cannot open shared object
 file libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 01:26:15PM -0400, Lennart Sorensen wrote:
> On Thu, Mar 19, 2015 at 05:48:31PM +0100, Gilles Chanteperdrix wrote:
> > 300 or 1000 instructions are executed in a very short time, not in a
> > 3 milliseconds, otherwise it would mean that each instruction takes
> > 10us or so to execute. Typically, in an ideal situation on a 1GHz
> > processor, an instruction takes 1ns to execute, that is an order of
> > magnitude smaller. So, even if the situation is not ideal, that is
> > still far from the numbers reported by Steve. 
> 
> Well apparently on the Cortex-A8 FPU instructions take 10 or more clock
> cycles to execute, versus 1 in most cases on the Cortex-A9, so 300
> instructions starts to add up.

10 cycles at 1 GHz, is still 10ns, not 10us. That is still 1/1000.

And I do not really believe the cortex a8 is 10 times slower than
the cortex a9, I have benchmarked hand optimized 12x12 matrix
multiplications using doubles (so which can not be implemented with
neon), on both omap3 at 720MHz and omap4 at 1GHz, and I do not
remember such difference between the benchmarks. Maybe A9 is 2 or 3
times faster, but not 10 times.

-- 
					    Gilles.

