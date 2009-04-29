Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2009 08:52:09 +0200
Message-ID: <DF9F3A3C150B0646A17FF1487C1B6D5E019F64AB@rennsmail06.eu.thmulti.com>
In-Reply-To: <49F73604.8070706@domain.hid>
From: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Subject: Re: [Xenomai-help] ARM interrupt latency
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
Cc: xenomai@xenomai.org

Thanks lot for your help and recommendation.
I will keep you up to date on my investigation,
Regards,
Jacques

Jacques DANIEL - Consultant ALTEN
Grass Valley - France
Rue du Clos Courtel
35517 Cesson S=E9vign=E9 Cedex
33 (0)2 99 27 38 38
=20
 Pensez =E0 l'environnement avant d'imprimer ce mail / Please consider =
the environment before printing
=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: mardi 28 avril 2009 19:00
To: Daniel Jacques (Alten)
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] ARM interrupt latency

Daniel Jacques (Alten) wrote:
> Hi all,
>=20
>=20
>=20
> I am using xenomai 2.3.4 on a product based on ARM1136.
>=20
> - I create several interrupt objects using "rt_intr_create" routine
> from user-space and their associated interrupt tasks that permanently
> wait for interrupt using "rt_intr_wait" routine.
>=20
> - The application contains also several user tasks to manage specific
> functionalities.
>=20
> - The processing in the interrupt tasks is very short: typically only
> resume the user task.
>=20
>=20
>=20
> By adding some embedded spies, I notice high latencies between
> interrupt task and user task (maximum 300=B5s, average 100=B5s).
>=20
> If I supposed inherent interrupt latency on ARM is around 30=B5s, I =
can
> explain the latency between interrupt task and user task by the
> important number of interrupts on my system (around 100 IRQ are
> generated in each period of 20ms). It means than only 5 or 6 IRQ at
> the same time can produced this effect ...

No the latency between interrupt and user task is due to the worst time
taken by a user-space context switch which, among other things contains
a full cache flush if you are using a VIVT cache. So, 300us is expected,
 especially with Xenomai 2.3.4, which does not contain any of the
optimizations which have been done in this area. I think 30us is overly
optimistic too, interrupt latency is probably more around 50us.

In any case, Xenomai ships with a tool called "latency" which will help
you find the latency of your system. Actually, the first thing you
should do when testing Xenomai on a platform is run the latency test to
get the figures of Xenomai on your platform.


>=20
>=20
>=20
> So, first I'd like to have your opinion on this interpretation ...
>=20
> And in a second step, do you think that It could be interesting and
> especially sufficient in term of performance, to directly manage
> interrupt in kernel space instead of user space?

Yes, managing interrupt in kernel-space is not only good for latencies,
it is good for design. By forcing you to split your code between driver
code and user application, it will help you write future proof code,
instead of spaghetti code with driver and application intermixed.

>=20
> Additionally, if I choose this solution, should I publish the source
> code (as kernel and xenomai are under GPL)?

Well, under the terms of the GPL, anyone you distribute your system to
should have a way to get the sources, yes.

--=20
                                                 Gilles.


