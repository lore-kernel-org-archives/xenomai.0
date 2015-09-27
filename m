Date: Sun, 27 Sep 2015 23:32:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150927213236.GA23716@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150603130217.GQ27570@hermes.click-hack.org>
 <30507154.J7D5WlzkQ8@eltrolinux48.eltroad.eltropuls>
 <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] rtnet locking/socket SKBs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?iso-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Cc: xenomai@xenomai.org

On Thu, Jun 04, 2015 at 12:41:47PM +0200, Marc Str=E4mke wrote:
> Am Mittwoch, 3. Juni 2015, 19:09:36 schrieb Marc Str=E4mke:
> > How is the reference count maintained for the rtdm devices, is that the
> > refcount in the rtdm_fd structure (fd->refs). There is also a driver
> > refcount, I am actually somewhat confused how this is maintained...
>=20
> So I got mostly down to the issue but I need some input from someone more=
=20
> knowledged in rtnets design:=20
> The reference count of an open AF_PACKET socket is not dropping to zero=20
> because there are still skb in the sockets skb pool and=20
> rtskb_socket_pool_trylock increments the fds reference=20
> count. rt_socket_cleanup would release the skb pool but never gets called.
>=20
> What I do not really understand at this moment is why the fd reference co=
unt=20
> gets incremented at all when the socket gets a skb in its pool?=20
> Is there any reason to not close a socket while it still has associated s=
kbs=20
> in the pool? They will never get cleared if the application crashes If I =
am=20
> not mistaken.

Ok, so now I had a look at the issue. The counter is not dropping to
zero probably because you have unqueued messages in the socket
"incoming" queue, the pool is locked when a packet is out of the
pool, not when a packet is in the pool.

Anyway, you are right, this is redundant, but not only for
af_packet, also for udp and tcp: when the packet is outside any pool
or queue, the file descriptor is locked, so, the module can not be
removed and leak can not occur, so there is no reason to keep track
of the fact that it is outside any queue, and we can probably remove
the locking in the socket pools.

What may be missing is that creating sockets should lock the
corresponding kernel module.

--=20
					    Gilles.
https://click-hack.org

