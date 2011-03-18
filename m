Message-ID: <4D83D8B4.7040504@domain.hid>
Date: Fri, 18 Mar 2011 23:12:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>	<4D834AA0.5080402@domain.hid>
	<AANLkTinRc_3RAh9QRy_5TvF635z=SNVNi2cus7to5a+i@domain.hid>
In-Reply-To: <AANLkTinRc_3RAh9QRy_5TvF635z=SNVNi2cus7to5a+i@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and select() function - don't
	work	correctly
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Jens K=C3=B6hler wrote:
> Yes, CONFIG_PREEMPT is set. We will try in first step what happens when=
 it's
> not set.

I am sorry to insist, but IMO, you should try disabling CONFIG_XENOMAI
and CONFIG_IPIPE in the kernel configuration, in order to be sure that
these options are causing what you are seeing.

--=20
                                                                Gilles.


