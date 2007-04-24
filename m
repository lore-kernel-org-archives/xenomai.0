Message-ID: <bc4264770704240514i4478b0a4p890540bee5da8d8b@domain.hid>
Date: Tue, 24 Apr 2007 12:14:59 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
In-Reply-To: <462DE13C.7030305@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45F68258.5040603@domain.hid> <460B7FDF.8030100@domain.hid>
	<460BECFD.2030003@domain.hid> <460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
	<17964.64208.463335.611234@domain.hid>
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
	<462DC874.20303@domain.hid>
	<bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>
	<462DE13C.7030305@domain.hid>
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

> > I am aware of this. For the current machine I will stick to this.
> >
>
> Then don't complain. :)
Yes sir!
:)
Not complaining really, I think and I hope that the latency of 30us
average will do nicely for me. Just curious actually.

> > to be give worse latencies than much slower machines. Are the 2
> > interrupts causing the latency?
>
> Those two increase the latency of code in timed tasks, for sure. The
> question is if your measurement on the slower machine also included this
> scenario (timer event + 2 IRQs in a row). This definitely doesn't happen
> often, and maybe timing on the slower box makes it less likely. Or there
> is one potential IRQ source more on your fast box (e.g. due to IRQ
> sharing on the slower one).
>
> You see, RT system design on the edge (ie. when hunting a few 10 us) is
> tricky and not easily portable from box X to box Y.

Its not possible to determine which IRQ's are responsible for this
from the trace I presume?


Roland
>
> Jan
>
>
>

