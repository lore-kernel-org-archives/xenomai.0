From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 1 Apr 2014 17:45:39 -0400
Message-ID: <20140401214539.GD17765@csclub.uwaterloo.ca>
References: <20140331215933.GY17765@csclub.uwaterloo.ca>
 <20140331220421.GZ17765@csclub.uwaterloo.ca>
 <5339E80C.9020604@xenomai.org> <5339EBE1.3060907@xenomai.org>
 <20140401013227.GA17765@csclub.uwaterloo.ca>
 <533A9A7C.7020408@xenomai.org>
 <20140401131257.GB17765@csclub.uwaterloo.ca>
 <533B14FC.1000007@xenomai.org>
 <20140401194053.GC17765@csclub.uwaterloo.ca>
 <533B270F.4060702@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533B270F.4060702@xenomai.org>
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

On Tue, Apr 01, 2014 at 10:52:31PM +0200, Gilles Chanteperdrix wrote:
> On 04/01/2014 09:40 PM, Lennart Sorensen wrote:
> > On Tue, Apr 01, 2014 at 09:35:24PM +0200, Gilles Chanteperdrix wrote:
> >> On 04/01/2014 03:12 PM, Lennart Sorensen wrote:
> >>> On Tue, Apr 01, 2014 at 12:52:44PM +0200, Gilles Chanteperdrix wrote:
> >>>> The way I test it is by running xeno-regression-test, using dohell with
> >>>> LTP to create a load. Note that the latency result given by
> >>>> xeno-regression-test should not be taken into account as switchtest is
> >>>> running concurrently and creates large non-preemptible sections,
> >>>> xeno-regression-test is more a stress test.
> >>>
> >>> I will see if I can find the invocation to run that then.
> >>>
> >>> I let cyclictest, switchtest and latency running the last 8 hours,
> >>> and latency test currently says:
> >>>
> >>> RTD|     -0.814|      2.441|      7.486|       0|     0|     -2.116|     20.182
> >>>
> >>> That seems decent at least.
> >>>
> >>
> >> I use:
> >> xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
> >>
> >> Where the machine with ip 192.168.0.5 has the "discard" service enabled
> >> (port 9, available in inetd), an usb key is mounted on /mnt, and LTP is
> >> installed in /ltp.
> > 
> > I get an error when I use the -s option.
> 
> Probably because the machine with the IP address you pass after -s does
> not have the "discard" service enabled in inetd.conf

I thought I had.

root@omap5:~# grep RTIPC /boot/config-3.12-1-dra7xx 
CONFIG_XENO_DRIVERS_RTIPC=m
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y

Maybe I forgot to load the module....  Yep that was it.

Then I got to this:

Started child 14296: /usr/lib/xenomai/testsuite/latency xeno-regression-test -l dohell -s 10.200.19.25 -m /mnt -l /mnt -t 2
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
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.
/usr/bin/xeno-regression-test failed: child 14296 exited with status 2

I was running:

xeno-regression-test xeno-regression-test -l "dohell -s 10.200.19.25 -m /mnt -l /mnt" -t 2

Maybe I got something wrong.

ltp is installed to /mnt (which is a USB stick).

-- 
Len Sorensen

