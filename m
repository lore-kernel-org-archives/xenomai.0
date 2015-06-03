From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Wed, 03 Jun 2015 14:56:07 +0200
Message-ID: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem with RTNET Packet Socket (or RTDM in general) in
	Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I am experiencing an issue with using packet sockets in Xenomai 3. I am at =
the =

moment trying to replicate it on a minimal testcase but struggling.
What I've found so far is that when a packet socket is read non-blocking wi=
th =

MSG_DONTWAIT the socket sometimes cannot be closed afterwards. =

I inserted a rt_printk into rt_packet_socket(fd,proto) and rt_packet_close(=
fd) =

in af_packet.c, sometimes rt_packet_close never gets called and so any furt=
her =

communication on this interface is effectively impossible.

Any hints on where I should start looking? =

I assume the socket should be closed by Xenomai in any case, even if the =

application abnormally terminates without calling close? If that is not the =

case how do I make sure to clean up after the application in case the =

application terminates abnormally?

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
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150603/bc364372/at=
tachment.sig>
