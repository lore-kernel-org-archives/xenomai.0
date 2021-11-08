Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [EVL][dovetail] Minimum requirements for network communication
 for RPi 4B and amd64
From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
In-Reply-To: <878rxzt578.fsf@xenomai.org>
Date: Mon, 8 Nov 2021 12:21:27 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FAA0481-E7A9-4B32-B817-3B77D71D5323@gmail.com>
References: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
 <878rxzt578.fsf@xenomai.org>
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

> Providing a basic sliding window mechanism between UDP/packet peers =
may
> be an option.

How so? Wouldn=E2=80=99t that introduce out-of-order packets?

> As Paul McKenney put it once, "(hard) real-time is the start of a
> conversation rather than a complete requirement.=E2=80=9D

I agree, as with all things any improvement over mainline should be =
incremental.

> What would be the
> requirements in terms of expected bandwidth, worst case latency, =
jitter,
> packet ordering guarantee ?

Well, my application reads encoder data and transmits it to a host =
computer for further calculations. Therefore, packet ordering must be =
inline with how the data is read. Each packet consists of ~100 bytes and =
I use 4 clients to send data. Worst case latency shouldn=E2=80=99t be =
higher than 0.2-0.3 ms, because that is my sampling time for each =
client. I have no constraints on jitter, as I=E2=80=99m happy with the =
jitter I=E2=80=99m currently measuring (which is less than 5%).

What can you recommend me with these in mind?

Thanks,
Deniz.

> On 8 Nov 2021, at 10:59, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
>=20
> Deniz U=C4=9Fur via Xenomai <xenomai@xenomai.org> writes:
>=20
>> Greetings Xenomai community,
>>=20
>> For the past year I have been using EVL to develop some real-time =
apps
>> utilizing fast data acquisition through SPI interfaces on RPi 4B. I
>> then send the collected data through mainline network stack to a =
amd64
>> machine running Xenomai 3.1. The data I=E2=80=99m sending is =
sensitive and
>> cannot afford packet drops. By that I mean even if I use UDP I would
>> have to wait for next successful packet to continue.
>=20
> Providing a basic sliding window mechanism between UDP/packet peers =
may
> be an option.
>=20
>> So in that case,
>> I guess, TCP without Nagle=E2=80=99s algorithm should be enough.
>>=20
>=20
> TCP with real-time capabilities would require to set limits on the =
time
> spent in recovery and retransmissions by construction, turning off
> packet coalescence may not be enough. With the current networking =
stack,
> this is more of a design issue than an implementation problem.
>=20
>> What I want to ask is how would one achieve a bare minimum but =
real-time communication between two devices over network. I can convert =
my other Xenomai client to EVL. Any improvements over mainline network =
stack would be enough I believe.
>>=20
>=20
> As Paul McKenney put it once, "(hard) real-time is the start of a
> conversation rather than a complete requirement.". What would be the
> requirements in terms of expected bandwidth, worst case latency, =
jitter,
> packet ordering guarantee ?
>=20
> --=20
> Philippe.


