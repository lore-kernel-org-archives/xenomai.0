MIME-Version: 1.0
Date: Mon, 21 Jul 2008 16:41:52 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <783552d428d22a5abdf49c868190b52d@domain.hid>
References: <783552d428d22a5abdf49c868190b52d@domain.hid>
Message-ID: <b1eafd0be71fdcb22fed5aa2c2395df4@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


On Thu, 17 Jul 2008 09:49:19 +0200, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi,
>=20
> I have a problem with xntbase_update(wind_tbase,1000000); because it
> doesn't give me a 1ms period. The period is given as a count of
> nanoseconds
> as it is said in the API documentation. I search solution around
> tick/nanoseconds conversion or periodic/aperiodic timebase but I didn't
> solve my problem. Moreover, when I call this instruction,
> /proc/xenomai/timebases gives me a vxworks resolution of 1000000, what =
is
> correct, but the period seem's to be 0.452ms . Could you tell me what
I've
> done wrong ?
>=20
> Thank you.
>=20
> Matthieu.
>=20
>=20

Hi,

As I have no news, I would like to know if there is any solution to this
problem ?

PS : I also have no return concerning xntbase_bind/unbind implementation.
Is it still planned ?

Thank you in advance for your answers

Matthieu

>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



