From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Wed, 20 Nov 2013 16:54:32 +0100
References: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
 <528CCE14.2040505@xenomai.org>
In-Reply-To: <528CCE14.2040505@xenomai.org>
MIME-Version: 1.0
Message-Id: <201311201654.38118.leo@alaxarxa.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] integrate event signaled by RT thread into non-RT
	event loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

A Dimecres, 20 de novembre de 2013, Gilles Chanteperdrix va escriure:
> On 11/20/2013 03:33 PM, Michael Haberler wrote:
> > I'm looking for a simple method to post an event from an RT thread so
> > a userland non-RT thread can wait for, and pick it up via a file
> > descriptor (without switching the originating thread to primary
> > domain, of course)
> > =

> > event context can be minimal since the userland handler can figure;
> > actual data transfer not required - event number or mask a plus
> > =

> > purpose would be integration into existing event loops; only
> > RT->userland signalling needed
> > =

> > if it's possible from a kernel RT context, it's a plus
> > =

> > ---
> > =

> > one scheme I thought of was: using rt_event services, monitor the
> > event flag in a userland shadow thread and post to an eventfd whose
> > other side could be integrated into an event loop. Making sense?
> > =


adding more noise to the question, can I integrate some kind of signal (p. =
ex. =

boost:signal2? or can I emit this signal from a RT thread and connect it to=
 a =

non-RT thread?

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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131120/25c5ed2=
0/attachment.sig>
