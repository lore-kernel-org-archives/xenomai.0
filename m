Message-ID: <49F73604.8070706@domain.hid>
Date: Tue, 28 Apr 2009 18:59:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DF9F3A3C150B0646A17FF1487C1B6D5E019F64AA@rennsmail06.eu.thmulti.com>
In-Reply-To: <DF9F3A3C150B0646A17FF1487C1B6D5E019F64AA@rennsmail06.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Cc: xenomai@xenomai.org

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
> If I supposed inherent interrupt latency on ARM is around 30=B5s, I can=

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


