From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 19 Mar 2015 16:32:15 -0400
Message-ID: <20150319203215.GK25508@csclub.uwaterloo.ca>
References: <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <20150319164831.GD787@hermes.click-hack.org>
 <20150319172615.GF25508@csclub.uwaterloo.ca>
 <20150319200657.GB6571@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319200657.GB6571@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 09:06:57PM +0100, Gilles Chanteperdrix wrote:
> 10 cycles at 1 GHz, is still 10ns, not 10us. That is still 1/1000.
> 
> And I do not really believe the cortex a8 is 10 times slower than
> the cortex a9, I have benchmarked hand optimized 12x12 matrix
> multiplications using doubles (so which can not be implemented with
> neon), on both omap3 at 720MHz and omap4 at 1GHz, and I do not
> remember such difference between the benchmarks. Maybe A9 is 2 or 3
> times faster, but not 10 times.

The A8 is not 1/10 the speed of an A9.  The FPU of the A8 is about 1/10
the speed of the A9, but given there is often integer math going on and
other logic, you won't be hurt that bad in general.  My experience on
generic code is that the A9 is about twice the speed of the A8, so your
2 or 3 times agrees with that.  Really FPU heavy code would be worse
than that, but I doubt it would be easy to make code that actually showed
a 10 times difference between them.

-- 
Len Sorensen

