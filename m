From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] RE: LTTng intergration roadmap
Date: Wed, 17 May 2006 16:12:54 +0900
References: <FDBBB5CC70676540B3EF7CFE83FD94E04A4528@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E04A4528@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200605171612.54463.rlenglet@domain.hid>
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

ROSSIER Daniel wrote:
> The project consists in enhancing LTTng with Xenomai events
> and some specific algorithmic filtering on the related events,
> such as detecting abnormal situations (deadline misses,
> priority inversion at a certain level, etc.); the way how
> events are presented are also an issue to be considered
> (events per threads and not per process, different ways to
> represent the events).

=46or visualization, I recommend you to take a look at Paj=E9:
http://www-id.imag.fr/Logiciels/paje/

It is free software (LGPL):
http://forge.objectweb.org/projects/paje/

I have seen it used for the visualization of events (for the=20
analysis of deadlocks, etc.) in a heavily multi-threaded Java=20
application. A custom Linux module collected all the events, and=20
Paj=E9 was used "post-mortem" for visualization of the events.
It seems very similar to what you want to do, except that you=20
would use LTTng instead of a custom module to record events.

And there are nice publications about Paj=E9 for your student to=20
cite. ;-)

=2D-=20
Romain LENGLET

