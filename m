From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1240482629.7599.45.camel@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 13:48:08 +0200
Message-Id: <1240487288.6990.71.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] adeos patch 2.6.28.9-x86-2.2-07 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vikesh Rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2009-04-23 at 12:30 +0200, Vikesh Rambaran wrote:
> Hi
> 
> On Thu, 2009-04-23 at 11:37 +0200, Philippe Gerum wrote:
> > On Thu, 2009-04-23 at 11:20 +0200, vikesh rambaran wrote:
> > > Hi
> > > 
> > > Thanx for the updated patch. Some feedback ...
> > > 
> > > I tested it with Xenomai 2.4.7 under Ubuntu 8.04.2  on three different
> > > platforms 
> > > (AMD Athlon Desktop, Intel Core 2 Desktop, Intel Core Duo Laptop)
> > > 
> > > Typical system lockups when in the gnome desktop do NOT occur
> > > anymore ! Great :)
> > > 
> > > Initial observations when compared to Xenomai 2.4.5 with
> > > adeos-ipipe-2.6.24-x86-2.0-07.patch.  :
> > > 
> > > 1. Latency test shows a slight increase of about 5 to 10 % on the
> > > Intel platforms. 
> > > (Still need to do the comparison on the AMD platform). This translates
> > > to less than 5 uS 
> > > so it's ok for our case.
> > > 
> > > 2. On the Intel Core 2 Desktop, our application has a much more
> > > significant max scheduling jitter
> > > of about 125 uS (compared with < 60uS for Xenomia 2.4.5). This
> > > 'increased jitter' does not
> > > show up on the other two platforms. Still trying to trace this one.
> > 
> > Time for an I-pipe tracer log, with latency -f. I guess this
> > pathological jitter should trigger with standard tests as well; if it
> > does not, well, there might be other regression spots in the APIs.
> > 
> > .config would help as well. TIA,
> > 
> Thanx Philippe
> 
> To clarify, the latency test has not shown such significant jitter on
> any of the platforms. Latency tests only show up to about 40uS
> (normal). 
> 
> The high jitter shows up in 'our' application using 2.6.28.9-x86-2.2-07
> with Xenomai 2.4.7 on only one of the three platforms. 
> 
> [The same application does not show such high latencies using 
> Xenomai 2.4.5 with adeos-ipipe-2.6.24-x86-2.0-07.patch on any of the
> three platforms]
> 

Assuming that you have a mean to detect a latency spot situation from
your application, then I would suggest to go straight to the point, and
instrument your system as follow:

1) in your app, adapt the following pattern:

if (latency_too_high)
	xntrace_user_freeze(whatever, 0);

xntrace_user_freeze() is available to require the I-pipe tracer to take
a snapshot from the recent kernel execution path (see
include/nucleus/trace.h); with that information, you may find some hints
about the source of the latency spot.

2) enable CONFIG_IPIPE_TRACE (including *_MCOUNT)

3) run the app, fetch the trace data from /proc/ipipe/trace/frozen after
the latency spot showed up. We should find a "freeze" event tag close to
the root of the issue.

> Attached are the .config files of the last set of tests done.
> 

Thanks.

> I am going to test with CONFIG_NO_HERTZ and ACPI_PROCESSOR disabled
> as per Gilles suggestions on other emails.
> 
> 
> Keep well
> Vicki
> 
> 
> 
> 
> 
> 
-- 
Philippe.



