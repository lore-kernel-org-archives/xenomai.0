Date: Tue, 16 May 2006 16:33:48 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200605161633.15928@domain.hid>
References: 200605161221.11119@domain.hid> <200605161221.11119@domain.hid>
	<4469B31E.60506@domain.hid>
In-Reply-To: <4469B31E.60506@domain.hid>
Subject: Re: [Xenomai-help] rtdm_event_timedwait non-realtime alternative
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, grugh@domain.hid
Cc: xenomai@xenomai.org

I sense, that there could be a problem. the rtdm_nrtsig_handler_t handl=
er have only one argument (rtdm_nrtsig_t *). But I need to get a pointe=
r to the device and/or the event which has happended and needs to be fo=
rwarded to tha waiter.
I hope there is a possibility to search all my devices (usualy one :-))=
 if the argument belongs to it, and then clear all pending "events" and=
 call wake_up for appropriate wait queues.
But it's not as simple as I wanted :-(, I hoped that I can avoid the wa=
iting queues etc..
Anyway thanks for help. I didn't know, that I can't use wake_up from RT=
 interrupt handler.
Petr Cervenka
______________________________________________________________
> Od: jan.kiszka@domain.hid
> Komu:  Petr Cervenka <grugh@domain.hid>
> CC:  xenomai@xenomai.org
> Datum: 16.05.2006 13:15
> P=F8edm=ECt: Re: [Xenomai-help] rtdm_event_timedwait non-realtime alt=
ernative
>
>  Petr Cervenka wrote:
> > Hello,
> > I need to wait in my ioctl handler for an interrrupt. Is it possibl=
e to
> use some rtdm_event_timedwait alternative in non-realtime?
> > I'm thinking about using wait_event_interruptible_timeout. Is it a =
good
> idea or is there a better solution (e.g. rtdm_event compatible))?
>=20
> So your interrupt is RT while one of your waiters is non-RT? Then you
> have to forward the RT event (i.e. the IRQ occurrence) via an
> rtdm_nrtsig_t from the IRQ handler to an nrtsig-event handler in non-=
RT
> context. This handler can then wakeup non-RT waiters.
>=20
> This may sound a bit complicated, but you have to remind that there i=
s
> no safe way to schedule a non-RT (Linux) thread directly from the RT
> (Xenomai) domain, because all Linux scheduling services are fully
> preemptible by Xenomai at any time (including the RT IRQ handler).
>=20
> Hmm, as you were asking for a non-RT-safe rtdm_event now: the pattern=
 I
> described above might be generalisable to an extended rtdm_event
> supporting both RT and non-RT waiters (non-RT wakers already work). N=
eed
> to think about this...
>=20
> Jan
>=20
>=20
>=20


