Message-ID: <1542979287.2348.7.camel@smigroup.net>
Subject: Re: rtping differences between master and slaves
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Fri, 23 Nov 2018 14:21:27 +0100
In-Reply-To: <f4af8e4f-25fa-1845-1525-f5a0c76e00d9@siemens.com>
References: <1542970266.2348.3.camel@smigroup.net>
 <043f0216-fb11-e022-66b8-738f5cd93aee@siemens.com>
 <1542977379.2348.5.camel@smigroup.net>
 <f4af8e4f-25fa-1845-1525-f5a0c76e00d9@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

On Fri, 2018-11-23 at 13:55 +0100, Jan Kiszka wrote:
> On 23.11.18 13:49, Mauro Salvini wrote:
> > On Fri, 2018-11-23 at 12:49 +0100, Jan Kiszka wrote:
> > > On 23.11.18 11:51, Mauro Salvini via Xenomai wrote:
> > > > Hi all,
> > > >=20
> > > > I'm trying RTNet (an old version: 0.9.13) on Xenomai (yet
> > > > another
> > > > old
> > > > version, 2.5.6: unluckily I cannot move to newer versions).
> > > >=20
> > > > My setup has 3 identical nodes on isolated RT network: cycle
> > > > time
> > > > of
> > > > 5000us, master with slot offset 0, slave A with slot offset
> > > > 200us
> > > > and
> > > > slave B with slot offset 400us; network is configured using
> > > > rtnet
> > > > utility script.
> > > >=20
> > > > Using rtping I observe two different behaviors on slaves and
> > > > master.
> > > >=20
> > > > For example, pinging slave A from B:
> > > >=20
> > > > ...
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D1 time=3D7777.7 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D2 time=3D7846.3 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D3 time=3D7966.6 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D4 time=3D8096.6 us
> > > > ...
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D15 time=3D9461.7 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D16 time=3D9604.2 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D17 time=3D4719.5 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D18 time=3D4844.7 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D19 time=3D4968.3 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D20 time=3D5124.4 us
> > > > ...
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D53 time=3D9215.4 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D54 time=3D9331.5 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D55 time=3D9461.0 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D56 time=3D9585.3 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D57 time=3D4712.5 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D58 time=3D4847.0 us
> > > > 64 bytes from 10.0.43.91: icmp_seq=3D59 time=3D4967.2 us
> > > > ...
> > > >=20
> > > > so time varies between a minimum equal to time distance between
> > > > two
> > > > slots and a maximum equal to this time plus cycle duration.
> > > > This
> > > > can
> > > > makes sense supposing that Linux timer used to generate ping
> > > > request in
> > > > rtping.c slowly drifts from real-time timer that governs tx
> > > > slot,
> > > > so
> > > > the duration changes between requests depending on when request
> > > > happens
> > > > into the TDMA cycle. Same behavior if I ping A from B or if I
> > > > ping
> > > > master from A or B.
> > > >=20
> > > > On master I instead observe this (pinging slave A or B
> > > > equally):
> > > >=20
> > > > ...
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D1 time=3D2434.1 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D2 time=3D2443.1 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D3 time=3D2438.7 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D4 time=3D2450.0 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D5 time=3D2447.9 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D6 time=3D2450.6 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D7 time=3D2428.5 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D8 time=3D2442.8 us
> > > > 64 bytes from 10.0.43.89: icmp_seq=3D9 time=3D2442.3 us
> > > > ...
> > > >=20
> > > > ping duration is constant into a rtping execution (changes
> > > > between
> > > > different executions).
> > > >=20
> > > > So I'm puzzling about this difference and I wonder if this is
> > > > normal or
> > > > if there could be problems.
> > > >=20
> > >=20
> > > As you are running RTmac/TDMA: The latency is affected by when
> > > during
> > > some cycle
> > > you issue the ICMP request. This is not synchronized with the
> > > cycle,
> > > so you will
> > > see random shifts there already. Furthermore, if station A has a
> > > time
> > > slot
> > > before station B and A issues the ping, B may have a change to
> > > reply
> > > in the same
> > > cycle. If you change roles, this is surely not possible, thus you
> > > get
> > > different
> > > round trip times.
> >=20
> > Thank Jan for quick answer.
> >=20
> > Yes, I understood your explanation, that perfectly clarify rtping
> > between A and B.
> >=20
> > Instead, about the constant ping duration when master pings a
> > slave: is
> > due to the fact that on master ICMP requests are synchronized with
> > the
> > cycle?
>=20
> I don't recall the details, but chances are high that, because the
> master drives=C2=A0
> the TDMA cycle, its rtping loop happens to remain in sync with that
> cycle.

Ok, thank you very much Jan.

Regards.

Mauro


