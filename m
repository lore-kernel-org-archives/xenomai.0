References: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
 <878rxzt578.fsf@xenomai.org>
 <1FAA0481-E7A9-4B32-B817-3B77D71D5323@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [EVL][dovetail] Minimum requirements for network communication
 for RPi 4B and amd64
Date: Wed, 10 Nov 2021 10:48:33 +0100
In-reply-to: <1FAA0481-E7A9-4B32-B817-3B77D71D5323@gmail.com>
Message-ID: <87lf1wb7re.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Deniz =?utf-8?Q?U=C4=9Fur?= <deniz343@gmail.com>
Cc: xenomai@xenomai.org


Deniz U=C4=9Fur <deniz343@gmail.com> writes:

>> Providing a basic sliding window mechanism between UDP/packet peers may
>> be an option.
>
> How so? Wouldn=E2=80=99t that introduce out-of-order packets?
>

The recipient could stage the packets forming the current window,
reordering them on the fly based on some sequence number in those
datagrams (assuming you do trust the mac-level checksum), until that
window is deemed complete, at which point the window could be
acknowledged to the peer and released to the application in the same
move. The main issue would be to decide about when a window transmission
is complete, depending on whether the peer is supposed to send data
continuously or not. If not, then this becomes a bit trickier.

>> As Paul McKenney put it once, "(hard) real-time is the start of a
>> conversation rather than a complete requirement.=E2=80=9D
>
> I agree, as with all things any improvement over mainline should be incre=
mental.
>
>> What would be the
>> requirements in terms of expected bandwidth, worst case latency, jitter,
>> packet ordering guarantee ?
>
> Well, my application reads encoder data and transmits it to a host
> computer for further calculations. Therefore, packet ordering must be
> inline with how the data is read. Each packet consists of ~100 bytes
> and I use 4 clients to send data. Worst case latency shouldn=E2=80=99t be
> higher than 0.2-0.3 ms, because that is my sampling time for each
> client. I have no constraints on jitter, as I=E2=80=99m happy with the ji=
tter
> I=E2=80=99m currently measuring (which is less than 5%).
>
> What can you recommend me with these in mind?
>

200-300 microseconds latency worst case is demanding, this is in the
same ballpark than the figures I obtained with RTnet/Xenomai3.1 between
two mid-range SoCs (x86_64 and i.MX6Q) attached to a dedicated switch,
over a 100Mbit link.

I don't think the common linux stack is an option with such requirement
under load, especially since you would have to channel the network
traffic from your real-time task(s) to the regular stack via an EVL
proxy element (or anything more complex that would fit) before it can
reach the wire.

Going for a kernel bypass on the rpi4 by coupling DPDK and EVL would at
the very least require a DPDK-enabled GENET driver, which does not seem
to exist.

Another option would be to check whether you could work directly at
packet level for now on the rpi4, based on the EVL networking
layer. This is experimental WIP, but this is readily capable of
exchanging raw packets between peers. See [1].

[1]
https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tidbits/oob-ne=
t-icmp.c

--=20
Philippe.

