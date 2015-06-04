From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 04 Jun 2015 13:09:08 +0200
Message-ID: <2172332.WGhck7t4nv@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150604105616.GS27570@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
 <20150604105616.GS27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet locking/socket SKBs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles,

Am Donnerstag, 4. Juni 2015, 12:56:16 schrieb Gilles Chanteperdrix:
> The previous rtnet design was converted to reference counts globally
> when integrating into xenomai 3, some details may still need fixing.
> The old design was different but lead to the close syscall looping
> for ever and blocking your application if anything went wrong, so,
> this is an attempt to avoid this issue.
Yes I do understand this. I am just trying to figure out what the right fix=
 is. =

If I just disable incrementing the fd reference count (see attached patch) =

AF_PACKET works as it should.  From my current understanding of the code th=
e =

reference counting for the SKB Pools attached to a socket is redundant, but =

I've only closely inspected AF_PACKET not the other sockets in the IP stack.

> =

> > They will never get cleared if the application crashes If I am
> > not mistaken.
> =

> Once again: when an application crashes, the file descriptors are
> automatically closed by Xenomai, you do not need to care about this
> case.
What I am seeing is that when the reference count is above 1 when the =

application closes/crashes, the close operation of the rtdm socket never ge=
t's =

called, neither when doing an explicit close system call on the socket whic=
h =

still had a reference count above 1.

When I disable the skb pool reference counting for AF_PACKET it basically =

works as it should. When the application closes the socket or crashes the =

close op get's called and the skb's release. =


Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Proof-of-concept-disable-locking-in-af_packet-skb-po.patch
Type: text/x-patch
Size: 1318 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150604/b098fe8a/at=
tachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150604/b098fe8a/at=
tachment.sig>
