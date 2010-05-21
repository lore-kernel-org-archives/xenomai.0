MIME-Version: 1.0
In-Reply-To: <4BF6316B.6030305@domain.hid>
References: <AANLkTil5O99TYi2HF9QsN2kz8em4pFiJXTAmteBoee1Z@mail.gmail.com>
	<4BF50C56.5040307@domain.hid>
	<AANLkTikSzbCnuC3Y2eki4pAPaQH2mzAD_l_90W1Twnc-@domain.hid>
	<4BF6316B.6030305@domain.hid>
Date: Fri, 21 May 2010 15:36:58 +0800
Message-ID: <AANLkTilFsG2J4zSfm5TIqzFJU3eRGvnkC3NRzbWNXRF5@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to compile xenomai examples?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Your suggestions seems working.

DESTDIR=3D/media/Angstrom make XENO=3D/media/Angstrom/usr/xenomai ARCH=3DAR=
M
SRC=3D/home/everett/tmp/xenomai-2.5.3/ksrc
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead
--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
arm-none-linux-gnueabi-gcc -I/media/Angstrom/usr/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
-L/media/Angstrom/usr/xenomai/lib -lxenomai -lpthread  -lnative -lrtdm
-Xlinker -rpath -Xlinker /media/Angstrom/usr/xenomai/lib  cross-link.c
  -o cross-link
root@domain.hid# ls
cross-link  cross-link.c  Makefile

It produced a cross-link file. I also tried to make in the examples
directory with
similar result for all the examples.

Thanks a lot and have a nice weekend,

Everett

On Fri, May 21, 2010 at 3:08 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi Gilles,
>>
>> Thanks for your kind reply. If I do that, the result is similar:
>>
>> make XENO=3D/media/Angstrom/usr/xenomai ARCH=3Darm
>> KSRC=3D/home/everett/tmp/xenomai-2.5.3/ksrc
>
> try:
> DESTDIR=3D/media/Angstrom make XENO=3D/media/Angstrom/usr/xenomai ARCH=3D=
ARM SRC=3D/home/everett/tmp/xenomai-2.5.3/ksrc
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

