MIME-Version: 1.0
References: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
 <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
 <1696334749.1963937.1586394200231@mail.yahoo.com>
 <407df3962dc2476794051dbbc9a1f2de@intel.com>
 <208919926.1955045.1586406010047@mail.yahoo.com>
In-Reply-To: <208919926.1955045.1586406010047@mail.yahoo.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 9 Apr 2020 08:10:35 +0200
Message-ID: <CAFc1U0uuUNKGjz1bP16D0MJARu2ej1jruabZAkg7DqWa5Z1xCg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Why_X11_influences_the_latency_of_xenomai=EF=BC=9F?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alec Ari <neotheuser@ymail.com>
Cc: "Meng, Fino" <fino.meng@intel.com>, Xenomai <xenomai@xenomai.org>

GPU is not RT friendly.
We did several tests for several projects with/without using GPU and
latencies are about 2x higher with GPU.

Here is a discussion with Philippe in 2015 (translated from french) :

"With a GPU, it is often the X driver that has hard IRQ masking sections.
In addition, GPU tend to cause stalls, to optimize traffic on their side,
but not ours.
Then there are the unbreakable cache maintenance instructions sometimes
used by the kernel to manage consistency with the GPU. In short, for sure,
the latency is higher"

Regards


Le jeu. 9 avr. 2020 =C3=A0 06:20, Alec Ari via Xenomai <xenomai@xenomai.org=
> a
=C3=A9crit :

> I'm thinking it's worth as a troubleshooting step to remove the GPU, no
> graphics at all (nor integrated) and do graphics completely over USB and
> see if those spikes come back.
>
> Alec
>
>

--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
