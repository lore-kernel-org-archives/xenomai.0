From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 04 Jun 2015 14:35:18 +0200
Message-ID: <2202092.SxJm6YhEYp@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150604113100.GU27570@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <2172332.WGhck7t4nv@eltrolinux48.eltroad.eltropuls>
 <20150604113100.GU27570@hermes.click-hack.org>
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

Am Donnerstag, 4. Juni 2015, 13:31:00 schrieb Gilles Chanteperdrix:
> On Thu, Jun 04, 2015 at 01:09:08PM +0200, Marc Str=E4mke wrote:
> > =

> > Yes I do understand this. I am just trying to figure out what the right
> > fix is. If I just disable incrementing the fd reference count (see
> > attached patch) AF_PACKET works as it should.  From my current
> > understanding of the code the reference counting for the SKB Pools
> > attached to a socket is redundant, but I've only closely inspected
> > AF_PACKET not the other sockets in the IP stack.
> The locking of the pools is not redundant. The reason for this lock
> is that when an skb is in between two pools, we do not want the pool
> it comes from to be destroyed, as the skb would end-up leaking. So,
Yes, that is obvious. But what these lock ops do is not locking for the =

transient moment when the packet is moving between pools but for the time t=
he =

packet is in a pool. This locking ops insure that no whole skb pool is leak=
ed.

If I look at rtskb_module_lock_ops this makes sense to me, one cannot unloa=
d =

the module till all pools are empty. It left me wondering though if =

try_module_get is safe to be called from a realtime context..


> since skbs move from pool to pool, when the skb comes to a new pool,
> the old pool should be unlocked. This should work as rtnet spends
> its time exchanging skbs from pool to pool and does not allocate or
> free them. I tried and implement something along these lines.
> Apparently, I messed up, but the fix is not to disable the locking.
> Disabling locking will lead to leaking skbs.
I do understand this also. It is redundant in the case of AF_PACKET, not in =

the general case. In the case of rtskb_socket_pool_ops the above mentioned =

mechanism does not work out. The pool is emptied on close if there are stil=
l =

unread packets in the pool. So the reference counting on rtdm_fd already ma=
kes =

sure that the socket close operation is called. Both mechanisms together le=
ad =

to a deadlock. =

If every socket type implements a correct close operation which frees the =

skbpool used by the socket on close, there is no risk of leaking skbs. I di=
d =

also test that I am not leaking skbs when stressing the AF_PACKET socket.

But you are certainly right, the patch I submitted is kinda stupid. It was =

just what I tested for AF_PACKET. If my assumptions are correct the lock op=
s =

for all sockets should be disabled because the reference counting of the fd =

takes care of freeing the pool. This would then be done at creation time in =

rt_bare_socket_init not later on.


Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150604/7a583333/at=
tachment.sig>
