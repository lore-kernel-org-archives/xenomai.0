From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 19 Mar 2015 13:48:35 -0400
Message-ID: <20150319174835.GG25508@csclub.uwaterloo.ca>
References: <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
 <20150317213457.GZ25508@csclub.uwaterloo.ca>
 <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
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
To: Steve B <sbattazzo@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 09:49:45AM -0700, Steve B wrote:
> Hi guys,
> Here are some input values that have caused problems for me:
> 
> b=0.975800; c= 7.000000;
> b = -1789009.391544; c = 6.000000;
> b= 42442350436303.453125; c = 4.500000;

I am trying the last one right now.  It is still counting instructions.
It has been at it for many minutes.  According to
http://developerblog.redhat.com/2015/01/02/improving-math-performance-in-glibc/
the way it is implemented, it uses a lookup table in many cases, but if
it determines the loopup table method won't be accurate, then it goes of
an calculates the solution in multiple steps, which includes calculating
a 768bit precision result, and then rounding that to a double.  It is
of course very slow when this happens.  The page mentions improving the
slowest path of pow by 8 times.  Of course your current glibc won't have
those improvements yet.  I will post the number of instructions when I
get it.  I may have to go get lunch first.  It is at 94000 instructions
so far and I have no idea how much might be left.

Well actually it seems to say glibc 2.18 has those improvements.  I should
try a run compiled against that (I was using 2.13 from Debian Wheezy)

> (where I am doing a = pow(b,c);)
> Interestingly the first two took a long time in my actual application but
> not in my test program where I was just plugging them straight into the
> pow() function. I guess there may be some difference in compile options
> that I need to take a look at to see what is going on.
> And the third one (yeah, that's a huge number!) takes a very long time no
> matter what, and seems to take much longer with the hf compiler.
> 
> Let me know if this looks interesting..
> My original plan was to try to get my algorithm designer to get rid of the
> pow() calls wherever he can, and hopefully that will get us straightened
> out...

-- 
Len Sorensen

