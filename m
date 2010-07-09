MIME-Version: 1.0
In-Reply-To: <AANLkTilima6OiNDUW_79WeV08NLO-K8jtrcZWnEw8hdT@mail.gmail.com>
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid> 
	<AANLkTikh0wG-xK50wvmfVe0KBB25BKz4k2Ys3O26r7zq@domain.hid> 
	<AANLkTilima6OiNDUW_79WeV08NLO-K8jtrcZWnEw8hdT@mail.gmail.com>
From: Luc ANTOLINOS <luciogistr@domain.hid>
Date: Fri, 9 Jul 2010 11:01:17 +0200
Message-ID: <AANLkTikAhBpWcslqrVLL84tU6DztnR8YYPDekf4gs10b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomia adeos pacht error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

2010/7/9 G=C3=B6rkem Karado=C4=9Fan <gkaradagan@domain.hid>:
> scripts/kconfig/conf -s arch/arm/Kconfig
> make[1]: arm-linux-gcc: Command not found
Make sure you cross compiler is in your path.
export PATH=3D"<path_to_my_cross_compiler>:$PATH"

etc.

--=20
Luc

