MIME-Version: 1.0
In-Reply-To: <AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
	<4CC5603E.1090707@domain.hid> <4CC566A2.2000702@domain.hid>
	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
	<AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
Date: Mon, 25 Oct 2010 20:13:21 +0200
Message-ID: <AANLkTi=YWqqF8_iDaCFLBYuP0C3AgQyYo0oP=raU_VfG@mail.gmail.com>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

2010/10/25 Peter Pastor <peter.pastor@domain.hid>:
> Hey Eric,
>
> Thanks for your prompt response. However, I do not have the "FLAT_MEMORY"
> option available. I can only select the sparse memory model.

OK noted, again this does not seem to be the culprit so don't bother
about that until you are sure the problem is coming up again.

> I have upgraded to 2.6.35 and so far the problem has not occured. However=
, I
> haven't used the system much. Again, it seems that a specific event trigg=
ers
> the problem.
>
> Also, can someone tell me whether the ubuntu kernel patch is recommended =
to
> use with Xenomai ? If so, can someone tell me how to get the patch for my
> particular kernel version 2.6.35 ? ( I am sorry if this is the wrong mail=
ing
> list to ask this question )

Using Xenomai I would stay away from distro-specific kernel patches
unless your system does not boot without it.

It's usually easier to track down problems with others if you start
from vanilla kernel.org which can be easilly reproduced by other
without necessarily having the same distro.

--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

