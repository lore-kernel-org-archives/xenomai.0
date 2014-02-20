From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Thu, 20 Feb 2014 23:48:30 +0100
Message-ID: <2067214.aYyCtNd8b5@indiana>
In-Reply-To: <53068030.9030601@xenomai.org>
References: <CAPydA0FQ+0AEeUQ2tXvcP1FZ0S21vVryBMqya0mcdg5vr8xmbw@mail.gmail.com>
 <53068030.9030601@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Xenomai] Realtime tasks concepts (II)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

El Dijous, 20 de febrer de 2014, a les 23:22:40, Gilles Chanteperdrix v=
a=20
escriure:
> On 02/20/2014 08:57 PM, Orestes Mas wrote:
> >> A 2014-02-20 11:41, Gilles Chanteperdrix escrigu=E9:
> >>=20
> >> On 02/20/2014 11:27 AM, Gilles Chanteperdrix wrote:
> >>=20
> >> Our aim is to design NRT master and slaves (c++ objects) that
> >> communicates
> >>=20
> >>>> with a RT task. The RT task is in charge of establish a continuo=
us
> >>>> communication with EtherCAT devices. This task communicates with=
 NRT
> >>>> master
> >>>> by the xddp sockects. The problem appears when the master call t=
he RT
> >>>> SOEM
> >>>> functions for the configuration, because it is necessary that th=
e
> >>>> master
> >>>> becomes a RT task, if not it doesn't work. And it has no sense.
> >>>=20
> >>> Only a task with a shadow can call RT services, because it needs =
to be
> >>> able to switch to primary mode, and only a task with a shadow can=
 switch
> >>> to
> >>> primary mode.
> >>=20
> >> By RT services, I mean rt_mutex services and RTDM callbacks for wh=
ich
> >> you implemented the _rt version. If you mean anything else (like X=
enomai
> >> services), then you are to imprecise again, and the answer to your=

> >> question is "it depends", because on a service by service basis, s=
ome
> >> need a task with a shadow, some do not. But usually, if a service =
needs
> >> a task with a shadow, that is because its implementation requires =
it
> >> (for instance because the task needs to be suspended in Xenomai
> >> scheduler, which can not happen if the task does not have a shadow=
).
> >=20
> > Sorry if I start a new thread with the same subject: I've just join=
ed the
> > mailing list and I don't have the past messages in my e-mail client=
.
> >=20
> > Thanks for your explanations, Gilles. So, let's try to re-state the=

> > problem
> > in "shadow" terms, to see if we finally understand it.
> >=20
> > 1) We've a linux installation with xenomai patches and rt_net drive=
r
> > (RTDM)
> > that manage rteth0 interface. From our experience and your explanat=
ions we
> > assume that rt_net services, being RTDM, must be called _always_ fr=
om a
> > task with a shadow. Is this correct?
>=20
> In an RTDM driver, every file operation (read, write, ioctl) has an _=
rt
> and an _nrt version. The _rt version requires a thread with a shadow,=

> the _nrt version does not.
>=20
> > The problem that started this list thread was that the SOEM library=
 we use
> > to communicate with some devices through the rteth0 interface has s=
ome
> > initialization functions (init, config, and so on) and then a funct=
ion to
> > be executed periodically to maintain a data flow between the host P=
C and
> > the devices. Initially we put _only_ this periodic part into a task=
 with a
> > shadow, but tried to call init and config functions from the main p=
rogram
> > --without a shadow--, and that didn't work. For it to work we had t=
o
> > shadow
> > also the main task, a thing that becomes obvious after your explana=
tions.
> >=20
> > 2) We didn't like to have the main task shadowed because we assumed=

> > (perhaps erroneously) that it's better to keep the number of shadow=
ed
> > tasks
> > to a minimum. If it's not possible, from your explanations I think =
that
> > perhaps the best compromise is to have tha main task shadowed, but =
with
> > priority 0 and scheduled by SCHED_OTHER. If I do that, will my shad=
owed
> > task running in primary mode commute to secondary mode when called =
by the
> > main task?
> >=20
> > Probably I'll have more questions, but let's go step by step and cl=
arify
> > these before asking more.
>=20
> Why not using the same task to do the initializations, and later on
> become periodic and "maintain the data flow" ?

Because at least, I don't know how to do that. Maybe Orestes. This is w=
hat I=20
asked yesterday, I can imagine an "object", that has several functions =
and I=20
can call to do some action. Bit i cannot image the same in terms of tas=
ks.

With a task, we create some kind of protocol via xddp to send commands =
and the=20
the task do some function, but if not, the communication between the pr=
imary=20
mode and the secondary it's not obvious if you don't want to have conte=
xts=20
change.

Leopold


--=20
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?


