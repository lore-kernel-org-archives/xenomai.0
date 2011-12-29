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
	<000001ccc632$da3d80f0$8eb882d0$@soterem.fr>
	<4EFC753D.90005@domain.hid>
	<000101ccc638$7aff1f30$70fd5d90$@soterem.fr>
	<4EFC7EC8.2040805@domain.hid>
In-Reply-To: <4EFC7EC8.2040805@domain.hid>
Date: Thu, 29 Dec 2011 16:13:30 +0100
Message-ID: <000201ccc63c$6c68d9d0$453a8d70$@soterem.fr>
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

Ok I try that  . Thanks

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=C3=A9 : jeudi 29 d=C3=A9cembre 2011 15:53
=C3=80 : Gregory Gosse
Cc : 'Philippe Gerum'; 'xenomai-help'
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

On 12/29/2011 03:45 PM, Gregory Gosse wrote:
> No . What i wanted to do , starting from the examples, is write=20
> rapidly a simple program that perform periodically a task like writing =

> on the serial port . And verify physically what happens.

Running the latency test under load an hour or two is recommended, to =
check if your platform has no issues.

Other than that, in order to compile the examples, you should read this =
page:
http://www.xenomai.org/index.php/Examples

The following patch fixes some compilation issues, but even without this =
patch some of the examples do compile. The "unresolved references"=20
you get are probably due to some missing arguments on make command line.

http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommitdiff_plain;h=3D87ac=
1c1f32181b5bcf4961aea30b9df34ba8a7ce;hp=3D472c85b997a5ab72355dd831af3a611=
83d371a83

--=20
                                                                Gilles.


