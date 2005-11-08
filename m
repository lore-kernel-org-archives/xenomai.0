Date: Tue, 8 Nov 2005 17:21:21 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] [BUG] scheduling order of dying shadow threads
In-Reply-To: <4370C966.3030903@domain.hid>
Message-ID: <Pine.GSO.4.58.0511081718500.29753@domain.hid>
References: <4370641D.7010906@domain.hid>
	<4370C966.3030903@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On Tue, 8 Nov 2005, Philippe Gerum wrote:

> Jan Kiszka wrote:
> > Hi Philippe,
> >
> > I think this one is for you: ;)
> >
> > Sebastian got almost mad with his CAN driver while tracing a strange
> > scheduling behaviour during shadow thread deletion for several days(!) -
> > and I was right on the way to follow him yesterday evening. Attached is
> > a simplified demonstration of the effect, consisting of a RTDM driver
> > and both a kernel and user space application to trigger it.
> >
>
> I've spotted the issue in nucleus/shadow.c. Basically, the root thread priority
> boost was leaking to a non-shadow thread due to a missing priority reset in the
> lostage APC handler, whilst a shadow was in the process of relaxing. Really
> funky bug, thanks! :o> Fixed in the repo hopefully for good. The scheduling
> sequence is now correct with your demo app on my box.

Thank you, problem has disappeared here, too! :-)


Sebastian

