Date: Fri, 1 Apr 2016 12:40:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160401104049.GE4744@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160331104409.GC4744@hermes.click-hack.org>
 <20160331162235.GD4744@hermes.click-hack.org>
 <b4574450a1cb4481a78b097febc538c2@EDB3.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b4574450a1cb4481a78b097febc538c2@EDB3.wapice.localdomain>
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 01, 2016 at 09:36:26AM +0000, Matti Suominen wrote:
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
> Sent: 31. maaliskuuta 2016 19:23
> To: Matti Suominen <matti.suominen@wapice.com>
> Cc: Lassi Niemist=F6 <lassi.niemisto@wapice.com>; xenomai@xenomai.org
> >> TCP is disabled in Xenomai 3 rtnet. The main problem is that creating =

> >> a socket in Xenomai 3 requires switching to secondary mode, so the=20
> >> "accept" service seems hard to implement without leaving primary mode.=
=20
> >> Given the fact that TCP can not be a deterministic protocol, I planned=
=20
> >> to drop TCP support in the next RTnet iteration.
> >> If you require to send messages over TCP from a thread running in=20
> >> primary mode, you should rather pass the message using an XDDP socket =

> >> to a thread running in secondary mode and using plain linux TCP=20
> >> sockets. You will not get more determinism with TCP in RTnet.
> >
> >The question I guess, is, why do you need rttcp ? If you really need it,=
=20
> >then we will have to find a solution for the "accept" problem.
> >Keeping a pool of sockets ready for instance.
> >
>=20
> Sorry to hear that you are planning to drop support for rttcp. It's a=20
> useful feature. TCP can be used by deterministic way if your connection i=
s=20
> point to point and thus retransmission is clearly a sign for error in =20
> connection. Rttcp is also significantly faster than regular tcp.
>=20
> For demonstration, I ran some test in a setup with rttcp client and two=20
> server implementations; one rttcp and one with regular sockets. Our tests=
=20
> are showing that average round-trip-time for same server application is=20
> half when using rttcp instead of normal Linux sockets (470 =B5s vs. 960 =
=B5s).=20
> Maximum rtt in our case is 4 ms for rt and easily over 10 ms for normal=20
> Linux sockets. Each send/recv call with regular sockets drops to secondar=
y=20
> mode so there is no way the rtt maximum could be deterministic. Dropping =

> does not happen in rttcp.

Ok, I understand your point of view. I would say in that case you
could use UDP instead of TCP, but I guess you do not get to choose
the underlying IP protocol of application level protocols.

>=20
> In many applications it isn't a problem when accept drops to secondary=20
> mode, because creating a connection surely doesn't need to be a real time=
=20
> operation when connection serving is still real time. Of course accept=20
> which drops to secondary mode is kind a blemish when you think a big=20
> picture of real time kernel, but definitely isn't a reason to drop rttcp =

> away.

>From what I understood looking at TCP servers it is very common for
a server to be implemented with one big select loop which both
accepts new connections and sends/receives to existing ones. If
accept drops to secondary mode and you want to keep communication
with existing connections in primary mode, you will have to split
the loop in two threads and have a means of communication (message
queueus for instance, or XDDP sockets) between the two threads. This
makes the job of porting a TCP server to RTnet harder than it should
be. I wonder if we can not hide that second thread in Xenomai
libraries (like is done for printf) and have listen and accept
handle the synchronization with it.

>=20
> From my point of view it is clearly useful feature if same application=20
> (for example Modbus/TCP) can be used from rt and pc clients, and I thus d=
o=20
> not need to maintain two protocols.

Ok, I will try to think of something.

--=20
					    Gilles.
https://click-hack.org

