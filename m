Subject: Re: [Xenomai-core] official TSC model on SMP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <450D3764.80601@domain.hid>
References: <450D3764.80601@domain.hid>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 19:15:28 +0200
Message-Id: <1158513328.4979.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Sun, 2006-09-17 at 13:54 +0200, Jan Kiszka wrote:
> Hi,
> 
> reading through timer code of Xenomai I just wondered (again) what our
> official model of TSCs on multiprocessor boxes are:
> 
> 1) (practically) perfectly synchronised without offset
> 
> 2) synchronised but with (unknown?) offset
> 
> 3) unsynchronised

The current model is unsynchronized. If anything from the codebase is
found relying on the opposite, be it partially or fully, then it's
utterly broken in the SMP case, and I'm likely the one to blame.
IOW, we don't currently provide any guarantee to anyone that a timestamp
could be interpreted anywhere else than the CPU it was read from, and
leave all the related burden to the application developer (e.g. by mean
of managing CPU affinity constraints and the like).

> 
> I'm asking because I worried about timestamps taken on external events
> like interrupts on one CPU and are then used to trigger some timed
> operation on another. Such things may easily happen via RTDM devices
> where we do not communicate the CPU source of event timestamps. But
> there is also other code influenced by the TSC model, e.g. data
> collection and evaluation for CPU load stats.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



