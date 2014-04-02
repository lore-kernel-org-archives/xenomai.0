From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 2 Apr 2014 09:24:01 -0400
Message-ID: <20140402132401.GF17765@csclub.uwaterloo.ca>
References: <5339EBE1.3060907@xenomai.org>
 <20140401013227.GA17765@csclub.uwaterloo.ca>
 <533A9A7C.7020408@xenomai.org>
 <20140401131257.GB17765@csclub.uwaterloo.ca>
 <533B14FC.1000007@xenomai.org>
 <20140401194053.GC17765@csclub.uwaterloo.ca>
 <533B270F.4060702@xenomai.org>
 <20140401214539.GD17765@csclub.uwaterloo.ca>
 <20140402023531.GE17765@csclub.uwaterloo.ca>
 <533BB83F.5040301@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533BB83F.5040301@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
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

On Wed, Apr 02, 2014 at 09:11:59AM +0200, Gilles Chanteperdrix wrote:
> On 04/02/2014 04:35 AM, Lennart Sorensen wrote:
> > All I changed was the -l option, which I changed to the location I
> > installed ltp to.
> > 
> > Maybe xeno-regression-test is broken.  Maybe it assumes /bin/sh is bash
> > or something.
> > 
> I am using this command with ash (busybox shell) without any problem.
> Parsing these quotes is done by the interactive shell you are running,
> not xeno-regression-test itself.

This is the line that is causing issues as far as I can tell.

check_alive /usr/lib/xenomai/testsuite/latency ${1+"$@"}

So it is passing all the original arguments to latency for some reason,
and latency has no idea what -m is supposed to mean.

On Debian /bin/sh is dash, which is a pure posix shell.  If it isn't
posix, it isn't valid.  checkbashisms doesn't seem to think there is
anything wrong with that line though.

As far as this shows I think the quotes were right:

select service with posix message queues: success
++ start_load
++ echo start_load
++ check_alive /usr/lib/xenomai/testsuite/switchtest
++ echo check_alive /usr/lib/xenomai/testsuite/switchtest
++ check_alive /usr/lib/xenomai/testsuite/switchtest -s 1000
++ echo check_alive /usr/lib/xenomai/testsuite/switchtest -s 1000
++ check_alive /usr/lib/xenomai/testsuite/latency xeno-regression-test -l '/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt' -t 2
++ echo check_alive /usr/lib/xenomai/testsuite/latency xeno-regression-test -l '/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt' -t 2
++ wait_load
++ read rc
Started child 13475: dohell 900
Started child 13476: /usr/lib/xenomai/testsuite/switchtest
Started child 13481: /usr/lib/xenomai/testsuite/switchtest -s 1000
Started child 13484: /usr/lib/xenomai/testsuite/latency xeno-regression-test -l /usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt -t 2
/usr/lib/xenomai/testsuite/latency: invalid option -- 'm'
usage: latency [options]
  [-h]                         # print histograms of min, avg, max latencies
  [-g <file>]                  # dump histogram to <file> in gnuplot format
  [-s]                         # print statistics of min, avg, max latencies
  [-H <histogram-size>]        # default = 200, increase if your last bucket is full
  [-B <bucket-size>]           # default = 1000ns, decrease for more resolution
  [-p <period_us>]             # sampling period
  [-l <data-lines per header>] # default=21, 0 to supress headers
  [-T <test_duration_seconds>] # default=0, so ^C to end
  [-q]                         # supresses RTD, RTH lines if -T is used
  [-D <testing_device_no>]     # number of testing device, default=0
  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ
  [-f]                         # freeze trace for each new max latency
  [-c <cpu>]                   # pin measuring task down to given CPU
  [-P <priority>]              # task priority (test mode 0 and 1 only)
  [-b]                         # break upon mode switch

I just don't see what the point of passing $1 and company to the latency
test is.  It looks as if the -t 2 was supposed to go to the latency
test, and it looks as if the -l argument was ignored since it seems to
be running dohell 900 (the default) instead.

-- 
Len Sorensen

