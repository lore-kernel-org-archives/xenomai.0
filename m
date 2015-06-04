From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 04 Jun 2015 12:41:47 +0200
Message-ID: <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <30507154.J7D5WlzkQ8@eltrolinux48.eltroad.eltropuls>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150603130217.GQ27570@hermes.click-hack.org>
 <30507154.J7D5WlzkQ8@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rtnet locking/socket SKBs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am Mittwoch, 3. Juni 2015, 19:09:36 schrieb Marc Str=E4mke:
> How is the reference count maintained for the rtdm devices, is that the
> refcount in the rtdm_fd structure (fd->refs). There is also a driver
> refcount, I am actually somewhat confused how this is maintained...

So I got mostly down to the issue but I need some input from someone more =

knowledged in rtnets design: =

The reference count of an open AF_PACKET socket is not dropping to zero =

because there are still skb in the sockets skb pool and =

rtskb_socket_pool_trylock increments the fds reference =

count. rt_socket_cleanup would release the skb pool but never gets called.

What I do not really understand at this moment is why the fd reference coun=
t =

gets incremented at all when the socket gets a skb in its pool? =

Is there any reason to not close a socket while it still has associated skb=
s =

in the pool? They will never get cleared if the application crashes If I am =

not mistaken.

Best Regards,

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
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150604/9f03ea71/at=
tachment.sig>
