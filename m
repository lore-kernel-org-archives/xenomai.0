From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Fri, 20 Dec 2013 13:42:55 +0100
References: <52B231AD.2010604@alaxarxa.net> <52B4184A.2090900@xenomai.org>
In-Reply-To: <52B4184A.2090900@xenomai.org>
MIME-Version: 1.0
Message-Id: <201312201343.01875.leo@alaxarxa.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xddp protocol: question of one example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

A Divendres, 20 de desembre de 2013, Philippe Gerum va escriure:
> On 12/19/2013 12:37 AM, Leopold Palomo-Avellaneda wrote:
> > Hi,
> >
> > I'm developing an application that need (as always) interchange data =

between a realtime part and non-realtime.
> >
> > Looking on the documentation and surfing on the web I have found =

interesting for my app the examples of xddp protocol. Some time ago, there =
was =

an interesting mail about it [1].
> >
> > There, the original author ask one thing that I would like to be sure t=
hat =

I understood. On the examples, the realtime thread uses the function =

recvfrom() to receive data from the non-rt thread.
> >
> > In the mail, the original author asked about make recvfrom
> > call non-blocking in xddp context, and *Philippe Gerum* answered that
> > MSG_DONTWAIT should be set in flags.
> >
> > So, my question is that using that flag, some code like this:
> >
> >
> > /* Read back packets echoed by the regular thread */
> > ret =3D recvfrom(s, buf, sizeof(buf), 0, NULL, 0);
> > if(ret <=3D 0)
> >      fail("recvfrom");
> >
> > recvfrom will not be blocked, but it will return 0?
> >
> > May I understood that if there's data on the sockect recvfrom will
> > return something and if no, it would not be blocked and return somethin=
g?
> >
> =

> Standard behavior when no data present: immediate return with ret =3D -1, =

> errno =3D EWOULDBLOCK/EAGAIN.

Ok, =


if you are writing some data (some bytes) in the socket, can I trust that =

recvfrom will return -1 until ALL data is transferred?

Regards,

Leopold







-- =

--
Linux User 152692
Catalonia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131220/e776485=
8/attachment.sig>
