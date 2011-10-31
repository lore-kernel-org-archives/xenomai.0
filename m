Message-ID: <4EAEA3A5.4050502@domain.hid>
Date: Mon, 31 Oct 2011 14:33:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjM=7aZPLifemq7v2QUzr9HxkU=GxDNFbxH6G+R6z2kQMUA@mail.gmail.com>	<CAAeYjMkmDOLgEdGYPBmyWSPOCaOqWhnC+exeAg6ERzhp8uWkdg@domain.hid>	<CAAeYjMn83FgbqTZRB7E_S4FHP11V-tzdP1eNcY6+n2DJ2SmrGw@domain.hid>	<4EAE9EDE.5030501@domain.hid>
	<CAAeYjMnGFw8GZEkb_qUoa_wxoCzmNLa=+E_bfZESuQ9TPS8_nw@domain.hid>
In-Reply-To: <CAAeYjMnGFw8GZEkb_qUoa_wxoCzmNLa=+E_bfZESuQ9TPS8_nw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] configuring user-space xenomai 2.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 10/31/2011 02:23 PM, =C5=81ukasz Sacha wrote:
> I used the toolchain from codesourcery
> (http://www.codesourcery.com/sgpp/lite/arm/portal/package3696/public/ar=
m-none-linux-gnueabi/arm-2008q3-72-arm-none-linux-gnueabi-i686-pc-linux-g=
nu.tar.bz2).
> The one downloaded from the ubuntu repos behaves the same way.

Something is broken in you environment, like an environment variable set
or a wrapper script intercepting the arm-none-linux-gnueabi-gcc command.
Because codesourey toolchains work, there is no doubt about that. 2008q3
is a bit old, but it works, no matter the number of -march=3Darmv4t on th=
e
command line.

--=20
                                                                Gilles.


