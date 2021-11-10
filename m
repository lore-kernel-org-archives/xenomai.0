From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Message-Id: <CD8ABA7C-A5F0-4D81-A31B-9B410793607A@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [EVL][dovetail] Minimum requirements for network communication
 for RPi 4B and amd64
Date: Wed, 10 Nov 2021 16:00:14 +0300
In-Reply-To: <87lf1wb7re.fsf@xenomai.org>
References: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
 <878rxzt578.fsf@xenomai.org> <1FAA0481-E7A9-4B32-B817-3B77D71D5323@gmail.com>
 <87lf1wb7re.fsf@xenomai.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> 200-300 microseconds latency worst case is demanding, this is in the
> same ballpark than the figures I obtained with RTnet/Xenomai3.1 =
between
> two mid-range SoCs (x86_64 and i.MX6Q) attached to a dedicated switch,
> over a 100Mbit link.

I assume this is only the communication latency and nothing else. As I =
have to=20
read SPI which takes 50-60 us, this measurements would be higher I =
guess.

> Going for a kernel bypass on the rpi4 by coupling DPDK and EVL would =
at
> the very least require a DPDK-enabled GENET driver, which does not =
seem
> to exist.

That would=E2=80=99ve been splendid to be honest. I didn=E2=80=99t knew =
DPDK till now but
the premise sounds quite good.

> Another option would be to check whether you could work directly at
> packet level for now on the rpi4, based on the EVL networking
> layer. This is experimental WIP, but this is readily capable of
> exchanging raw packets between peers. See [1].

If I understand correctly, EVL=E2=80=99s networking layer doesn=E2=80=99t =
support TCP/UDP
at the moment and I would have to implement the sliding window myself
with raw packets. Correct?

=E2=80=94

To sum up, we don=E2=80=99t have many options considering RPi 4 with =
kernel bypassing.

> I don't think the common linux stack is an option with such =
requirement
> under load, especially since you would have to channel the network
> traffic


Along with that, EVL=E2=80=99s net stack not creating any improvement =
for this kind of load.
Considering these, 200-300 us is demanding but it=E2=80=99s as high as =
it gets at the moment.

> On 10 Nov 2021, at 12:48, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
>=20
> Deniz U=C4=9Fur <deniz343@gmail.com <mailto:deniz343@gmail.com>> =
writes:
>=20
>>> Providing a basic sliding window mechanism between UDP/packet peers =
may
>>> be an option.
>>=20
>> How so? Wouldn=E2=80=99t that introduce out-of-order packets?
>>=20
>=20
> The recipient could stage the packets forming the current window,
> reordering them on the fly based on some sequence number in those
> datagrams (assuming you do trust the mac-level checksum), until that
> window is deemed complete, at which point the window could be
> acknowledged to the peer and released to the application in the same
> move. The main issue would be to decide about when a window =
transmission
> is complete, depending on whether the peer is supposed to send data
> continuously or not. If not, then this becomes a bit trickier.
>=20
>>> As Paul McKenney put it once, "(hard) real-time is the start of a
>>> conversation rather than a complete requirement.=E2=80=9D
>>=20
>> I agree, as with all things any improvement over mainline should be =
incremental.
>>=20
>>> What would be the
>>> requirements in terms of expected bandwidth, worst case latency, =
jitter,
>>> packet ordering guarantee ?
>>=20
>> Well, my application reads encoder data and transmits it to a host
>> computer for further calculations. Therefore, packet ordering must be
>> inline with how the data is read. Each packet consists of ~100 bytes
>> and I use 4 clients to send data. Worst case latency shouldn=E2=80=99t =
be
>> higher than 0.2-0.3 ms, because that is my sampling time for each
>> client. I have no constraints on jitter, as I=E2=80=99m happy with =
the jitter
>> I=E2=80=99m currently measuring (which is less than 5%).
>>=20
>> What can you recommend me with these in mind?
>>=20
>=20
> 200-300 microseconds latency worst case is demanding, this is in the
> same ballpark than the figures I obtained with RTnet/Xenomai3.1 =
between
> two mid-range SoCs (x86_64 and i.MX6Q) attached to a dedicated switch,
> over a 100Mbit link.
>=20
> I don't think the common linux stack is an option with such =
requirement
> under load, especially since you would have to channel the network
> traffic from your real-time task(s) to the regular stack via an EVL
> proxy element (or anything more complex that would fit) before it can
> reach the wire.
>=20
> Going for a kernel bypass on the rpi4 by coupling DPDK and EVL would =
at
> the very least require a DPDK-enabled GENET driver, which does not =
seem
> to exist.
>=20
> Another option would be to check whether you could work directly at
> packet level for now on the rpi4, based on the EVL networking
> layer. This is experimental WIP, but this is readily capable of
> exchanging raw packets between peers. See [1].
>=20
> [1]
> =
https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tidbits/oob-n=
et-icmp.c =
<https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tidbits/oob-=
net-icmp.c>
>=20
> --=20
> Philippe.

