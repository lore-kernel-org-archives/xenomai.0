Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2006 08:45:25 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E04A4528@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] RE: LTTng intergration roadmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid, xenomai-core <xenomai@xenomai.org>

Hi Jan,

Sorry for my late answer.

> -----Message d'origine-----
> De=A0: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Envoy=E9=A0: lundi, 15. mai 2006 17:18
> =C0=A0: xenomai-core
> Cc=A0: Alexis Berlemont; ROSSIER Daniel
> Objet=A0: LTTng intergration roadmap
>=20
> Hi,
>=20
> the need for a high-level tracing tool constantly increases with the
> growing code base of Xenomai applications.
>=20
> Yesterday I started a short discussion with Alexis about the status of
> his LTTng combo patch, the Xenomai integration, and the advances of
> LTTng itself. But there are certainly more people interested in this
> topic and may contribute ideas, comments, or even concrete code.
>=20
> Daniel, you once said that some of your students would start to work =
on
> this topic. In which domain precisely, more at patch level or rather =
on
> tools? What is the scheduled beginning and/or deadline for this =
thesis?
>=20

Yes, it's right; my student is actually working on a first investigation =
in order to prepare its diploma project which starts from October to =
December.
So, the most insteresting results should not come up until then.=20

The project consists in enhancing LTTng with Xenomai events and some =
specific algorithmic filtering on the related events, such as detecting =
abnormal situations (deadline misses, priority inversion at a certain =
level, etc.); the way how events are presented are also an issue to be =
considered (events per threads and not per process, different ways to =
represent the events). We are therefore very open to some proposals and =
ideas.
The interesting thing is that Jean-Olivier (the student) will perform =
his project at Matthieu Denoyers's premises at Montreal; besides, he =
already visited him to have first discussions. I think this will help us =
greatly.

> Moreover, does anyone on this list recently tried LTTng on standard
> Linux? Can we consider it reasonably stable and usable? One new thing
> about LTTng internals which Alexis brought up were changes in the =
custom
> tracing event interface. As this is a rather crucial point with =
respect
> to the Xenomai instrumentation, we certainly do not want to change it
> back and forth until LTTng stabilises.
>=20
> Jan

Thanks also to Alexis. The way how to generated lttng events matches =
with how we're doing now; we will also examine his Xenomai events and =
give you a feedback.

Of course, we keep the forum informed about the progress, but as =
mentioned before, it risks to evolve quite slowly on our side since the =
"big" project is for the three last months.

Daniel


