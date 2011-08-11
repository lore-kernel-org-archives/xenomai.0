From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20110811103352.902F5E9E@centrum.cz>
References: <20110809174031.7B1346B2@domain.hid>
	<1312905835.2112.106.camel@domain.hid> <20110811103352.902F5E9E@centrum.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Aug 2011 11:10:17 +0200
Message-ID: <1313053817.2133.71.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2011-08-11 at 10:33 +0200, Petr Cervenka wrote:
> Hello.
>=20
> I created a simple examples which describe my problem.
> It is some kind of server and client.
> At first run a qserver and then qclient.
> After that close the qserver and try to run it again.
> It disallows (in my configuratio) to create the queue because it already =
exists and also the binding to it fails with error -EACCES.
> This behavior continues till the qclient is closed. It's perhaps caused b=
y the rt_queue_delete() at the end of qserver.

That is the intended behavior. When deleted, the queue is maintained
internally until the last client bound to it exits, which also disallows
creating another queue with the same name until the latter event
happens.

However, deleting the queue also makes it unreachable for further
bindings, until it is completely dismantled after the last client exits.
At which point you may re-create a queue with the same name and bind to
it. Logically speaking, that deleted queue does not exist anymore,
except for the currently bound client(s), for consistency reasons.

>=20
> Also I have one question: How to break the rt_queue_bind call with TM_INF=
INITE parameter, because rt_task_unblock() doesn't work in this case?
>=20

If the caller is a Xenomai thread, then it should be unblocked with
rt_task_unblock(), otherwise this would be a bug. If this is a plain
linux task, then it would not be allowed to block and immediately return
with -EWOULDBLOCK if the object does not exist.

> ______________________________________________________________
> > Od: "Philippe Gerum" <rpm@xenomai.org>
> > Komu: Petr Cervenka <grugh@domain.hid>
> > Datum: 09.08.2011 18:04
> > P=C5=99edm=C4=9Bt: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
> >
> > CC: "xenomai-help" <xenomai@xenomai.org>
> >On Tue, 2011-08-09 at 17:40 +0200, Petr Cervenka wrote:
> >> Hello everyone.
> >>=20
> >> I'm trying linux kernel 2.6.38.8 together with xenomai 2.5.6.
> >> My application tries to reuse already created rt_queue shared between =
couple of similiar applications.
> >> When I try to recreate already existing rt_queue by rt_queue_create i =
get -EEXIST error (as I expected).
> >> But if I try to bind it immediately with rt_queue_bind(&queue, QUEUE_N=
AME, TM_NONBLOCK) I get -EACCES error.
> >> This error code is not in documentation and with the previously used v=
ersion (kernel 2.6.32.6, xenomai 2.4.10) it was working fine.
> >> Do you have any advice or suggestion?
> >
> >-EACCESS is returned in case an attempt is made to use a binding service
> >which does not match the target object. E.g. using rt_queue_bind() for
> >binding an existing task.
> >
> >> Thanks in advance.
> >>=20
> >> Petr Cervenka
> >>=20
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >
> >--=20
> >Philippe.
> >
> >
> >

--=20
Philippe.



