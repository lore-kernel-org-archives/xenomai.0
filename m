From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
	<000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
	<4EFB0D66.8060306@domain.hid>
	<000801ccc580$d9117ef0$8b347cd0$@soterem.fr>
	<4EFB4BC9.4050903@domain.hid>
In-Reply-To: <4EFB4BC9.4050903@domain.hid>
Date: Thu, 29 Dec 2011 15:04:59 +0100
Message-ID: <000001ccc632$da3d80f0$8eb882d0$@soterem.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: fr
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'xenomai-help' <xenomai@xenomai.org>

Hi,

> Examples are broken in 2.6.0, will be fixed in 2.6.1.

Is there just a way to avoid these 'undefined reference' errors ?=20

Thanks , Gregory

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=C3=A9 : mercredi 28 d=C3=A9cembre 2011 18:03
=C3=80 : Gregory Gosse
Cc : 'Philippe Gerum'; 'xenomai-help'; Christophe@domain.hid
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

On 12/28/2011 05:50 PM, Gregory Gosse wrote:
>> cd  /usr/src/xenomai-2.6.0/examples/native
>=20
>> make

Examples are broken in 2.6.0, will be fixed in 2.6.1.

> And
>=20
>> cd /usr/xenomai/bin
>=20
>> apt-get install rt-tests

rt-tests are testing real-time capabilities of the linux kernel, not of =
xenomai.

If you are interested in a test which measures latency, run the =
"latency" test.

The intel paper you cited contains a list of the tests xenomai contains.

--=20
                                                                Gilles.


