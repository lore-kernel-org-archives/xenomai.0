Message-ID: <4D8347A4.7080303@domain.hid>
Date: Fri, 18 Mar 2011 12:53:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>
In-Reply-To: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and select() function - don't work
	correctly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

Jens K=C3=B6hler wrote:
> Hello,
>=20
> on my atom processor based computer is Xenomai installed. (Kernel 2.6.2=
6,
> 1000Hz, Xenomai 2.4.10, PREEMPT patch, no xenomai application running).=

>=20
> A normal linux application reads serial data from an UART
> (16550A) and checks by select() function if there are new received
> bytes. Select() has a timeout parameter, set to 12 milliseconds. Some t=
imes
> it happens that select() waits 43 ms instead of maximum 12 ms. Result v=
alue
> of select() is timeout instead of "byte received". Could this caused by=

> Xenomai?

Run the same test without enabling Xenomai in the kernel configuration,
and you will know.

> How could I improve it?

Well basically, you are complaining that Linux is not real-time. We know
that, this is the reason why real-time extensions such as Xenomai or
preempt_rt exist.

--=20
                                                                Gilles.


