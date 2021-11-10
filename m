References: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
 <878rxzt578.fsf@xenomai.org>
 <1FAA0481-E7A9-4B32-B817-3B77D71D5323@gmail.com>
 <87lf1wb7re.fsf@xenomai.org>
 <CD8ABA7C-A5F0-4D81-A31B-9B410793607A@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [EVL][dovetail] Minimum requirements for network communication
 for RPi 4B and amd64
Date: Wed, 10 Nov 2021 14:57:14 +0100
In-reply-to: <CD8ABA7C-A5F0-4D81-A31B-9B410793607A@gmail.com>
Message-ID: <878rxw853j.fsf@xenomai.org>
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

>  200-300 microseconds latency worst case is demanding, this is in the
>  same ballpark than the figures I obtained with RTnet/Xenomai3.1 between
>  two mid-range SoCs (x86_64 and i.MX6Q) attached to a dedicated switch,
>  over a 100Mbit link.
>
> I assume this is only the communication latency and nothing else. As I ha=
ve to=20
> read SPI which takes 50-60 us, this measurements would be higher I
> guess.

Correct.

>
>  Going for a kernel bypass on the rpi4 by coupling DPDK and EVL would at
>  the very least require a DPDK-enabled GENET driver, which does not seem
>  to exist.
>
> That would=E2=80=99ve been splendid to be honest. I didn=E2=80=99t knew D=
PDK till now but
> the premise sounds quite good.
>

I'm not a DPDK expert, but there are folks on this list with significant
knowledge about DPDK who might want to discuss this.

>  Another option would be to check whether you could work directly at
>  packet level for now on the rpi4, based on the EVL networking
>  layer. This is experimental WIP, but this is readily capable of
>  exchanging raw packets between peers. See [1].
>
> If I understand correctly, EVL=E2=80=99s networking layer doesn=E2=80=99t=
 support TCP/UDP
> at the moment and I would have to implement the sliding window myself
> with raw packets. Correct?
>

Correct. In userland, which would make things easier.

> =E2=80=94
>
> To sum up, we don=E2=80=99t have many options considering RPi 4 with kern=
el bypassing.
>
>  I don't think the common linux stack is an option with such requirement
>  under load, especially since you would have to channel the network
>  traffic
>
> Along with that, EVL=E2=80=99s net stack not creating any improvement for=
 this
> kind of load.

Mm, not sure. Even in the case EVL reuses the regular NIC drivers, I can
already see latency improvements here (pi2 and bbb -> x86 Soc), because
the traffic is directly injected to the driver from the TX softirq
context, bypassing the delays induced by the regular net stack. Once the
full, end-to-end oob chain between the app and the wire including the
driver is enabled, we should get interesting figures (bypassing the
softirq context entirely). Forward looking statement, I agree. Working
on it.

> Considering these, 200-300 us is demanding but it=E2=80=99s as high as it=
 gets at the moment.
>

--=20
Philippe.

