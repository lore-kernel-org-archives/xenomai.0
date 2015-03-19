MIME-Version: 1.0
In-Reply-To: <20150319190007.GI25508@csclub.uwaterloo.ca>
References: <CAEMXjGy3J+aFoCNdvugUKDOunzqk=sE3aSybHuL-_xK6qiea7w@mail.gmail.com>
 <20150319140703.GC25508@csclub.uwaterloo.ca>
 <20150319144041.GB787@hermes.click-hack.org>
 <20150319155939.GD25508@csclub.uwaterloo.ca>
 <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
 <20150319165400.GE787@hermes.click-hack.org>
 <CAEMXjGxVHjAbLh0jEWF1fJbdVA+1PhiEa1oF9KbNXiEaqCJr8A@mail.gmail.com>
 <20150319180559.GH25508@csclub.uwaterloo.ca>
 <20150319190007.GI25508@csclub.uwaterloo.ca>
Date: Thu, 19 Mar 2015 12:12:06 -0700
Message-ID: <CAEMXjGzUcnujGyKEbhaBm1EpQ-WrNbM4+sMH1xjU3xVt7cf0ew@mail.gmail.com>
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

On Thu, Mar 19, 2015 at 12:00 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Thu, Mar 19, 2015 at 02:05:59PM -0400, Lennart Sorensen wrote:
> > On Thu, Mar 19, 2015 at 11:00:12AM -0700, Steve B wrote:
> > > Yes, that's a good idea, or maybe sqrt(b)*b*b*b*b would even work
> better,
> > > since it's just a few multiplies and a square root.
> >
> > The run just passed 165000 instructions for that one call to pow().
>
> Total came to: 249316 instructions.
>
> Ouch!
>
> --
> Len Sorensen
>

Thanks for looking into it.. that's pretty close to my 3ms figure at 10
clocks per instruction.
I'm a curious why it's actually a bit better with the non-hf compiler, but
I think it may be a moot point. The more important thing is to replace
these with alternative ways to compute the same result. Doing everything
fixed point could have been a good design choice from the beginning, as
well...

Steve
