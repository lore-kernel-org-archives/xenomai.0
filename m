From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Message-Id: <DD8FF5D6-AF88-4EAB-9E9D-3BA4B9B57CEA@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: RTnet on Raspberry Pi 3B+
Date: Sun, 11 Oct 2020 21:06:00 +0300
In-Reply-To: <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
References: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
 <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>

Hi Pierre,

I=E2=80=99ve just checked out BeagleBone Black and it seems applicable =
for me. If you don=E2=80=99t mind I have some follow-up questions.

Do you know if RTDM SPI works on BB?
Which ipipe, xenomai, and linux version combination is working on the BB =
right now?=20
Are there any recent guides for Xenomai 3 on BB?

Thanks.
Deniz.

> On 11 Oct 2020, at 20:39, Pierre FICHEUX <pierre.ficheux@smile.fr> =
wrote:
>=20
> Hi,
>=20
> Pi Ethernet controller is based on USB, not that good for realtime =
(AMHA)...
>=20
> May you could switch to BeagleBone Black ?
>=20
> regards
>=20
> Le sam. 10 oct. 2020 =C3=A0 10:21, Deniz U=C4=9Fur via Xenomai =
<xenomai@xenomai.org <mailto:xenomai@xenomai.org>> a =C3=A9crit :
> Hello all,
>=20
> I=E2=80=99m currently researching for a real-time sensor data =
acquisition system and I was thinking about using Raspberry Pi 3B+. =
Along with my move to making everything real-time, I also want to =
experiment with RTnet. Although from what I can understand, RPi=E2=80=99s =
ethernet module is not supported in RTnet.
>=20
> Is RPi not supported in RTnet? If not, is there anything I can do to =
bring this feature?
> Do I have any alternative for making TCP socket connection real-time =
using Xenomai on RPi?
> Lastly, If RPi is an impossible target for RTnet, do we have any =
alternative embedded system that works with RTnet?
>=20
> Thanks in advance.
> Deniz.
>=20
> Some important details:
> ARCH: ARM
> SoC: BCM2835
> Linux: 4.14.36
> Xenomai: 3.0.7
> I-Pipe: 4.14.36-arm-1
>=20
>=20
> --=20
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr =
<mailto:pierre.ficheux@smile.fr>
>                              http://www.smile.fr =
<http://www.smile.fr/>
>                              https://smile.eu/fr/offres/embarque-iot =
<https://smile.eu/fr/offres/embarque-iot>
> I would love to change the world, but they won't give me the source =
code

