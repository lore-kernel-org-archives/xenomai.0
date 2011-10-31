MIME-Version: 1.0
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Mon, 31 Oct 2011 13:14:21 +0100
Message-ID: <CAAeYjM=7aZPLifemq7v2QUzr9HxkU=GxDNFbxH6G+R6z2kQMUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] configuring user-space xenomai 2.6
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

Hey,

I'm following README_INSTALL from the xenoami 2.6 tree. I successfully
patched and built the kernel 2.6.38.8 and modules. Now I'm trying to
configure the user-space.
I'm running the configure command as given in the example:
./configure CFLAGS=3D"-march=3Darmv4t" LDFLAGS=3D"-march=3Darmv4t"
--host=3Darm-none-linux-gnueabi- --build=3Di686-pc-linux-gnu
I get the following error:
checking build system type... i686-pc-linux-gnu
checking host system type... Invalid configuration
`arm-none-linux-gnueabi-': machine `arm-none-linux-gnueabi' not
recognized
configure: error: /bin/bash config/config.sub arm-none-linux-gnueabi- faile=
d

This is how my environment is setup:
luke@domain.hid$ which
arm-none-linux-gnueabi-gcc
/home/luke/Desktop/moje/mini2440/arm-2008q3/bin/arm-none-linux-gnueabi-gcc
luke@domain.hid$ echo $PATH
/home/luke/Desktop/moje/mini2440/arm-2008q3/bin:/usr/lib/lightdm/lightdm:/u=
sr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

No adequate info in the TROUBLESHOOTING.

Am doing something wrong? Help me out please.

regards,
--
=C5=81ukasz Dragilla Sacha

