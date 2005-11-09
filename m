Date: Wed, 9 Nov 2005 19:59:41 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] RT pipes
In-Reply-To: <43723E2E.4060405@domain.hid>
Message-ID: <Pine.GSO.4.58.0511091956150.6115@domain.hid>
References: <Pine.GSO.4.58.0511091817070.29250@domain.hid>
	<43723BF0.3000207@domain.hid> <43723E2E.4060405@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 9 Nov 2005, Philippe Gerum wrote:

> Philippe Gerum wrote:
> > Sebastian Smolorz wrote:
> >
> >> Hi,
> >>
> >> I've spotted a -- in my view -- strange behaviour of RT pipes in the
> >> native skin. The scenario is as follows:
> >>
> >> A RT task creates a RT pipe and writes some bytes into it. A NRT
> >> counterpart reads from this pipe, but not all bytes. Afterwards, the RT
> >> task deletes the pipe.
> >>
> >> Now the program is re-run: RT task creates the pipe, writes some bytes,
> >> and the NRT part reads some bytes, but begins with the old ones which
> >> weren't read during the first run of the program.
> >>
> >> Now my question: Is this behaviour intentional?
> >
> >
> > Nope.
> >
> >  If it is then I see the
> >
> >> following problem: A task which calls rt_pipe_create() cannot be sure
> >> that
> >> the pipe is empty. So it should be able to clear the pipe before use
> >> but I
> >> found no function that allows a RT task to clear the pipe.
> >>
> >
> > ioctl(fd,XNPIPEIOC_FLUSH,0) would do, but still, we should clear the
> > output queue when closing the kernel side. In the same vein, closing the
> > user-space side does not clear the input queue that feeds the kernel
> > side. Thanks for spotting this.
> >
>
> Ok, fixed.

Thanks, now it works! :-)


Sebastian

