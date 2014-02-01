From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E05996E-AC72-4B77-88D1-A4BBC57C9827@mah.priv.at>
Date: Sat, 1 Feb 2014 18:58:24 +0100
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: [Xenomai] packet_mmap raw socket usable from Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am looking into ethernet I/O from a RT thread, but am willing to =
tradeoff some latency against using stock linux drivers

also I'd like to use a common method across RT-PREEMPT and Xenomai =
thread styles to keep the number of moving parts low

One method which looks promising is the PACKET_TX_RING/PACKET_RX_RING =
methods of the packet_mmap raw sockets; it seems packet read is possible =
with only shared memory r/w and a transmit entails a sendto() socket =
call passing a reference to the packet in the transmit ring (so skbufs =
arent used except in the driver per se) - I do assume though that =
sendto() will cause a domain switch even if it is just a notification to =
the driver

am I blundering down a dead end? Is RTnet my only option even if I dont =
need the IP and above stack, and the low latency RTnet provides?

if not - is it conceivable to handle this sendto() driver notification =
via an RTDM driver? I dont need RX notification because the shm test is =
cheap and threads are cyclic anyway

thanks in advance,

Michael

--

packet_mmap: =
https://www.kernel.org/doc/Documentation/networking/packet_mmap.txt

example code:
=
https://github.com/vieites4/rawsockets/blob/master/docs/snippets/packet-tx=
-ring.c
=
https://github.com/vieites4/rawsockets/blob/master/docs/snippets/packet-rx=
-ring.c=

