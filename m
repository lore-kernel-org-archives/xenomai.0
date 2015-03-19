MIME-Version: 1.0
In-Reply-To: <20150319164326.GE25508@csclub.uwaterloo.ca>
References: <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
Date: Thu, 19 Mar 2015 09:49:45 -0700
Message-ID: <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Thu, Mar 19, 2015 at 9:43 AM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Thu, Mar 19, 2015 at 05:04:03PM +0100, Gilles Chanteperdrix wrote:
> > My point was, there may be some pathological values that may involve
> > using expm1 or logp1 instead of log or exp, and so to avoid pow
> > entirely. Also, I am not sure pow optimizes the case where b is an
> > integer. It would be interesting to know the actual values of a and
> > b which cause pow to explode.
>
> Could be.
>
> For fun I checked how many instructions it took to execute
> pow(1.234000,12.200000) to get 13.003041 and according to my gdb run,
> it took 1151 instructions.  Now I did not enable optimization for that
> build, which might matter.  Those were of course not all floating pointer
> instructions, but quite a few of them are.
>
> With -O3, it dropped to 303 instructions.
>
> I should try the same test on armel to see what difference it shows just
> because I am curious.  I would have to setup an armel chroot to run
> in first.
>
> --
> Len Sorensen
>

Hi guys,
Here are some input values that have caused problems for me:

b=0.975800; c= 7.000000;
b = -1789009.391544; c = 6.000000;
b= 42442350436303.453125; c = 4.500000;

(where I am doing a = pow(b,c);)
Interestingly the first two took a long time in my actual application but
not in my test program where I was just plugging them straight into the
pow() function. I guess there may be some difference in compile options
that I need to take a look at to see what is going on.
And the third one (yeah, that's a huge number!) takes a very long time no
matter what, and seems to take much longer with the hf compiler.

Let me know if this looks interesting..
My original plan was to try to get my algorithm designer to get rid of the
pow() calls wherever he can, and hopefully that will get us straightened
out...

Steve
