From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Wed, 03 Jun 2015 19:09:36 +0200
Message-ID: <30507154.J7D5WlzkQ8@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150603130217.GQ27570@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150603130217.GQ27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problem with RTNET Packet Socket (or RTDM in general)
	in Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Thank you for your swift response Gilles,

Am Mittwoch, 3. Juni 2015, 15:02:17 schrieb Gilles Chanteperdrix:
> On Wed, Jun 03, 2015 at 02:56:07PM +0200, Marc Str=E4mke wrote:
> > Hello everyone,
> > =

> > I am experiencing an issue with using packet sockets in Xenomai 3. I =

am at
> > the moment trying to replicate it on a minimal testcase but struggling.
> > What I've found so far is that when a packet socket is read non-
blocking
> > with MSG_DONTWAIT the socket sometimes cannot be closed =

afterwards.
> > I inserted a rt_printk into rt_packet_socket(fd,proto) and
> > rt_packet_close(fd) in af_packet.c, sometimes rt_packet_close never =

gets
> > called and so any further communication on this interface is effectively
> > impossible.
> > =

> > Any hints on where I should start looking?
> =

> Look at the reference counts.
> =

Thats what I was assuming also... it is indeed the reference count that =

stays at 1 after closing the socket . /sys/class/rtdm/raw_packet/refcount -=
> =

1

But I am at a total loss where this reference count is actually =

incremented/decremented? One thing I now noticed is that I can trigger =

the problem by accessing the sysfs refcount entry of the raw_packet rtdm =

driver while I have a raw_packet socket open. So the same test program =

(open socket, send a packet, wait 2 seconds, receive a packet) works fine =

without the sysfs access, and triggers the dangling reference problem if =

the sysfs entry is accesed during the 2 seconds sleep.

How is the reference count maintained for the rtdm devices, is that the =

refcount in the rtdm_fd structure (fd->refs). There is also a driver refcou=
nt, =

I am actually somewhat confused how this is maintained...  =


Regards,
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
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150603/aa9e6c40/at=
tachment.sig>
