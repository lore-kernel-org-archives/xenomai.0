From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Fri, 11 Sep 2009 07:49:56 -0600
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03248BDE8A@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDDBD@midas.usurf.usu.edu>
	<4AA9E0CA.5030201@domain.hid>
In-Reply-To: <4AA9E0CA.5030201@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Negative Latency in test "in kernel timer
 handler"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > All,
> >
> > When I run the xeno-test to test my configuration, I noticed
> > something interesting.  The test mode "in kernel timer handler"
> shows
> > a negative minimum latency.
> >
> > Is this typical behavior?  It seems like a negative latency is not
> a
> > phyical possibility, though I guess it does depend on your
> reference
> > point.
>=20
> Xenomai makes the timer tick a bit early to reduce the latency.
> Generally, this anticipation is chosen to get a correct user-space
> scheduling latency, so may make the timer tick a bit early when
> looking
> at (kernel-space) interrupt latency. In any case, you can read and
> modify this anticipation by read and writing to the special file
>=20
> /proc/xenomai/latency
>=20
> The unit is nanoseconds.

Exactly what I needed to know.  Thank you!

Jonathan



