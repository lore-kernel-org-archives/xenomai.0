References: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [EVL][dovetail] Minimum requirements for network communication
 for RPi 4B and amd64
Date: Mon, 08 Nov 2021 08:59:58 +0100
In-reply-to: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
Message-ID: <878rxzt578.fsf@xenomai.org>
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


Deniz U=C4=9Fur via Xenomai <xenomai@xenomai.org> writes:

> Greetings Xenomai community,
>
> For the past year I have been using EVL to develop some real-time apps
> utilizing fast data acquisition through SPI interfaces on RPi 4B. I
> then send the collected data through mainline network stack to a amd64
> machine running Xenomai 3.1. The data I=E2=80=99m sending is sensitive and
> cannot afford packet drops. By that I mean even if I use UDP I would
> have to wait for next successful packet to continue.

Providing a basic sliding window mechanism between UDP/packet peers may
be an option.

> So in that case,
> I guess, TCP without Nagle=E2=80=99s algorithm should be enough.
>

TCP with real-time capabilities would require to set limits on the time
spent in recovery and retransmissions by construction, turning off
packet coalescence may not be enough. With the current networking stack,
this is more of a design issue than an implementation problem.

> What I want to ask is how would one achieve a bare minimum but real-time =
communication between two devices over network. I can convert my other Xeno=
mai client to EVL. Any improvements over mainline network stack would be en=
ough I believe.
>

As Paul McKenney put it once, "(hard) real-time is the start of a
conversation rather than a complete requirement.". What would be the
requirements in terms of expected bandwidth, worst case latency, jitter,
packet ordering guarantee ?

--=20
Philippe.

