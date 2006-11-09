From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
Date: Thu, 9 Nov 2006 21:52:01 +0100
References: <E1GiChy-0006Bp-5K@mailer.emlix.com> <45538D53.5090305@domain.hid>
In-Reply-To: <45538D53.5090305@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611092152.01896.Sebastian.Smolorz@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > However, there is one disturbing issue. When I execute
> >
> > dd if=/dev/zero of=/dev/null
> >
> > and the latency test in userspace with a period not less than 150 us the
> > worst case latency is about 220 us. But when I start latency with -p 100
> > I get a softlock like the one attached. I guess this is the same problem
> > as Detlef Vollmann described in [2]. So I think it's time for a big fat
> > ARM-specific warning in the troubleshooting file and perhaps a
> > modification of the testsuite so that if being compiled for ARM the
> > default sample periods are greater than the 100 us now.
>
> Something is preventing the watchdog kthread from being executed for
> more than 10 s. Maybe this is just a sign that the systems is hopelessly
> overloaded (what are average latencies?).

They are 120-130 us.

> Maybe it is a real IRQ or 
> scheduling issue in Linux caused by I-pipe. Maybe it is time to port the
> I-pipe tracer... ;)

With the latest Adeos upgrade for ARM the I-pipe tracer was integrated, wasn't 
it? I was already taking its usage into account.

Sebastian

