From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 20 Mar 2015 09:58:56 -0400
Message-ID: <20150320135856.GM25508@csclub.uwaterloo.ca>
References: <20150319160403.GC787@hermes.click-hack.org>
 <20150319164326.GE25508@csclub.uwaterloo.ca>
 <CAEMXjGyOG8340cOOYJiPgugfka7L01yRGaXgufWDWiURZcVQcw@mail.gmail.com>
 <20150319165400.GE787@hermes.click-hack.org>
 <CAEMXjGxVHjAbLh0jEWF1fJbdVA+1PhiEa1oF9KbNXiEaqCJr8A@mail.gmail.com>
 <20150319180559.GH25508@csclub.uwaterloo.ca>
 <20150319190007.GI25508@csclub.uwaterloo.ca>
 <CAEMXjGzUcnujGyKEbhaBm1EpQ-WrNbM4+sMH1xjU3xVt7cf0ew@mail.gmail.com>
 <20150319192415.GJ25508@csclub.uwaterloo.ca>
 <20150319203313.GL25508@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150319203313.GL25508@csclub.uwaterloo.ca>
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

On Thu, Mar 19, 2015 at 04:33:13PM -0400, Lennart Sorensen wrote:
> On Thu, Mar 19, 2015 at 03:24:15PM -0400, Lennart Sorensen wrote:
> > I am running a count on the number of instructions used with softfloat
> > right now.  It is at 130000 and counting.
> 
> Softfloat is now at 642000 and counting.

At 1600000 instructions my softfloat test ran out of ram.

Hard float using glibc 2.19 needed 149339, so that is quite an improvement
over glibc 2.13.  Still quite a lot though.

-- 
Len Sorensen

