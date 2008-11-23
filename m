From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 24 Nov 2008 00:35:05 +0100
References: <200811190056.12595.berlemont.hauw@domain.hid>
	<492637CB.1000707@domain.hid>
In-Reply-To: <492637CB.1000707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811240035.05589.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-core] Unstable driver integration policy
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

Hi Philippe,
Hi Jan,

Many thanks for your answers.

> > I would like to find a way to populate the Comedi drivers set.
> >
> > However, I am stuck by a simple fact: I have no acquisition board to
> > validate a least driver...
> >
> > Starting from here, I am trying to find out what should be the proper
> > method to provide non-validated drivers to anybody inclined to test them.
> >
> > Do you think creating a specific subversion branch for this stuff would
> > be a good idea ?
>
> I don't think so. Moving that code away from the focal point where people
> are expected to find new code to test and work with won't help.
>
> You could decide instead to implement drivers for a small set of very
> popular acquisition cards; whether that implementation is eventually fully
> validated or not depends on other people to have enough interest in that
> work to give you access to some hw, or to validate the driver themselves.
> As Jan pointed out, "experimental" is a convenient sticker to tell people
> about the exact state of this work.
>
> You spark the effort (this is _always_ the hardest and most demanding part
> of the job), they help finalize it if they want to get serious about this.

OK. I thought adding unstable drivers into the trunk was too risky. I forgot 
about using the experimental flag.

Regards,

Alexis.


