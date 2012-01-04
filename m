From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000301cccaed$80667540$81335fc0$@soterem.fr>
	<4F046865.9000408@domain.hid>
In-Reply-To: <4F046865.9000408@domain.hid>
Date: Wed, 4 Jan 2012 17:22:53 +0100
Message-ID: <000001cccafd$1c6046b0$5520d410$@soterem.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: fr
Subject: Re: [Xenomai-help] unresolved symbol - check the xenomai
	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I tried to install xenomai 2.4.4 but didn't go too far ( unable to =
prepare the kernell )
Then I switched directly to 2.6.0 . Never used the 2.5 branch

The latency test gives me that:
# /usr/xenomai/bin/latency -t0 -p200 -f -T50=20
Sampling period: 200 us=20
Test mode: periodic user-mode task=20
All results in microseconds=20
Minuterie d'alerte

>That is the output of xeno-test from the 2.5 branch, so, you probably =
mixed two xenomai installations.
>Also, as I already told you, a simple way to know if xenomai is =
correctly installed is to run the latency test.
Gilles.


