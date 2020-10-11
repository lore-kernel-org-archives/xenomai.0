MIME-Version: 1.0
References: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
In-Reply-To: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sun, 11 Oct 2020 19:39:54 +0200
Message-ID: <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
Subject: Re: RTnet on Raspberry Pi 3B+
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
To: =?UTF-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

Pi Ethernet controller is based on USB, not that good for realtime (AMHA)..=
.

May you could switch to BeagleBone Black ?

regards

Le sam. 10 oct. 2020 =C3=A0 10:21, Deniz U=C4=9Fur via Xenomai <xenomai@xen=
omai.org>
a =C3=A9crit :

> Hello all,
>
> I=E2=80=99m currently researching for a real-time sensor data acquisition=
 system
> and I was thinking about using Raspberry Pi 3B+. Along with my move to
> making everything real-time, I also want to experiment with RTnet. Althou=
gh
> from what I can understand, RPi=E2=80=99s ethernet module is not supporte=
d in RTnet.
>
> Is RPi not supported in RTnet? If not, is there anything I can do to brin=
g
> this feature?
> Do I have any alternative for making TCP socket connection real-time usin=
g
> Xenomai on RPi?
> Lastly, If RPi is an impossible target for RTnet, do we have any
> alternative embedded system that works with RTnet?
>
> Thanks in advance.
> Deniz.
>
> Some important details:
> ARCH: ARM
> SoC: BCM2835
> Linux: 4.14.36
> Xenomai: 3.0.7
> I-Pipe: 4.14.36-arm-1
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
