MIME-Version: 1.0
In-Reply-To: <AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
	<4CC5603E.1090707@domain.hid> <4CC566A2.2000702@domain.hid>
	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
Date: Mon, 25 Oct 2010 18:24:40 +0200
Message-ID: <AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
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
> Hey guys,
>

[...]

> @Eric:
> I still haven't managed to disable SPARSEMEM. From what I understand, in
> order to disable SPARSEMEM I have to disable options that "selects:
> SPARSEMEM". MEMORY_HOTPLUG_SPARSE depends on SPARSEMEM, disabling/enablin=
g
> it does not get me closer to be able to disable SPARSEMEM, does it ?

The MEMORY_HOTPLUG_SPARSE dependency was just an example.
You may have several other options depending on it (I don't know the
full list of them).

In the "Memory model" section of kernel configuration
if you chose "FLAT" memory model it should disable any "SPARSEMEM_xx"
option alltogether.

However as stated by Jan, your problem does not seem to be in this area
may be you should first upgrade to 2.6.35 and then tweak more kernel
options if the problem persist.

--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

