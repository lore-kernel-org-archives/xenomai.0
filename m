From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46FF8BB9.9080207@domain.hid>
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
	<46FA26ED.4070505@domain.hid>  <46FF78DF.7090104@domain.hid>
	<1191149545.5989.7.camel@domain.hid> <46FF81BA.1020506@domain.hid>
	<46FF8BB9.9080207@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 21:45:06 +0200
Message-Id: <1191181506.5989.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] crashing 2.6.22 (was: [Xenomai-help] Non-APIC
	setup broken for	2.4-SVN?)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-09-30 at 13:42 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
> ...
> >>>  And a third
> >>> one only gives me "Detected illicit call from domain Xenomai" before the
> >>> box reboots. :(
> >> Grmff... Do you run with your smp_processor_id() instrumentation in?
> > 
> > Yes, but I suspect this is just a symptom of some severe memory
> > corruption that (also?) hits I-pipe data structures. I just put in some
> > different instrumentation, and that warning is gone, the box just hangs
> > hard at a different point. Very unfriendly.
> 
> Hah! Got some crash log by hacking a raw printk-to-uart:
> 

Btw, if it's based on fiddling with the 16550 directly as I imagine it
is, you may want to push me a patch. We already have this feature for
blackfin and powerpc (__ipipe_serial_debug(const char *fmt, ...)), and
it definitely makes sense to have it for x86* too.

-- 
Philippe.



